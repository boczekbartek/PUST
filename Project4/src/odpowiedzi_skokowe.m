function s = odpowiedzi_skokowe(from, to)
        U(1:200) = from;
        U(20:200) = to;
        Y(1:200) = char_stat_fun(from);
        for k = 21:200
            Y(k) = symulacja_obiektu10y(U(k-5), U(k-6), Y(k-1), Y(k-2));
        end
        s(1:180)=(Y(21:200)-char_stat_fun(from))/(to-from);
end
