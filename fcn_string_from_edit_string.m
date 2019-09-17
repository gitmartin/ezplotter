function [ fcn_string ] = fcn_string_from_edit_string(edit_string)
%edit_string = '3*x.^2+4'
if ~isempty(edit_string)
    edit_string = [edit_string ' + 0.*x']; % make sure plotting constants works, i.e. add 0*x
end
fcn_string = edit_string;

% remove all spaces
spaces = strfind(fcn_string,' ');
fcn_string(spaces) = [];

% remove dots
fcn_string = strrep(fcn_string, '.^', '^');
fcn_string = strrep(fcn_string, '.*', '*');
fcn_string = strrep(fcn_string, './', '/');

% add dots
fcn_string = strrep(fcn_string, '^', '.^');
fcn_string = strrep(fcn_string, '*', '.*');
fcn_string = strrep(fcn_string, '/', './');

fcn_string = strrep(fcn_string, '0x', '0.*x');
fcn_string = strrep(fcn_string, '1x', '1.*x');
fcn_string = strrep(fcn_string, '2x', '2.*x');
fcn_string = strrep(fcn_string, '3x', '3.*x');
fcn_string = strrep(fcn_string, '4x', '4.*x');
fcn_string = strrep(fcn_string, '5x', '5.*x');
fcn_string = strrep(fcn_string, '6x', '6.*x');
fcn_string = strrep(fcn_string, '7x', '7.*x');
fcn_string = strrep(fcn_string, '8x', '8.*x');
fcn_string = strrep(fcn_string, '9x', '9.*x');

fcn_string = strrep(fcn_string, 'x0', 'x.*0');
fcn_string = strrep(fcn_string, 'x1', 'x.*1');
fcn_string = strrep(fcn_string, 'x2', 'x.*2');
fcn_string = strrep(fcn_string, 'x3', 'x.*3');
fcn_string = strrep(fcn_string, 'x4', 'x.*4');
fcn_string = strrep(fcn_string, 'x5', 'x.*5');
fcn_string = strrep(fcn_string, 'x6', 'x.*6');
fcn_string = strrep(fcn_string, 'x7', 'x.*7');
fcn_string = strrep(fcn_string, 'x8', 'x.*8');
fcn_string = strrep(fcn_string, 'x9', 'x.*9');

%fcn_string = strrep(fcn_string, 'x(', 'x.*(');

% fcn_string = strrep(fcn_string, '0(', '0.*(');
% fcn_string = strrep(fcn_string, '1(', '1.*(');
% fcn_string = strrep(fcn_string, '2(', '2.*(');
% fcn_string = strrep(fcn_string, '3(', '3.*(');
% fcn_string = strrep(fcn_string, '4(', '4.*(');
% fcn_string = strrep(fcn_string, '5(', '5.*(');
% fcn_string = strrep(fcn_string, '6(', '6.*(');
% fcn_string = strrep(fcn_string, '7(', '7.*(');
% fcn_string = strrep(fcn_string, '8(', '8.*(');
% fcn_string = strrep(fcn_string, '9(', '9.*(');

fcn_string = strrep(fcn_string, ')x', ').*x');

fcn_string = strrep(fcn_string, ')0', ').*0');  
fcn_string = strrep(fcn_string, ')1', ').*1');
fcn_string = strrep(fcn_string, ')2', ').*2');
fcn_string = strrep(fcn_string, ')3', ').*3');
fcn_string = strrep(fcn_string, ')4', ').*4');
fcn_string = strrep(fcn_string, ')5', ').*5');
fcn_string = strrep(fcn_string, ')6', ').*6');
fcn_string = strrep(fcn_string, ')7', ').*7');
fcn_string = strrep(fcn_string, ')8', ').*8');
fcn_string = strrep(fcn_string, ')9', ').*9');

fcn_string = strrep(fcn_string, ')(', ').*(');

end

