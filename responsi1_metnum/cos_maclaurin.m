function hasil = cos_maclaurin(x, n)
% cos(x) = sum_{k=0}^{n} (-1)^k x^(2k) / (2k)!
    hasil = 0;
    for k = 0:n
        hasil = hasil + (-1)^k * x^(2*k) / factorial(2*k);
    end
end
