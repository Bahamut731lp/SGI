clear all;

% data 
load("digits_tren.mat");
load("digits_test.mat");

% Při N = 1000 a M = 9000
% L1 přesnost 42%
% L2 přesnost 48%

uspesnosti = zeros(9);
N = 1000;

for M = 1000:1000:9000
    pocet_pokusu = 0; 
    pocet_spravnych = 0;

    for i = 1:N % cyklus pro test. obrázky, N max.1000
        x = test_data (i,:,:); % načti test. obrázek
        x_trida = test_trida(i); % jeho třída
    
        for j = 1:M % cyklus pro tren. vzory, M max.9000
            v = tren_data (j,:,:); % načti tren. obrázek
            v_trida = tren_trida(j); % jeho třída
            tridy_vzoru(j) = v_trida; % ulož číslo třídy do pole tridy_vzoru
            dist(j)=sqrt(sum(sum((x-v).^2))); % urči vzdálenost a ulož do pole dist
        end
    
        [min_dist, index] = min(dist); % nejmenší vzdálenost a její index
        nejblizsi_trida = tridy_vzoru(index); % třída nejbližšího vzoru
    
        if x_trida == nejblizsi_trida % je shoda?
            pocet_spravnych = pocet_spravnych + 1; % pokud ano, započítej
        end
    
        pocet_pokusu = pocet_pokusu + 1; % započítej pokus
    
        if (mod(i, 10) == 0)
            fprintf("Iterace %6d: %d%%\n", i, round(pocet_spravnych/pocet_pokusu * 100));
        end
    end

    uspesnost = pocet_spravnych/pocet_pokusu * 100; % urči úspěšnost

    disp("===============================================");
    fprintf("Celková úspěšnost: %d%%\n\n", round(uspesnost));
    uspesnosti(M / 1000) = round(uspesnost);
end

bar(uspesnosti);
saveas(gcf,'uspesnosti.png')




