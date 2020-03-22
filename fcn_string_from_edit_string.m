% want to make this function more robust and use regex as much as possible
% if we have \d( then add .* except for atan2, log10, log2, pow2
% what about: pi sin(x)

function [ fcn_string ] = fcn_string_from_edit_string2(edit_string)
%edit_string = '3*x.^2+4'
if ~isempty(edit_string)
    edit_string = [edit_string ' + 0.*x']; % make sure plotting constants works, i.e. add 0*x
end
fcn_string = edit_string;

% functions that end with a number
fcn_string = strrep(fcn_string, 'atan2', 'ATANTWOREP');
fcn_string = strrep(fcn_string, 'log10', 'LOGTENREP');
fcn_string = strrep(fcn_string, 'log2', 'LOGTWOREP');
fcn_string = strrep(fcn_string, 'pow2', 'POWTWOREP');

%fcn_string = regexprep(fcn_string, '([^a-zA-Z])pi ', '$1.*PIREP ');
%fcn_string = regexprep(fcn_string, ' pi([^a-zA-Z])', ' PIREP.*$1');

fcn_string = regexprep(fcn_string, 'pi\s+([\w\(])', 'pi.*$1'); %pi followed by one ore more spaces followed by...
fcn_string = regexprep(fcn_string, '([\w\)])\s+pi', '$1.*pi'); %

fcn_string = regexprep(fcn_string, '([a-zA-Z])\s+([a-zA-Z])', '$1.*$2'); % x log(x)



% remove all spaces
fcn_string = strrep(fcn_string, ' ', '');

% remove dots
fcn_string = strrep(fcn_string, '.^', '^');
fcn_string = strrep(fcn_string, '.*', '*');
fcn_string = strrep(fcn_string, './', '/');

% add dots
fcn_string = strrep(fcn_string, '^', '.^');
fcn_string = strrep(fcn_string, '*', '.*');
fcn_string = strrep(fcn_string, '/', './');

% 3x 
fcn_string = regexprep(fcn_string, '(\d)([a-zA-Z\(])', '$1.*$2'); % number followed by letter or (

% pi4 or x4
fcn_string = regexprep(fcn_string, '([a-zA-Z])(\d)', '$1.*$2'); % letter followed by number

fcn_string = regexprep(fcn_string, ')([\w\(])', ').*$1'); % (x)3 or (3)(4)
fcn_string = regexprep(fcn_string, '([x\d])(', '$1.*('); % x(3) or 3(x) can't do all letters bc sin(x) for e.g.


% put the number functions back in
fcn_string = strrep(fcn_string, 'ATANTWOREP','atan2');
fcn_string = strrep(fcn_string, 'LOGTENREP', 'log10');
fcn_string = strrep(fcn_string, 'LOGTWOREP','log2' );
fcn_string = strrep(fcn_string, 'POWTWOREP','pow2' );

fcn_string = strrep(fcn_string, 'PIREP','pi' );

end



