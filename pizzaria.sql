
--A)
SELECT SABOR.NOME, COUNT(INGREDIENTE.NOME) AS QUANTIDADE FROM SABORINGREDIENTE 
JOIN SABOR ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
JOIN INGREDIENTE ON SABORINGREDIENTE.INGREDIENTE = INGREDIENTE.CODIGO
GROUP BY SABOR.CODIGO
HAVING QUANTIDADE= (
	SELECT COUNT(*) AS QUANTIDADE FROM SABORINGREDIENTE 
JOIN SABOR ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
	GROUP BY SABOR.NOME
	ORDER BY QUANTIDADE DESC
	LIMIT 1
)
ORDER BY QUANTIDADE DESC;

--B)
SELECT SABOR.NOME, COUNT(INGREDIENTE.NOME) AS QUANTIDADE FROM SABORINGREDIENTE 
JOIN SABOR ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
JOIN INGREDIENTE ON SABORINGREDIENTE.INGREDIENTE = INGREDIENTE.CODIGO
GROUP BY SABOR.CODIGO
HAVING QUANTIDADE= (
	SELECT COUNT(*) AS QUANTIDADE FROM SABORINGREDIENTE 
JOIN SABOR ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
	GROUP BY SABOR.NOME
	ORDER BY QUANTIDADE ASC
	LIMIT 1
)
ORDER BY QUANTIDADE ASC;

--C)
SELECT  CASE STRFTIME('%m', COMANDA.DATA, 'localtime')
        WHEN '01' THEN 'domingo'
        WHEN '02' THEN 'segunda'
        WHEN '03' THEN 'terca'
        WHEN '04' THEN 'quarta'
        WHEN '05' THEN 'quinta'
        WHEN '06' THEN 'sexta'
        WHEN '07' THEN 'sabado'
    END AS DIAS,
	 SABOR.NOME, COUNT(COMANDA) AS PEDIDOS FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA = COMANDA.NUMERO
JOIN PIZZASABOR ON PIZZA.CODIGO = PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE DIAS = 'domingo'
GROUP BY SABOR.NOME NOT IN (
 SELECT  CASE STRFTIME('%m', COMANDA.DATA, 'localtime')
        WHEN '01' THEN 'domingo'
        WHEN '02' THEN 'segunda'
        WHEN '03' THEN 'terca'
        WHEN '04' THEN 'quarta'
        WHEN '05' THEN 'quinta'
        WHEN '06' THEN 'sexta'
        WHEN '07' THEN 'sabado'
    END AS DIAS,
	 SABOR.CODIGO, COUNT(COMANDA) AS PEDIDOS FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA = COMANDA.NUMERO
JOIN PIZZASABOR ON PIZZA.CODIGO = PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE DIAS = 'domingo'
GROUP BY SABOR.NOME
);

--D)
SELECT MESA.NOME, COUNT(*) AS QUANTIDADE FROM COMANDA 
JOIN MESA ON COMANDA.MESA= MESA.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') 
BETWEEN DATE ('now', '-60 days', 'localtime' )  AND DATE ('now', 'localtime')
GROUP BY MESA.CODIGO
HAVING QUANTIDADE= (
	SELECT COUNT(*) AS QUANTIDADE FROM COMANDA 
	JOIN MESA ON COMANDA.MESA = MESA.CODIGO
	WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY MESA.NOME
	ORDER BY QUANTIDADE DESC
	LIMIT 1
)
ORDER BY QUANTIDADE DESC;
--E)

SELECT MESA.NOME, COUNT(*) AS QUANTIDADE FROM COMANDA 
JOIN MESA ON COMANDA.MESA= MESA.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') 
BETWEEN DATE ('now', '-60 days', 'localtime' )  AND DATE ('now', 'localtime')
GROUP BY MESA.CODIGO
HAVING QUANTIDADE= (
	SELECT COUNT(*) AS QUANTIDADE FROM COMANDA 
	JOIN MESA ON COMANDA.MESA = MESA.CODIGO
	WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY MESA.NOME
	ORDER BY QUANTIDADE ASC
	LIMIT 1
)
ORDER BY QUANTIDADE ASC;



