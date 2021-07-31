DROP TABLE USUARIO;

DROP TABLE AMIZADE;

DROP TABLE ASSUNTO;

DROP TABLE ASSUNTOPOST;

DROP TABLE CITACAO;

DROP TABLE REACAO;

DROP TABLE COMPARTILHAMENTO;

DROP TABLE POST;

DROP TABLE GRUPO;

DROP TABLE GRUPOUSUARIO;


CREATE TABLE USUARIO(
    EMAIL CHAR (100) NOT NULL,
    NOME CHAR(100) NOT NULL,
    DATACADASTRO DATETIME,
    CIDADE CHAR(100),
    PAIS CHAR(100),
    UF CHAR(100),
    GENERO char (1),
    NASCIMENTO date,
    PRIMARY KEY (EMAIL)
);

CREATE TABLE GRUPO(
    CODIGO INTEGER NOT NULL,
    NOMEGRUPO CHAR(100) NOT NULL, 
    PRIMARY KEY(CODIGO)
);

CREATE TABLE GRUPOUSUARIO(
    CODIGOGRUPO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    PRIMARY KEY (CODIGOGRUPO, EMAIL_USUARIO)
);
CREATE TABLE AMIZADE(
    EMAIL_USUARIO1 CHAR (100) NOT NULL,
    EMAIL_USUARIO2 CHAR (100) NOT NULL,
    DATAAMIZADE DATETIME,
    FOREIGN KEY (EMAIL_USUARIO1) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (EMAIL_USUARIO2) REFERENCES USUARIO(EMAIL),
    PRIMARY KEY (EMAIL_USUARIO1, EMAIL_USUARIO2)
);

CREATE TABLE ASSUNTO(
    CODIGO INTEGER NOT NULL,
    ASSUNTO CHAR(4096),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE ASSUNTOPOST(
    CODIGOASSUNTO INTEGER NOT NULL,
    CODIGOPOST INTEGER NOT NULL,
    FOREIGN KEY (CODIGOASSUNTO) REFERENCES ASSUNTO(CODIGO),
    FOREIGN KEY (CODIGOPOST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGOASSUNTO, CODIGOPOST)
);

CREATE TABLE CITACAO(
    CODIGO INTEGER NOT NULL,
    COD_POST INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO, COD_POST, EMAIL_USUARIO)
);

CREATE TABLE REACAO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    TIPOREACAO CHAR(10) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    PAIS CHAR(100) NOT NULL,
    DATAREACAO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE COMPARTILHAMENTO(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    COD_POST INTEGER NOT NULL,
    CIDADE CHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    DATACOMPARTILHAMENTO DATETIME,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (COD_POST) REFERENCES POST(CODIGO),
    PRIMARY KEY (CODIGO)
);

CREATE TABLE POST(
    CODIGO INTEGER NOT NULL,
    EMAIL_USUARIO CHAR (100) NOT NULL,
    POST CHAR(1000) NOT NULL,
    CIDADE CHAR (100) NOT NULL,
    UF CHAR (100) NOT NULL,
    PAIS CHAR (100) NOT NULL,
    DATAPOST DATETIME,
    CODPOSTREFERENCIA INTEGER,
    QTDCOMENTARIOS INTEGER NOT NULL DEFAULT 0,
    QTDREACOES INTEGER NOT NULL DEFAULT 0,
CODIGOGRUPO INTEGER,
    FOREIGN KEY (EMAIL_USUARIO) REFERENCES USUARIO(EMAIL),
    FOREIGN KEY (CODPOSTREFERENCIA) REFERENCES POST(CODIGO),
    FOREIGN KEY (CODIGOGRUPO) REFERENCES GRUPO(CODIGO),
    PRIMARY KEY (CODIGO)
);

    INSERT INTO 
    GRUPO(
        CODIGO,
        NOMEGRUPO
    )
    VALUES
    (
        1,
        'SQLite'
    ),
    (
        2,
        'Banco de Dados-IFRS-2021'
    );

INSERT INTO
    USUARIO(
        EMAIL,
        NOME,
        DATACADASTRO,
        CIDADE,
        PAIS,
        UF,
        GENERO,
        NASCIMENTO
    )
