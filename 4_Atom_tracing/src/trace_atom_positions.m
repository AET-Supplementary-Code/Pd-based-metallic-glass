function atom_pos = trace_atom_positions(RecVol, Dmin, MaxNumberPeaks, SearchRad, Th, MaxIter, CritIter)
% Trace peaks on the threefold oversampled reconstruction.

FinalVol = prepare_tracing_volume(RecVol);
maxXYZ = find_peak_positions(FinalVol, MaxNumberPeaks, Th);

% Fourth-order polynomial terms, in the original fitting order
Orders = zeros(35, 3);
term = 0;
for i = 0:4
    for j = 0:4-i
        for k = 0:4-i-j
            term = term + 1;
            Orders(term, :) = [i, j, k];
        end
    end
end
initialCoeff = -double(max(Orders, [], 2) == 4);

offset = -SearchRad:SearchRad;
[X, Y, Z] = ndgrid(offset);
sphere = X.^2 + Y.^2 + Z.^2 <= (SearchRad + 0.5)^2;
XYZdata = struct('X', X(sphere), 'Y', Y(sphere), 'Z', Z(sphere));

Q = 0.5;
opts = optimset('Display', 'off');
TotPosArr = zeros(size(maxXYZ));
exitFlagArr = zeros(size(maxXYZ, 1), 1);
for i = 1:size(maxXYZ, 1)
    peak = maxXYZ(i, :);
    cropVol = FinalVol(peak(1) + offset, peak(2) + offset, peak(3) + offset);
    peakValues = cropVol(sphere);
    pos = [0, 0, 0];
    coeff = initialCoeff;
    consecutive = 0;
    finished = false;
    iteration = 0;
    while ~finished
        iteration = iteration + 1;
        if iteration > MaxIter
            exitFlagArr(i) = -4;
            finished = true;
        end

        weight = exp(-((XYZdata.X-pos(1)).^2 + (XYZdata.Y-pos(2)).^2 ...
            + (XYZdata.Z-pos(3)).^2) / SearchRad^2);
        fun = @(p, data) calculate_3D_polynomial_Rogers( ...
            data.X, data.Y, data.Z, pos, Orders, p) .* weight;
        coeff = lsqcurvefit(fun, coeff, XYZdata, peakValues .* weight, [], [], opts);
        [dX, dY, dZ] = calc_dX_dY_dZ_Rogers(Orders, coeff);

        if all([dX, dY, dZ] == -100)
            exitFlagArr(i) = -1;
            break;
        end

        shift = min(max([dX, dY, dZ], -Q), Q);
        pos = pos + shift;
        if max(abs(pos)) > SearchRad
            exitFlagArr(i) = -2;
            break;
        end

        if max(abs(shift)) < Q
            consecutive = consecutive + 1;
            if consecutive == CritIter
                candidate = peak + pos;
                accepted = TotPosArr(1:i-1, :);
                accepted = accepted(exitFlagArr(1:i-1) == 0, :);
                distances = sqrt(sum((accepted-candidate).^2, 2));
                if any(distances < Dmin)
                    exitFlagArr(i) = -3;
                else
                    TotPosArr(i, :) = candidate;
                end
                break;
            end
        else
            consecutive = 0;
        end
    end
end

% Undo the threefold oversampling and the padding offset.
atom_pos = TotPosArr(exitFlagArr == 0, :)' / 3 - 2;
end


function FinalVol = prepare_tracing_volume(RecVol)
% Evaluate the original spline on successive slabs of the padded volume.
inputSize = size(RecVol);
grid = cell(1, 3);
query = cell(1, 3);
for dim = 1:3
    n = inputSize(dim);
    grid{dim} = (1:n) - round((n + 1) / 2);
    query{dim} = (3 * grid{dim}(1) + 2 : 3 * grid{dim}(end)) / 3;
end

% Match the interp3 meshgrid axis order and use double storage for fitting.
F = griddedInterpolant(grid([2, 1, 3]), permute(RecVol, [2, 1, 3]), 'spline', 'none');
querySize = cellfun(@numel, query);
padding = 10;
FinalVol = zeros(querySize + 2 * padding);
row = padding + (1:querySize(1));
column = padding + (1:querySize(2));
slabDepth = 16;
for first = 1:slabDepth:querySize(3)
    layers = first:min(first + slabDepth - 1, querySize(3));
    [Y, X, Z] = ndgrid(query{2}, query{1}, query{3}(layers));
    values = F(Y, X, Z);
    FinalVol(row, column, padding + layers) = permute(values, [2, 1, 3]);
    clear X Y Z values
end
end


function maxXYZ = find_peak_positions(FinalVol, MaxNumberPeaks, Th)
% Include neighboring slices when evaluating the dilation near a slab edge.
volumeSize = size(FinalVol);
layerSize = prod(volumeSize(1:2));
se = strel3d(3);
slabDepth = 16;
firstLayers = 1:slabDepth:volumeSize(3);
indices = cell(numel(firstLayers), 1);
for batch = 1:numel(firstLayers)
    first = firstLayers(batch);
    last = min(first + slabDepth - 1, volumeSize(3));
    rangeStart = max(1, first-1);
    rangeEnd = min(volumeSize(3), last+1);
    slab = FinalVol(:, :, rangeStart:rangeEnd);
    dilated = imdilate(slab, se);
    core = (first:last) - rangeStart + 1;
    values = slab(:, :, core);
    indices{batch} = find(values == dilated(:, :, core) & values > Th) ...
        + (first-1) * layerSize;
end

maxPos = vertcat(indices{:});
[~, order] = sort(FinalVol(maxPos), 'descend');
maxPos = maxPos(order(1:min(MaxNumberPeaks, numel(order))));
[x, y, z] = ind2sub(volumeSize, maxPos);
maxXYZ = [x, y, z];
end
