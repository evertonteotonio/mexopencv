classdef TestFAST
    %TestFAST
    properties (Constant)
        img = imread(fullfile(mexopencv.root(),'test','tsukuba_l.png'));
        kfields = {'pt', 'size', 'angle', 'response', 'octave', 'class_id'};
    end

    methods (Static)
        function test_detect_img
            kpts = cv.FAST(TestFAST.img, ...
                'Threshold',10, 'NonmaxSuppression',true);
            validateattributes(kpts, {'struct'}, {'vector'});
            assert(all(ismember(TestFAST.kfields, fieldnames(kpts))));
        end

        function test_detect_types
            types = {'TYPE_5_8', 'TYPE_7_12', 'TYPE_9_16'};
            for i=1:numel(types)
                kpts = cv.FAST(TestFAST.img, 'Type',types{i});
                validateattributes(kpts, {'struct'}, {'vector'});
            end
        end

        function test_error_1
            try
                cv.FAST();
                throw('UnitTest:Fail');
            catch e
                assert(strcmp(e.identifier,'mexopencv:error'));
            end
        end
    end

end