VALUES
    (
        'joaosbras@mymail.com',
        'João Silva Brasil',
        '2020-01-01 13:00:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'M',
        '1998-02-02'
    ),
    (
        'pmartinssilva90@mymail.com',
        'Paulo Martins Silva',
        null,
        null,
        null,
        null,
        'M',
        '2003-05-23'
    ),
    (
        'mcalbuq@mymail.com',
        'Maria Cruz Albuquerque',
        '2020-01-01 13:10:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'F',
        '2002-11-04'
    ),
    (
        'jorosamed@mymail.com',
        'Joana Rosa Medeiros',
        '2020-01-01 13:15:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1974-02-05'
    ),
    (
        'pxramos@mymail.com',
        'Paulo Xavier Ramos',
        '2020-01-01 13:20:00',
        'Rio Grande',
        'Brasil',
        'RS',
        'N',
        '1966-03-30'
    ),
    (
        'pele@cbf.com.br',
        'Edson Arantes do Nascimento',
        null,
        'Três Corações',
        'Brasil',
        'MG',
        'M',
        '1940-10-23'
    );

INSERT INTO
    AMIZADE(EMAIL_USUARIO1, EMAIL_USUARIO2, DATAAMIZADE)
VALUES
    ('pxramos@mymail.com','jorosamed@mymail.com', '2021-05-17 10:15:00'),
    ('jorosamed@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:15:00'),
    ('mcalbuq@mymail.com', 'pele@cbf.com.br', '2021-05-17 10:20:00' ),
    ( 'jorosamed@mymail.com','mcalbuq@mymail.com','2021-05-17 10:20:00' );
INSERT INTO
    POST(
        CODIGO,
        EMAIL_USUARIO,
        POST,
        CIDADE,
        UF,
        PAIS,
        DATAPOST,
        CODPOSTREFERENCIA,
        QTDREACOES,
        QTDCOMENTARIOS,
        CODIGOGRUPO
    )
VALUES
    (
        1,
        'joaosbras@mymail.com',
        'Hoje eu aprendi como inserir dados no SQLite no IFRS',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:00:00',
        null,
        1,
        2,
        null
    ),
    (
        3,
        'jorosamed@mymail.com',
        'Alguém mais ficou com dúvida no comando INSERT?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:15:00',
        1,
        1,
        0,
        1
    ),
    (
        4,
        'pxramos@mymail.com',
        'Eu também',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:20:00',
        3,
        0,
        0,
        null
    ),
    (
        5,
        'joaosbras@mymail.com',
        'Já agendaste horário de atendimento com o professor?',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-02 15:30:00',
        4,
        0,
        0,
        null
    ),
    (
        6,
        'pmartinssilva90@mymail.com',
        'Ontem aprendi sobre joins no SQLite na disciplina de banco de dados do IFRS.',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 18:30:00',
        null,
        0,
        0,
        2
    ),
    (
        7,
        'pele@cbf.com.br',
        'Show!',
        'Rio Grande',
        'RS',
        'Brasil',
        '2021-06-08 20:34:02',
        6,
        0,
        0,
        2
    );

INSERT INTO
    ASSUNTO(CODIGO, ASSUNTO)
VALUES
    (1, 'BD'),
    (2, 'SQLite'),
    (3, 'INSERT'),
    (4, 'atendimento');

INSERT INTO
    ASSUNTOPOST (CODIGOPOST, CODIGOASSUNTO)
VALUES
    (1, 1),
    (1, 2),
    (3, 1),
    (3, 2),
    (3, 3),
    (5, 4),
    (5, 1),
    (6, 1),
    (6, 2);

INSERT INTO
    REACAO(
        CODIGO,
        TIPOREACAO,
        EMAIL_USUARIO,
        CIDADE,
        UF,
        PAIS,
        COD_POST,
        DATAREACAO
    )
values
    (
        2,
        'Curtida',
        'mcalbuq@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        1,
        '2021-06-02 15:10:00'
    ),
    (
        3,
        'Triste',
        'pxramos@mymail.com',
        'Rio Grande',
        'RS',
        'Brasil',
        3,
        '2021-06-02 15:20:00'
    );


INSERT INTO
    GRUPOUSUARIO(
        CODIGOGRUPO,
        EMAIL_USUARIO
    )
values
    (2,
    'pxramos@mymail.com'),
    (2,
    'mcalbuq@mymail.com');
    

