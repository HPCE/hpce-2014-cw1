function prepare_submission()

fprintf('Preparing submission.\n');
fprintf('  Note: these simple tests only check file-name and basic syntax,\n');
fprintf('  they do _not_ check that all functionality is correct.\n\n');

files={...
       {'E1.1', '+timing', 'function_time.m',{...
          'f=@()( sin(1) );  timing.function_time(f);',...
          'timing.function_time(@()( randn(1000)*randn(1000) ) );'...
    }},{'E1.2', '+timing', 'function_time_against_n.m',{...
          'f=@(n)( randn(n).^2 ); timing.function_time_against_n(f, 1:20);',...
          '[ts,ns]=timing.function_time_against_n(@(n)( randn(10)^n) , 1:20);'...
    % Note, this originally was listed as e1_2_comparison.pdf in readme.md
    }},{'E1.2', 'figures', 'e1_2_scaling.pdf',{...
    }},{'E2.1', '+effects','scharr_scalar.m',{...
          'effects.scharr_scalar(zeros(3));',...
          'render.apply_scalar( @effects.scharr_scalar, 1, rand(10) );'...
    }},{'E2.2', '+effects','median_scalar.m',{...
          'effects.median_scalar(zeros(3));',...
          'effects.median_scalar(zeros(5));',...
          'render.apply_scalar( @effects.median_scalar, 2, rand(10) );'...
    }},{'E2.2', 'figures','e2_2_median_window_scaling.pdf',{...
    }},{'E2.3', '+effects','render_blur.m',{...
          '[out]=effects.render_blur(rand(10));'...
    }},{'E2.3', 'figures','e2_3_abstraction_cost.pdf',{
    }},{'E3.1', '+render','apply_scalar_par_inner.m',{...
          'render.apply_scalar_par_inner( @effects.invert_scalar, 0, rand(50) );'
    }},{'E3.1', 'figures','e3_1_median_scaling.pdf',{
    }},{'E3.2', '+render','apply_scalar_par_outer.m',{...
          'render.apply_scalar_par_outer( @effects.invert_scalar, 0, rand(50) );'
    }},{'E3.2', 'figures','e3_2_scaling_versus_aspect.pdf',{
    }},{'E4.1', '+render','apply_vector_rows.m',{...
          'render.apply_vector_rows( @(x)(1-x), 0, rand(50) );'
    }},{'E4.1', 'figures','e4_1_vector_speedup.pdf',{
    }},{'E4.2', '+effects','scharr_vector.m',{
        'out=render.apply_vector_rows( @effects.scharr_vector, 1, rand(100) );'
    }},{'E4.2', 'figures','e4_2_scharr_scaling.pdf',{
    }},{'E4.3', '+effects','median_vector_fake.m',{
        'out=render.apply_vector_rows(@effects.median_vector_fake, 7, rand(100));'
    }},{'E4.3', 'figures','e4_3_median_fake_scaling.pdf',{
    }},{'E4.4', '+effects','median_vector.m',{
        'out=render.apply_vector_rows(@effects.median_vector, 7, rand(100));'
    }},{'E4.4', 'figures','e4_4_median_vector_scaling.pdf',{
    }},{'E5.1', '+render','apply_vector_rows_par_outer.m',{
        'out=render.apply_vector_rows_par_outer(@effects.median_vector, 7, rand(100));'
    }},{'E5.1', 'figures','e5_1_simple_par_vec_scaling.pdf',{
    }},{'E5.2', '+render','apply_vector_rows_par_coarse.m',{
        'out=render.apply_vector_rows_par_coarse(@effects.median_vector, 7, rand(100));'
    }},{'E5.2', 'figures','e5_2_par_chunked.pdf',{
    }},{'E5.3', '+render','apply_vector_opt.m',{
        'out=render.apply_vector_opt(@effects.median_vector, 2, rand(100));'
    }}
};

tests=0;
passed=0;

to_zip={...
    'prepare_submission.m'...
};

for ti=1:length(files)
    tests=tests+1;
    
    test=files{ti};
    ex=test{1}; package=test{2}; name=test{3}; 
    sFile=strcat(package,'/',name);
    if ~exist(sFile,'file')
        fprintf('%s : File "%s" does not exist.\n', ex, sFile);
        continue;
    end
    to_zip{end+1}=sFile;
    
    ok=1;
    inputs=test{4};
    for ii=1:length(inputs)
        input=inputs{ii};
        try
            eval(input);
        catch e
            fprintf('%s : Test failed\n    Input:   %s\n    Exception:   %s\n"\n', ex, input, e.message);
            ok=0;
        end
    end
    if ok
        passed=passed+1;
    end
end

fprintf('%d out of %d tests passed.\n', passed, tests);

% The exact user name is not critical, it is mainly to help students
% identify their submission file
user=get_user_name();
output=sprintf('hpce_cw1_%s.zip',user);
fprintf('Creating submission zip file "%s"...', output);
zip(output, to_zip);
fprintf('done\n');

end

function [s]=get_user_name()
    s=char(java.lang.System.getProperty('user.name'));
end