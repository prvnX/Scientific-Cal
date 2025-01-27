function scientific_calculator()
    global last_answer;
    last_answer = 0;
    %figure
    fig = figure('Position', [200, 100, 475, 790], 'Name', 'Scientific Calculator','NumberTitle', 'off', 'Color', [0.6, 0.6, 0.6]);

    % result box
    result_box = uicontrol('Style', 'edit', 'Position', [20, 650, 445, 100], ...
        'FontSize', 35, 'Enable', 'inactive', 'HorizontalAlignment', 'right', ...
        'BackgroundColor', [1, 1, 1]');

    %title box
    uicontrol('Style', 'edit', 'Position', [20, 750, 445, 40], ...
        'FontSize', 20, 'Enable', 'inactive', 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.6, 0.6, 0.6],'ForegroundColor', [1.0, 1.0, 0.0],'String','Octave Scientific Calculator ');

    % buttons
    button_labels = {
                     'sin', 'cos', 'tan', 'rad','deg' ...
                     'asin', 'acos', 'sinh','∫dx', 'dy/dx', ...
                     'nCr','nPr','LCM','GCD','log10', ...
                     '√','ln','eˣ', 'x²', 'xʸ'...
                     '(', ')', 'DEL', 'AC', 'Ans' ...
                      '7', '8', '9', '/',  '!' ...
                     '4', '5', '6', '*', 'π'...
                     '1', '2', '3', '-', 'X'...
                     '0', '.', '=', '+', ',' ...
                     };

    main_btns ={ '(', ')','7', '8', '9', '/', ...
                     '4', '5', '6', '*', ...
                     '1', '2', '3', '-', ...
                     '0', '.', '=', '+', ...
                  }
    % buttons positions and dimensions
    button_width = 80;
    button_height = 60;
    start_x = 20;
    start_y = 580;
    padding_x = 10;
    padding_y = 10;

    %dynamic button creation
    for i = 1:length(button_labels)
        % calculate button position
        col = mod(i-1, 5);
        row = floor((i-1) / 5);
        x_pos = start_x + col * (button_width + padding_x);
        y_pos = start_y - row * (button_height + padding_y);

        colorMatrix = [0.2, 0.2, 0.2];
        if (strcmp(button_labels{i}, "AC") || strcmp(button_labels{i},"DEL"))
            colorMatrix = [1, 0.4, 0.4];
        elseif strcmp(button_labels{i}, "=")
            colorMatrix = [0.45, 0.45, 0.45];
        elseif ismember(button_labels{i},main_btns)
            colorMatrix = [0.3, 0.3, 0.3];

        end

        % Create the button
        uicontrol('Style', 'pushbutton', 'String', button_labels{i}, ...
            'Position', [x_pos, y_pos, button_width, button_height], ...
            'FontSize', 16, 'BackgroundColor', colorMatrix, 'ForegroundColor', [1, 1, 1], ...
            'Callback', @(src, event) button_callback(src, result_box));
    end

    % Callback function
    function button_callback(src, result_box)
        current_text = get(result_box, 'String');
        label = get(src, 'String');

        if strcmp(label, '=')
            try
                if ~isempty(strfind(current_text,"C"))  %nCr evaluate
                  parts = strsplit(current_text, "C");
                  n = str2double(parts{1});
                  r = str2double(parts{2});
                  result = factorial(n) / (factorial(r) * factorial(n - r))
                  last_answer = result;

                elseif ~isempty(strfind(current_text,"P")) %nPr evaluate
                  parts = strsplit(current_text, "P");
                  n = str2double(parts{1});
                  r = str2double(parts{2});
                  result = factorial(n) / factorial(n - r);
                  last_answer = result;

                else
                  result = eval(current_text); %evealuate expressions

                endif
                last_answer = result;
                set(result_box, 'String', num2str(result));  % Display result
            catch
                set(result_box, 'String', 'SYNTAX ERROR','ForegroundColor', [1.0, 0, 0]); %error handle
            end
        elseif strcmp(label, '√')
            set(result_box, 'String', ['sqrt(' current_text ')']);
        elseif strcmp(label, 'x²')
            set(result_box, 'String', [current_text '^2']);
        elseif strcmp(label, 'xʸ')
            set(result_box, 'String', [current_text '^']);
        elseif strcmp(label, 'sin')
            set(result_box, 'String', [current_text 'sin(']);
        elseif strcmp(label, 'cos')
            set(result_box, 'String', [current_text 'cos(']);
        elseif strcmp(label, 'tan')
            set(result_box, 'String', [current_text 'tan(']);
        elseif strcmp(label, 'sinh')
            set(result_box, 'String', ['sinh(' current_text ')']);
        elseif strcmp(label, 'asin')
            set(result_box, 'String', ['rad2deg(asin(' current_text '))']);
        elseif strcmp(label, 'acos')
            set(result_box, 'String', ['rad2deg(acos(' current_text '))']);
        elseif strcmp(label, 'rad')
            set(result_box, 'String', [current_text 'deg2rad(']);
        elseif strcmp(label, 'deg')
            set(result_box, 'String', [current_text 'rad2deg(']);
        elseif strcmp(label, 'AC')
            set(result_box, 'String', '');  % All Clear
        elseif strcmp(label, 'π')
            set(result_box, 'String', [current_text 'pi']);
        elseif strcmp(label, '!')
            set(result_box, 'String', ['factorial(' current_text ')']);
        elseif strcmp(label, 'eˣ')
            set(result_box, 'String', ['exp(' current_text ')']);
        elseif strcmp(label, 'ln')
            set(result_box, 'String', ['log(' current_text ')']);
        elseif strcmp(label, 'log10')
            set(result_box, 'String', ['log10(' current_text ')']);
        elseif strcmp(label, 'nCr')
            set(result_box, 'String', [current_text 'C']);
        elseif strcmp(label, 'nPr')
            set(result_box, 'String', [current_text 'P']);
        elseif strcmp(label, 'Ans')
            set(result_box, 'String', [current_text num2str(last_answer)]);
        elseif strcmp(label, '∫dx')
            try
              current_text = strrep(current_text, 'pi', num2str(pi));
              parts = strsplit(current_text, ",");
              a=str2double(parts{2}); %lower limit
              b=str2double(parts{3}); %upper limit
              equation = parts{1};
              equation = strrep(equation, '^', '.^');
              f = str2func(['@(X) ' equation]);
              result = integral(f, a, b);
              last_answer = result;
              set(result_box, 'String', num2str(result));
            catch
              set(result_box, 'String', 'SYNTAX ERROR','ForegroundColor', [1.0, 0, 0]);
            end
         elseif strcmp(label, 'dy/dx')
            try
              current_text = strrep(current_text, 'pi', num2str(pi));
              parts = strsplit(current_text, ",");
              a=str2double(parts{2}); %x limit
              x_vals = linspace(0, a);
              equation = parts{1};
              equation = strrep(equation, '^', '.^');
              f = str2func(['@(X) ' equation]);
              y_vals = f(x_vals);
              dy_dx = diff(y_vals) ./ diff(x_vals);
              result = dy_dx(end);
              last_answer = result;
              set(result_box, 'String', num2str(result));
            catch
              set(result_box, 'String', 'SYNTAX ERROR','ForegroundColor', [1.0, 0, 0]);
            end

          elseif strcmp(label, 'DEL')  % Delete
            if ~isempty(current_text)
              for i = numel(button_labels):-1:1
                  keyword = button_labels{i};
                  if endsWith(current_text, keyword)
                        current_text = current_text(1:end - length(keyword));
                        set(result_box,"String",current_text)
                    return;
                  end
              end
                % Remove the last character from the text
                current_text = current_text(1:end-1);
                set(result_box, 'String', current_text);
            end

          elseif strcmp(label, 'GCD')
           try
              parts = strsplit(current_text, ",");
              a=str2double(parts{1});
              b=str2double(parts{2});
              result=gcd(a,b);
              last_answer = result;
              set(result_box, 'String', num2str(result));
           catch
               set(result_box, 'String', 'SYNTAX ERROR');
           end

          elseif strcmp(label, 'LCM')
            try
              parts = strsplit(current_text, ",");
              a=str2double(parts{1});
              b=str2double(parts{2});
              result=lcm(a,b);
              last_answer = result;
              set(result_box, 'String', num2str(result));
            catch
              set(result_box, 'String', 'SYNTAX ERROR');
            end

        else
            set(result_box, 'String', [current_text label]);
        end
    end

    %sub title
    uicontrol('Style', 'edit', 'Position', [20, 3, 445, 15], ...
        'FontSize', 8, 'Enable', 'inactive', 'HorizontalAlignment', 'center', ...
        'BackgroundColor', [0.6, 0.6, 0.6],'ForegroundColor', [1, 1, 1],'String','Made with 🤍 by prvnX');
end