INSERT INTO COMPARTILHAMENTO(
    CODIGO,
    EMAIL_USUARIO,
    COD_POST,
    CIDADE,
    UF,
    DATACOMPARTILHAMENTO
) VALUES
(
    1, 
    'joaosbras@mymail.com',
    6,
    'Rio Grande',
    'RS', 
    '2021-06-10 13:00:00'
);

--A)
--B)
SELECT USUARIO.NOME AS NOME, COUNT(REACAO.CODIGO) AS NUMEROREACOES FROM POST 
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE DATE(REACAO.DATAREACAO, 'localtime') BETWEEN DATE ('now', '-30 days', 'localtime' ) 
AND DATE ('now', 'localtime')
GROUP BY USUARIO.EMAIL
HAVING NUMEROREACOES= (
    SELECT COUNT(*) AS NUMEROREACOES FROM POST 
    JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE DATE(REACAO.DATAREACAO, 'localtime') BETWEEN DATE ('now', '-30 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
    GROUP BY USUARIO.NOME
ORDER BY NUMEROREACOES ASC
LIMIT 1
)
ORDER BY NUMEROREACOES ASC;

--C)
SELECT ASSUNTO.ASSUNTO AS ASSUNTO, COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') 
BETWEEN DATE ('now', '-30 days', 'localtime' ) 
 AND DATE ('now', 'localtime') AND POST.PAIS = 'Brasil'
GROUP BY ASSUNTO.CODIGO
HAVING QUANTIDADE = (
SELECT COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') BETWEEN DATE ('now', '-30 days', 'localtime' ) 
	AND DATE ('now', 'localtime') AND POST.PAIS = 'Brasil' 
	GROUP BY ASSUNTO.ASSUNTO
)	ORDER BY QUANTIDADE DESC
LIMIT 5;
--D)

SELECT ASSUNTO.PAIS AS PAIS, COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') 
BETWEEN DATE ('now', '-30 days', 'localtime' ) 
 AND DATE ('now', 'localtime')
GROUP BY ASSUNTO.CODIGO
HAVING QUANTIDADE = (
SELECT COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') BETWEEN DATE ('now', '-30 days', 'localtime' ) 
	AND DATE ('now', 'localtime')
	GROUP BY ASSUNTO.PAIS
)	ORDER BY QUANTIDADE DESC
LIMIT 5;--FAZENDO
--E)
--F)
SELECT USUARIO.NOME, COUNT(REACAO.CODIGO) AS QUANTIDADE
FROM POST
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE REACAO.DATAREACAO BETWEEN date ('now', '-60 days', 'localtime' ) 
    AND DATE ('now', 'localtime') AND REACAO.PAIS = 'Brasil'
    GROUP BY USUARIO.EMAIL
    HAVING QUANTIDADE = (
        SELECT COUNT(REACAO.CODIGO) AS QUANTIDADE
        FROM POST
JOIN REACAO ON POST.CODIGO= REACAO.COD_POST
JOIN USUARIO ON POST.EMAIL_USUARIO=USUARIO.EMAIL
WHERE REACAO.DATAREACAO BETWEEN date ('now', '-60 days', 'localtime' ) 
    AND DATE ('now', 'localtime') AND REACAO.PAIS = 'Brasil'
    GROUP BY USUARIO.NOME
    ORDER BY QUANTIDADE DESC
    )
    ORDER BY QUANTIDADE DESC;
--G)
--H)
SELECT ASSUNTO.ASSUNTO AS ASSUNTO, COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') 
BETWEEN DATE ('now', '-30 days', 'localtime' ) 
 AND DATE ('now', 'localtime') AND POST.PAIS = 'Brasil'
GROUP BY ASSUNTO.CODIGO IN (
SELECT COUNT(ASSUNTO) AS QUANTIDADE FROM ASSUNTO
    JOIN ASSUNTOPOST ON ASSUNTOPOST.CODIGOASSUNTO = ASSUNTO.CODIGO
    JOIN POST ON ASSUNTOPOST.CODIGOPOST = POST.CODIGO
WHERE DATE(POST.DATAPOST, 'localtime') BETWEEN DATE ('now', '-60 days', 'localtime' ) 
	AND DATE ('now', 'localtime') AND POST.PAIS = 'Brasil' 
	GROUP BY ASSUNTO.ASSUNTO
)	ORDER BY QUANTIDADE DESC
LIMIT 5;
--I)
--J)
--K)
--L)