--F) to fazendo - julia

--G)
--H)
--I)

SELECT SABOR.NOME FROM PIZZA 
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-3 months', 'localtime' ) 
	AND DATE ('now', 'localtime') 
	GROUP BY SABOR.CODIGO NOT IN (
	SELECT SABOR.CODIGO FROM PIZZA 
JOIN COMANDA ON PIZZA.COMANDA= COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-3 months', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY SABOR.NOME
);
--J)

SELECT SABOR.NOME, COUNT(COMANDA) AS QUANTIDADE FROM PIZZA 
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') 
BETWEEN DATE ('now', '-60 days', 'localtime' )  AND DATE ('now', 'localtime')
GROUP BY SABOR.CODIGO
HAVING QUANTIDADE > (
	SELECT COUNT(COMANDA) AS QUANTIDADE FROM PIZZA 
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
	WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY SABOR.NOME
)	ORDER BY QUANTIDADE DESC
LIMIT 3; --FALTA A ULTIMA ESTAÇÃO 


--K)
SELECT INGREDIENTE.NOME AS NOME, COUNT(COMANDA) AS QUANTIDADE FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA = COMANDA.NUMERO
JOIN PIZZASABOR ON PIZZA.CODIGO = PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
JOIN SABORINGREDIENTE ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
JOIN INGREDIENTE ON SABORINGREDIENTE.INGREDIENTE = INGREDIENTE.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') 
BETWEEN DATE ('now', '-60 days', 'localtime' )  AND DATE ('now', 'localtime')
GROUP BY INGREDIENTE.CODIGO
HAVING QUANTIDADE > (
		SELECT COUNT(COMANDA) AS QUANTIDADE FROM PIZZA 
		JOIN COMANDA ON PIZZA.COMANDA = COMANDA.NUMERO
JOIN PIZZASABOR ON PIZZA.CODIGO = PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
JOIN SABORINGREDIENTE ON SABORINGREDIENTE.SABOR = SABOR.CODIGO
JOIN INGREDIENTE ON SABORINGREDIENTE.INGREDIENTE = INGREDIENTE.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY INGREDIENTE.NOME
)	ORDER BY QUANTIDADE DESC
LIMIT 5; --FALTA A ULTIMA ESTAÇÃO 
--L)
select round(((sum(anoAtual.preco)*100)/(select sum(anoPassado.preco) from (select 
        max(case
                when borda.preco is null then 0
                else borda.preco
            end+precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
        left join borda on pizza.borda = borda.codigo
    where date(comanda.data)  BETWEEN DATE('now', 'start of year', '+1 days','-1 years', 'localtime') and DATE('now', 'start of year', 'localtime')
    group by comanda.numero, pizza.codigo) anoPassado)),2) || ' %' as percentual
from
    (select comanda.numero, pizza.codigo,
        max(case
                when borda.preco is null then 0
                else borda.preco
            end+precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
        left join borda on pizza.borda = borda.codigo
    where date(comanda.data)  BETWEEN DATE('now', 'start of year', '+1 days', 'localtime') and DATE('now')
    group by comanda.numero, pizza.codigo) as anoAtual;

--M)
select
    case strftime('%w', tmp.data)
        when '0' then 'Dom'
        when '1' then 'Seg'
        when '2' then 'Ter'
        when '3' then 'Qua'
        when '4' then 'Qui'
        when '5' then 'Sex'
        when '6' then 'Sab'
    end as diasemana,
    sum(tmp.preco) as total
from (select comanda.numero, pizza.codigo, comanda.data,
        max(case
                when borda.preco is null then 0
                else borda.preco
            end + precoportamanho.preco) as preco
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join precoportamanho on precoportamanho.tipo = sabor.tipo and precoportamanho.tamanho = pizza.tamanho
		left join borda on pizza.borda = borda.codigo
    where date(comanda.data) BETWEEN DATE('now', '-60 days', 'localtime') 
	AND DATE('now', 'localtime')
    group by comanda.numero, pizza.codigo) tmp
group by diasemana
order by 2 desc
limit 1;
--N)


--O)
--P)

