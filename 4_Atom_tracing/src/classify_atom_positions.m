function labels = classify_atom_positions(RecVol, atom_pos, IntensityCenters, IntensityHalfWidth)
% Classify the traced peaks by their local intensity profiles.

% Use the larger neighborhood for comparison and the smaller one for seeding.
ds = 1 / 3;
[x, y, z] = sphere_offsets(9 / 3, ds);
[seedX, seedY, seedZ] = sphere_offsets(5 / 3, ds);
numAtoms = size(atom_pos, 2);
points = zeros(numel(x), numAtoms);
integratedIntensity = zeros(1, numAtoms);
batchSize = 1500;
for first = 1:batchSize:numAtoms
    columns = first:min(first + batchSize - 1, numAtoms);
    coords = atom_pos(:, columns);
    values = interp3(RecVol, y + coords(2,:), x + coords(1,:), z + coords(3,:), 'cubic');
    values(~isfinite(values)) = 0;
    points(:, columns) = values;

    seedValues = splinterp3(RecVol, seedY + coords(2,:), seedX + coords(1,:), seedZ + coords(3,:));
    seedValues(~isfinite(seedValues)) = 0;
    integratedIntensity(columns) = sum(seedValues, 1);
end

numSpecies = numel(IntensityCenters);
avg_atom = zeros(size(points, 1), numSpecies);
for k = 1:numSpecies
    selected = abs(integratedIntensity - IntensityCenters(k)) < IntensityHalfWidth;
    avg_atom(:, k) = sum(points(:, selected), 2) / nnz(selected);
end
avg_atom(isnan(avg_atom)) = 0;

labels = ones(1, numAtoms);
distances = zeros(numSpecies, 1);
while true
    old_labels = labels;
    for n = 1:numAtoms
        profile = points(:, n);
        total = sum(profile);
        if total == 0
            labels(n) = 1;
        else
            for k = 1:numSpecies
                distances(k) = norm(profile - avg_atom(:, k), 1) / total;
            end
            [~, labels(n)] = min(distances);
        end
    end

    for k = 2:numSpecies
        selected = labels == k;
        avg_atom(:, k) = sum(points(:, selected), 2) / nnz(selected);
    end
    avg_atom(:, 1) = 0; % Use a zero profile for non-atoms after the first pass.
    avg_atom(isnan(avg_atom)) = 0;
    if isequal(old_labels, labels)
        break;
    end
end
end


function [x, y, z] = sphere_offsets(radius, spacing)
offsets = -radius:spacing:radius;
[x, y, z] = ndgrid(offsets);
inside = x.^2 + y.^2 + z.^2 <= (radius + 0.5 * spacing)^2;
x = x(inside);
y = y(inside);
z = z(inside);
end
