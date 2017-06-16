function s = odpowiedzi_skokowe(from, to)
        U(1:100) = from;
        U(20:100) = to;
        Y(1:100) = char_stat_fun(from);
        for k = 21:100
            Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
        end
        s(1:80)=(Y(21:100)-char_stat_fun(from))/(to-from);
end
