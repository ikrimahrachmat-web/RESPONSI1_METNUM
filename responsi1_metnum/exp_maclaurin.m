function hasil = exp_maclaurin(x, n)
% e^x = sum_{k=0}^{n} x^k / k!
    hasil = 0;
    for k = 0:n
        hasil = hasil + x^k / factorial(k);
    end
end
