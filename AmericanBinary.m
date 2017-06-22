% BSD 2-Clause License
%
% Copyright (c) 2017, Parsiad Azimzadeh
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
%
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function [Call, Put] = AmericanBinary (Price, Strike, Rate, Time, Volatility, Yield)
  Price = Price + eps .* (Price == 0.);
  a = 1 ./ Volatility .* log(Strike ./ Price);
  xi = (Rate - Yield) / Volatility - Volatility / 2.;
  b = sqrt (xi * xi + 2 * Rate);
  mask = isinf (Time);
  res = mask .* (exp (a * xi - abs(a) .* b)) ...
    + (ones(size(mask))) .* (1. / 2. * exp (a * (xi - b)) ...
    .* (1. + sign (a) .* erf ((b * Time - a) / sqrt (2. * Time)) ...
    + exp (2. * a * b) .* (1. - sign (a) .* erf ((b * Time + a) ...
    / sqrt (2. * Time)))));
  Put  = res .* (Strike < Price) + ones(size(res)) .* (Strike >= Price);
  Call = res .* (Strike > Price) + ones(size(res)) .* (Strike <= Price);
end

