%% RESPONSI 1 PRAKTIKUM METODE NUMERIK
%  KASUS 2 : SPL METODE LANGSUNG / TIDAK LANGSUNG - HARGA BAHAN MAKANAN
clc; clear; close all;

%% 1. Bentuk SPL (semua satuan sudah dikonversi ke kg)
%  Kolom : beras, telur, tepung, ayam  (harga per kg)
%  Baris : Adel, Briza, Caca, Dinda
nama_baris = {'Adel', 'Briza', 'Caca', 'Dinda'};
A = [2.5  1.5   5.0  0.5;      % Adel  : 2.5 kg, 1500 g, 5 kg, 500 g
     4.0  0.75  1.0  2.0;      % Briza : 40 hg, 0.75 kg, 1000 g, 2 kg
     2.0  1.5   0.5  6.0;      % Caca  : 2000 g, 15 hg, 50 dag, 6000 g
     1.0  4.25  2.0  0.9];     % Dinda : 1 kg, 4250 g, 20 hg, 9 hg
b = [161000; 149000; 251500; 173000];

fprintf('=== KASUS 2 : SPL ===\n');
fprintf('Matriks A (kg) dan vektor b (Rp):\n');
for i = 1:4
    fprintf('%-6s | %5.2f %5.2f %5.2f %5.2f | %9d\n', nama_baris{i}, A(i,:), b(i));
end
fprintf('\n');

%% 2. Analisis: apakah metode tidak langsung (Gauss-Seidel) bisa dipakai?
fprintf('--- Cek dominan diagonal, urutan awal ---\n');
dominan_awal = cek_dominan(A);
fprintf('Jari-jari spektral Gauss-Seidel = %.4f\n\n', rho_gs(A));

%% 3. Susun ulang baris agar dominan diagonal : Briza, Dinda, Adel, Caca
urutan = [2 4 1 3];
A2 = A(urutan, :);
b2 = b(urutan);
fprintf('--- Cek dominan diagonal, setelah baris disusun ulang [2 4 1 3] ---\n');
dominan_baru = cek_dominan(A2);
fprintf('Jari-jari spektral Gauss-Seidel = %.4f\n\n', rho_gs(A2));

%% 4. Metode Gauss-Seidel
n = size(A2, 1);
x = zeros(n, 1);          % tebakan awal
tol = 1e-6;               % toleransi galat
maks_iter = 1000;
riwayat = [];

fprintf('--- Iterasi Gauss-Seidel ---\n');
fprintf('%-6s %-14s %-14s %-14s %-14s %-12s\n', 'iter', 'beras', 'telur', 'tepung', 'ayam', 'galat maks');
for iter = 1:maks_iter
    x_lama = x;
    for i = 1:n
        indeks = [1:i-1, i+1:n];                       % semua kolom selain diagonal
        x(i) = (b2(i) - A2(i, indeks) * x(indeks)) / A2(i, i);
    end
    galat = max(abs(x - x_lama));
    riwayat(iter, :) = [iter, x', galat]; %#ok<AGROW>
    if iter <= 10
        fprintf('%-6d %-14.4f %-14.4f %-14.4f %-14.4f %-12.6f\n', iter, x, galat);
    end
    if galat < tol
        break;
    end
end
fprintf('...\n');
fprintf('%-6d %-14.4f %-14.4f %-14.4f %-14.4f %-12.8f\n', iter, x, galat);
fprintf('Konvergen pada iterasi ke-%d\n\n', iter);

%% 5. Hasil akhir dan verifikasi dengan operator \
x_cek = A \ b;
bahan = {'Beras', 'Telur', 'Tepung', 'Ayam'};
fprintf('--- Harga per kilogram ---\n');
fprintf('%-8s %-18s %-18s\n', 'Bahan', 'Gauss-Seidel (Rp)', 'Verifikasi A\b (Rp)');
for i = 1:n
    fprintf('%-8s %-18.4f %-18.4f\n', bahan{i}, x(i), x_cek(i));
end

%% 6. Grafik konvergensi
figure(1);
semilogy(riwayat(:,1), riwayat(:,6), 'b-o', 'LineWidth', 1.5, 'MarkerSize', 3);
grid on; xlabel('Iterasi'); ylabel('Galat maksimum (skala log)');
title('Konvergensi Metode Gauss-Seidel');
saveas(gcf, 'kasus2_konvergensi.png');
