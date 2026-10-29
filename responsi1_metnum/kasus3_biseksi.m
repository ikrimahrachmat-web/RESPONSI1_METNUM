%% RESPONSI 1 PRAKTIKUM METODE NUMERIK
%  KASUS 3 : PERSAMAAN NON LINIER - BOLA DI DALAM TABUNG
%  Vbola = 4/3 * pi * r^3 = 300  ->  f(r) = 4/3 * pi * r^3 - 300 = 0
clc; clear; close all;

%% 1. Persamaan non linier
V_bola = 300;
f = @(r) (4/3) * pi * r.^3 - V_bola;

%% 2. Metode grafik untuk menentukan nilai awal
r_plot = 0:0.1:8;
figure(1);
plot(r_plot, f(r_plot), 'b-', 'LineWidth', 1.8); hold on;
plot([0 8], [0 0], 'k-');                               % sumbu f(r) = 0
plot([4 5], [f(4) f(5)], 'ro', 'MarkerFaceColor', 'r'); % titik a = 4, b = 5
hold off; grid on;
xlabel('r (cm)'); ylabel('f(r)');
title('Grafik f(r) = (4/3)\pi r^3 - 300');
legend('f(r)', 'f(r) = 0', 'f(4) dan f(5)', 'Location', 'northwest');
saveas(gcf, 'kasus3_grafik_f.png');

a = 4;  b = 5;
fprintf('=== KASUS 3 : PERSAMAAN NON LINIER ===\n');
fprintf('Nilai awal dari grafik : a = %g, b = %g\n', a, b);
fprintf('f(a) = %.6f, f(b) = %.6f, f(a)*f(b) = %.4f (< 0, akar ada di [a,b])\n\n', f(a), f(b), f(a)*f(b));

%% 3. Metode Biseksi
tol = 1e-6;
maks_iter = 100;
fprintf('%-6s %-12s %-12s %-12s %-14s %-12s\n', 'iter', 'a', 'b', 'c', 'f(c)', 'galat |b-a|/2');
for iter = 1:maks_iter
    c = (a + b) / 2;
    galat = abs(b - a) / 2;
    fprintf('%-6d %-12.6f %-12.6f %-12.6f %-14.6f %-12.8f\n', iter, a, b, c, f(c), galat);
    if f(c) == 0 || galat < tol
        break;
    end
    if f(a) * f(c) < 0
        b = c;
    else
        a = c;
    end
end
r = c;
fprintf('\nAkar hampiran r = %.6f cm (dicapai pada iterasi ke-%d)\n\n', r, iter);

%% 4. Hitung volume tabung dan volume di luar bola
t_tabung = 2 * r;                       % tinggi tabung = diameter bola
V_bola_cek = (4/3) * pi * r^3;
V_tabung   = pi * r^2 * t_tabung;
V_luar     = V_tabung - V_bola_cek;
V_luar_rumus = (2/3) * pi * r^3;        % rumus yang diberikan di soal

fprintf('--- Hasil akhir ---\n');
fprintf('Jari-jari bola dan tabung (r) = %.6f cm\n', r);
fprintf('Tinggi tabung (t = 2r)        = %.6f cm\n', t_tabung);
fprintf('Volume bola (cek)             = %.6f cm^3\n', V_bola_cek);
fprintf('Volume tabung                 = %.6f cm^3\n', V_tabung);
fprintf('Volume tabung di luar bola    = %.6f cm^3\n', V_luar);
fprintf('Cek rumus (2/3)*pi*r^3        = %.6f cm^3\n', V_luar_rumus);
