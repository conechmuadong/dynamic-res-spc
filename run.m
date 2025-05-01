directory = "example";
examples = dir(directory);
examples = {examples.name};
examples = examples(3:length(examples));
eva = java.util.ArrayList();
for i = 1:length(examples)
    for j = 9:10
        [out, image, eval] = simulator("example/"+examples(i), 8, 64, j*5);
        eva.add(eval);
    end
end

% Test the phantom image

[out, image, eval] = simulator("phantom", 8, 64, j*5);
eva.add(eval);
