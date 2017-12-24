% Analizes the results of the algorithm
function processResults()
    count = 0;
    maxR = 0;
    maxDev = 0;
    maxLambdaDev = 0;
    for i=5:20
        for j=i:min(i+3,20)
            load(['\\mnetapp02\itays\OneLayerGDConvergence\results\exp-' num2str(i) '-' num2str(j) '.mat'])
            if ~isempty(Wbad)
                %fprintf([num2str(i) ' ' num2str(j) '\n']);
                count = count + 1;
                load(['\\mnetapp02\itays\OneLayerGDConvergence\results\expDbl-' num2str(i) '-' num2str(j) '.mat'])
                %avgGnorm(count) = froNorm(g(W, V));
                n(count) = i;
                k(count) = j;
                %globalMagnitude = 1000-sum(magnitude);
                %magnitude = [magnitude, globalMagnitude];
                unverifiable(count) = sum(magnitude(r<0))/1000;
                magnitude = magnitude(r>0);
                objVals = objVals(r>0);
                lambdaMin = lambdaMin(r>0);
                deviations = deviations(r>0);
                maxFroDiff = maxFroDiff(r>0);
                r = r(r>0);
                
                avgLambdaMin(count) = dot(magnitude, lambdaMin)/sum(magnitude);
                avgRadius(count) = dot(magnitude, r)/sum(magnitude);
                avgDev(count) = dot(magnitude, deviations)/sum(magnitude);
                avgObjVals(count) = dot(magnitude, objVals)/sum(magnitude);
                prNonGlobal(count) = sum(magnitude)/1000;
                maxR = max(maxR, max(r+maxFroDiff));
                maxDev = max(maxDev, max(deviations));
                for m=1:length(maxFroDiff)
                    maxLambdaDev = max(maxLambdaDev, maxthirdderivative(WbadNew(:,:,m), targetVals(size(WbadNew, 1)+1, i), r(m)) * r(m));
                end
                %badMinima(count) = sum(max(0,sign(r)).*magnitude)/1000;
                %check = objVals(objVals>0);
                %assert(min(check)>0.01);
                
            end
        end
    end
    fprintf('Saving data\n');
    %load('\\mnetapp02\itays\OneLayerGDConvergence\results\expResults.mat')
    pathname = fileparts('\\mnetapp02\itays\OneLayerGDConvergence\results\');
    fileName = ['expResults.mat'];
    matfile = fullfile(pathname, fileName);
    save(matfile, 'avgLambdaMin', 'avgRadius', 'avgObjVals', 'avgDev', 'n', 'k', 'prNonGlobal', 'maxR', 'unverifiable', 'maxDev', 'maxLambdaDev');
end