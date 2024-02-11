module LabTools

    import Base.+, Base.-, Base.*, Base./, Base.^ # Имтортируем арифмитические операции, чтобы их расширить на экспериментальные значения
    export exval, ϵ, +, -, *, /, ^

    struct exval # Экспериментальное значение
        x::Float64 # Измеренное значение
        σ::Float64 # Абсолютная погрешность
    end

    function ϵ(a::exval) # Относитальная погрешность величины
        return a.σ / a.x 
    end

    #= Далее мы определяем арифмитические операции/функции для exval 
    Пусть c = f(a,b)
    Тогда dc = f'a * da + f'b * db
    Соответсттвенно
    σ_c = √(f'a * σ_a)^2 +(f'b * σ_b)^2) =#

    function +(a::exval, b::exval)
        return exval(a.x + b.x, sqrt(a.σ^2 + b.σ^2))
    end

    function -(a::exval, b::exval)
        return exval(a.x - b.x, sqrt(a.σ^2 + b.σ^2))
    end

    function *(a::exval, b::exval)
        return exval(a.x * b.x, sqrt((a.x*b.σ)^2 + (b.x*a.σ)^2))
    end

    function *(a::exval, b::Float64)
        return exval(a.x * b, a.σ * b)
    end 

    function /(a::exval, b::exval)
        return exval(a.x / b.x, sqrt((a.σ/b.x)^2 + (b.σ/b.x^2)^2))
    end

    function /(a::exval, b::Float64)
        return exval(a.x / b, a.σ / b)
    end

    function ^(a::exval, b::Float64)
        return exval(a.x ^ b, b * (a.x)^(b-1) * a.σ)
    end

end


#=
a = exval(10.0, 1.0)

b = exval(30.0, 1.0)

println("Addition: $(a+b)")
println("Subrtaction: $(a-b)")
println("Multiplication: $(a*b)")
println("Division: $(a/b)")
println("Exponentiation: $(a^3.0)")


=#