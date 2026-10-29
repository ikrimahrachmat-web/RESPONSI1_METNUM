%% RESPONSI 1 PRAKTIKUM METODE NUMERIK
%  KASUS 1 : GALAT (ERROR PEMOTONGAN) - GELOMBANG AIR LAUT
%  h = h0 * ( cos(t*v/lambda) + e^x )
clc; clear; close all;

%% 1. Parameter yang diketahui
lambda = 12;
v      = 36;
x      = 10;
h0     = 5;
N      = [23 24 25];            % batas iterasi (indeks suku terakhir)
t      = linspace(0, 5, 501);   % t dari 0 sampai 5, langkah 0.01

%% 2. Hitung nilai eksak
h_eksak = h0 * (cos(t * v / lambda) + exp(x));

%% 3. Hitung nilai pendekatan (deret Maclaurin) untuk tiap n
h_pendekatan = zeros(numel(N), numel(t));
for j = 1:numel(N)
    n = N(j);
    e_x = exp_maclaurin(x, n);               % nilai e^x tidak bergantung t
    for i = 1:numel(t)
        sudut = t(i) * v / lambda;
        h_pendekatan(j, i) = h0 * (cos_maclaurin(sudut, n) + e_x);
    end
end

%% 4. Hitung galat
galat_mutlak  = abs(h_eksak - h_pendekatan);          % |eksak - pendekatan|
galat_relatif = galat_mutlak ./ abs(h_eksak) * 100;   % dalam persen
rerata_mutlak  = mean(galat_mutlak, 2);
rerata_relatif = mean(galat_relatif, 2);
toleransi = 1;                                        % batas toleransi 1%

%% 5. Tampilkan hasil di Command Window
fprintf('=== KASUS 1 : GALAT PEMOTONGAN ===\n');
fprintf('Nilai e^x eksak (x = 10) = %.6f\n\n', exp(x));
fprintf('%-6s %-18s %-22s %-22s %-10s\n', 'n', 'e^x pendekatan', 'Rerata galat mutlak', 'Rerata galat relatif(%)', 'Layak?');
for j = 1:numel(N)
    if rerata_relatif(j) < toleransi
        status = 'Layak';
    else
        status = 'Tidak';
    end
    fprintf('%-6d %-18.6f %-22.6f %-22.8f %-10s\n', N(j), exp_maclaurin(x, N(j)), ...
        rerata_mutlak(j), rerata_relatif(j), status);
end

%% 6. Grafik perbandingan eksak vs pendekatan
figure(1);
plot(t, h_eksak, 'k-', 'LineWidth', 2.5); hold on;
plot(t, h_pendekatan(1,:), 'r--', 'LineWidth', 1.5);
plot(t, h_pendekatan(2,:), 'g-.', 'LineWidth', 1.5);
plot(t, h_pendekatan(3,:), 'b:',  'LineWidth', 1.8);
hold off; grid on;
xlabel('t'); ylabel('h(t)');
title('Perbandingan h(t) Eksak dan Pendekatan Deret Maclaurin');
legend('f_{eksak}', 'f_{n=23}', 'f_{n=24}', 'f_{n=25}', 'Location', 'best');
saveas(gcf, 'kasus1_grafik_h.png');

%% 7. Grafik galat mutlak terhadap t
figure(2);
plot(t, galat_mutlak(1,:), 'r-', 'LineWidth', 1.5); hold on;
plot(t, galat_mutlak(2,:), 'g-', 'LineWidth', 1.5);
plot(t, galat_mutlak(3,:), 'b-', 'LineWidth', 1.5);
hold off; grid on;
xlabel('t'); ylabel('Galat mutlak');
title('Galat Mutlak Pendekatan terhadap Nilai Eksak');
legend('n = 23', 'n = 24', 'n = 25', 'Location', 'best');
saveas(gcf, 'kasus1_grafik_galat.png');
