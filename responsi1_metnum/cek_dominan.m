function dominan = cek_dominan(A)
% Cek dominan diagonal secara baris : |a_ii| > sum |a_ij| (j != i)
    n = size(A, 1);
    dominan = true;
    for i = 1:n
        diagonal = abs(A(i, i));
        sisa = sum(abs(A(i, :))) - diagonal;
        if diagonal > sisa
            ket = 'dominan';
        else
            ket = 'TIDAK dominan';
            dominan = false;
        end
        fprintf('Baris %d : |a_ii| = %.2f, jumlah lainnya = %.2f -> %s\n', i, diagonal, sisa, ket);
    end
    if dominan
        fprintf('Kesimpulan : dominan diagonal, Gauss-Seidel pasti konvergen.\n');
    else
        fprintf('Kesimpulan : belum dominan diagonal pada semua baris.\n');
    end
end
