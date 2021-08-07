
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
SELECT SABOR.NOME FROM SABOR WHERE SABOR.CODIGO NOT IN (
SELECT 
	SABOR.CODIGO FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA = COMANDA.NUMERO
JOIN PIZZASABOR ON PIZZA.CODIGO = PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE CASE STRFTIME('%m', COMANDA.DATA, 'localtime')
        WHEN '01' THEN 'domingo'
        WHEN '02' THEN 'segunda'
        WHEN '03' THEN 'terca'
        WHEN '04' THEN 'quarta'
        WHEN '05' THEN 'quinta'
        WHEN '06' THEN 'sexta'
        WHEN '07' THEN 'sabado'
    END = 'domingo' AND COMANDA.DATA BETWEEN DATE ('now', '-28 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
GROUP BY SABOR.CODIGO
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



--F) 
SELECT MESA.NOME, COUNT(*) AS QUANTIDADE FROM COMANDA 
JOIN MESA ON COMANDA.MESA= MESA.CODIGO
WHERE DATE(COMANDA.DATA, 'localtime') 
BETWEEN DATE ('now', '-60 days', 'localtime' )  AND DATE ('now', 'localtime')
GROUP BY MESA.CODIGO
HAVING QUANTIDADE > (
	SELECT 2 * (CAST(COUNT(*) AS REAL))/(SELECT COUNT(*) FROM MESA) AS DOBROMEDIA FROM COMANDA 
	WHERE DATE(COMANDA.DATA, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
)
ORDER BY QUANTIDADE ASC;

--G)
select DISTINCT SABOR.NOME AS SABORES FROM (
SELECT SABOR.CODIGO, SABOR.NOME AS SABORES, COUNT(COMANDA) AS PEDIDOS FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE
    COMANDA.DATA BETWEEN date('now','-1 month', 'localtime')
    AND date('now', 'localtime')
GROUP BY SABOR.NOME
ORDER BY PEDIDOS DESC
LIMIT 10) as ultimoMes join (
SELECT SABOR.CODIGO, SABOR.NOME AS SABORES, COUNT(COMANDA) AS PEDIDOS FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE
    COMANDA.DATA BETWEEN date('now','-2 months', 'localtime')
    AND date('now','-1 months', 'localtime')
GROUP BY SABOR.NOME
ORDER BY PEDIDOS DESC
LIMIT 10) as penultimoMes on ultimoMes.codigo = penultimoMes.codigo
join sabor on sabor.codigo = ultimoMes.CODIGO;
--H)

SELECT SABOR.CODIGO, SABOR.NOME AS SABORES, COUNT(COMANDA) AS PEDIDOS FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE
    COMANDA.DATA BETWEEN date('now','-1 month', 'localtime')
    AND date('now', 'localtime')
	AND SABOR.CODIGO NOT IN (SELECT SABOR.CODIGO FROM PIZZA
JOIN COMANDA ON PIZZA.COMANDA=COMANDA.NUMERO 
JOIN PIZZASABOR ON PIZZA.CODIGO=PIZZASABOR.PIZZA
JOIN SABOR ON PIZZASABOR.SABOR = SABOR.CODIGO
WHERE
    COMANDA.DATA BETWEEN date('now','-2 months', 'localtime')
    AND date('now','-1 months', 'localtime')
GROUP BY SABOR.NOME
ORDER BY COUNT(COMANDA) DESC
LIMIT 10)
GROUP BY SABOR.NOME
ORDER BY COUNT(COMANDA) DESC
LIMIT 10;

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
    ORDER BY QUANTIDADE DESC
LIMIT 3
)	ORDER BY QUANTIDADE DESC; --FALTA A ULTIMA ESTAÇÃO 


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
    ORDER BY QUANTIDADE DESC
LIMIT 5;
)	ORDER BY QUANTIDADE DESC --FALTA A ULTIMA ESTAÇÃO 
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
SELECT SABOR.NOME as sabor, BORDA.NOME borda, COUNT(*) as pedidos



--O)

--P)

SELECT SABOR.NOME as sabor, BORDA.NOME borda, COUNT(*) as pedidos
    from comanda
        join pizza on pizza.comanda = comanda.numero
        join pizzasabor on pizzasabor.pizza = pizza.codigo
        join sabor on pizzasabor.sabor = sabor.codigo
        join borda on pizza.borda = borda.codigo
    where date(comanda.data) BETWEEN DATE('now', '-3 months', 'localtime') 
	AND DATE('now', 'localtime')
    group by borda.codigo, SABOR.CODIGO
order by pedidos desc
limit 1;
