# AmericanBinary

**AmericanBinary** computes the value of American binary (a.k.a. digital) calls and puts assuming that the underlying follows a Geometric Brownian motion:

dS = (Rate - Yield) dt + Volatility dW

An American binary call is an option which can be exercised at any time, having an exercise value 1 if S > Strike and exercise value 0 otherwise.

An American binary put is defined similarly.

## Methodology

The routine uses a closed-form solution for the price. By virtue of this, there is no discretization error.

## Usage

```matlab
[Call, Put] = AmericanBinary(Price, Strike, Rate, Time, Volatility, Yield)
```

 * ```Price```: The initial value of the asset S
 * ```Strike```: The strike price
 * ```Rate```: The risk-free interest rate
 * ```Time```: The expiry time (use ```Inf``` for a perpetual option)
 * ```Volatility```: The volatility of the asset S
 * ```Yield```: The dividend rate of the asset S
 * ```Call```: The value of the call
 * ```Put```: The value of the put

The function, similar to [blsprice](https://www.mathworks.com/help/finance/blsprice.html), accepts vector/matrix arguments.

## Example

```matlab
Strike     = 100.;
Price      = 0 : 1 : Strike * 2;
Rate       = 0.04;
Time       = 1.;
Volatility = 0.2;
Yield      = 0.01;

[Call, Put] = AmericanBinary(Price, Strike, Rate, Time, Volatility, Yield);

plot(Price, Put, 'linewidth', 2);
xlabel('Asset price');
ylabel('Option value');
title('American binary put');
```