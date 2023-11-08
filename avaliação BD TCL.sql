CREATE SCHEMA meu_TCL;
USE meu_TCL;

CREATE TABLE info_pessoais_aluno (
    cpf VARCHAR(15) PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    tel_celular_resp VARCHAR(15) NOT NULL,
    tel_residencial_resp VARCHAR(15),
    email_resp VARCHAR(40) NOT NULL,
    status_info BOOL DEFAULT 1
);

CREATE TABLE aluno (
    num_matricula_aluno BIGINT AUTO_INCREMENT PRIMARY KEY,
    data_inicio_aluno DATE NOT NULL,
    cpf_aluno VARCHAR(15) UNIQUE NOT NULL,
    email_aluno VARCHAR(40),
    status_aluno BOOL DEFAULT 1,
    CONSTRAINT fk_cpf_aluno FOREIGN KEY (cpf_aluno) REFERENCES info_pessoais_aluno(cpf)
);

CREATE TABLE curso (
    codigo_curso BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome_curso VARCHAR(50) NOT NULL,
    duracao_curso INT NOT NULL CHECK (duracao_curso >= 0),
    curso_status BOOL DEFAULT 1
);

CREATE TABLE turma (
    codigo_tur BIGINT AUTO_INCREMENT PRIMARY KEY,
    qtd_alunos_tur INT NOT NULL CHECK (qtd_alunos_tur >= 0),
    periodo_tur VARCHAR(30) NOT NULL,
    semestre_tur VARCHAR(30) NOT NULL,
    status_tur BOOL DEFAULT 1
);

CREATE TABLE professor (
    codigo_prof BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome_prof VARCHAR(40) NOT NULL,
    especialidade_prof VARCHAR(50) NOT NULL,
    data_admissao_prof DATE NOT NULL,
    status_prof BOOL DEFAULT 1
);

CREATE TABLE disciplina (
    codigo_disc BIGINT AUTO_INCREMENT PRIMARY KEY,
    nome_disc VARCHAR(50) NOT NULL,
    ementa_disc TEXT NOT NULL,
    status_disc BOOL DEFAULT 1
);

CREATE TABLE matricula (
    numero_matricula BIGINT AUTO_INCREMENT,
    codigo_curso BIGINT,
    codigo_turma BIGINT,
    matricula_status BOOL DEFAULT 1,
    CONSTRAINT pk_matricula PRIMARY KEY (numero_matricula, codigo_curso, codigo_turma),
    CONSTRAINT fk_curso_matricula FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso),
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (numero_matricula) REFERENCES aluno(num_matricula_aluno),
    CONSTRAINT fk_matricula_turma FOREIGN KEY (codigo_turma) REFERENCES turma(codigo_tur)
);


CREATE TABLE aula (
    codigo_aula BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo_professor BIGINT NOT NULL,
    codigo_disciplina BIGINT NOT NULL,
    codigo_turma BIGINT NOT NULL,
    data_aula DATE NOT NULL,
    status_aula BOOL DEFAULT 1,
    CONSTRAINT fk_professor_aula FOREIGN KEY (codigo_professor) REFERENCES professor(codigo_prof),
    CONSTRAINT fk_disciplina_aula FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo_disc),
    CONSTRAINT fk_turma_aula FOREIGN KEY (codigo_turma) REFERENCES turma(codigo_tur)
);

INSERT INTO info_pessoais_aluno (cpf, nome, tel_celular_resp, email_resp)
VALUES
('123.456.789-01', 'Fernando Pereira', '016995678901', 'fernando@email.com'),
('987.654.321-02', 'Juliana Santos Silva', '016995432102', 'juliana@email.com'),
('456.789.123-03', 'Mariana Silva Almeida', '016998912303', 'mariana@email.com'),
('789.123.456-04', 'Marcelo Mendes', '016997891234', 'marcelo@email.com'),
('234.567.890-05', 'Luana Oliveira', '016992345678', 'luana@email.com');

INSERT INTO aluno (data_inicio_aluno, cpf_aluno, email_aluno)
VALUES
('2022-01-10', '123.456.789-01', 'fernando1@emaileduc.com'),
('2022-06-01', '987.654.321-02', 'juliana22@emaileduc.com'),
('2021-01-15', '456.789.123-03', 'mariana32@emaileduc.com'),
('2023-01-10', '789.123.456-04', 'marcelo11@emaileduc.com'),
('2023-06-01', '234.567.890-05', 'luana123@emaileduc.com');

INSERT INTO disciplina (nome_disc, ementa_disc)
VALUES
('Programação Web para Back-End', 'Tal disciplina aborda conceitos e técnicas para desenvolvimento de aplicativos web no lado do servidor, com foco em back-end.'),
('Programação Web para Front-End', 'Esta disciplina explora as tecnologias e práticas para desenvolvimento de aplicações web e com foco em front-end.'),
('Interface para Dispositivos Móveis', 'A disciplina aborda projetar e desenvolver interfaces de usuário para aplicativos móveis, com foco nos princípios de design e usabilidade.'),
('Banco de Dados', 'Tal disciplina contempla conceitos fundamentais de bancos de dados, modelagem de dados e linguagens de consulta SQL.'),
('Redes de Computadores', 'Esta disciplina aborda conceitos introdutórios sobre redes de computadores, topologias e padrões.'),
('Sistemas Operacionais', 'A disciplina contempla conceitos fundamentais sobre sistemas operacionais, apresentando as funcionalidades dos sistemas operacionais baseados nas plataformas Windows e Linux');

INSERT INTO professor (nome_prof, especialidade_prof, data_admissao_prof)
VALUES
('Eduardo Nascimento', 'Tecnologia da Informação', '2023-01-15'),
('Matheus Michilino', 'Mecatrônica e Interfaces Robóticas', '2020-01-01'),
('Rafael Selvagio', 'Tecnologia da Informação', '2023-06-01'),
('Rafael Rizzi', 'Eng. Elétrica', '2022-01-01');

INSERT INTO curso (nome_curso, duracao_curso)
VALUES
('Técnico em Analise de Desenvolvimento de Sistemas', 18),
('Técnico em Mecatrônica', 24),
('Técnico em Eletrônica', 24),
('Técnico em Administração', 18),
('Técnico em Mecânica', 20);

INSERT INTO turma (qtd_alunos_tur, periodo_tur, semestre_tur)
VALUES
(35, 'Manhã', '2 Semestre'),
(35, 'Tarde', '2 Semestre'),
(18, 'Manhã', '2 Semestre'),
(20, 'Tarde', '4 Semestre'),
(20, 'Tarde', '1 Semestre'),
(36, 'Tarde', '2 Semestre');

INSERT INTO aula (codigo_professor, codigo_disciplina, codigo_turma, data_aula)
VALUES
(3, 1, 1, '2023-10-10'),
(1, 2, 2, '2023-10-11'),
(2, 3, 1, '2023-10-12'),
(1, 2, 1, '2023-10-13'),
(2, 3, 2, '2023-10-15'),
(3, 1, 2, '2023-10-16');

INSERT INTO matricula (codigo_curso, codigo_turma)
VALUES
(1, 1),	
(2, 2),
(1, 3),
(1, 4),
(2, 1);

-- 1 ////////
INSERT INTO professor (nome_prof, especialidade_prof, data_admissao_prof)
VALUES ('Clara Almeida', 'Mecatrônica', '2023-06-11');

INSERT INTO professor (nome_prof, especialidade_prof, data_admissao_prof)
VALUES ('João Gomes', 'Elétrica', '2021-10-10');

INSERT INTO professor (nome_prof, especialidade_prof, data_admissao_prof)
VALUES ('Fernando da Silva', 'Mecânica', '2023-01-01');

INSERT INTO professor (nome_prof, especialidade_prof, data_admissao_prof)
VALUES ('Bento Ramos', 'Elétrica', '2022-02-02');
-- 2

-- UPDATE professor
-- SET nome_prof = 'Clara de Almeida', especialidade_prof = 'Mecatrônica', data_admissao_prof = '2023-06-11'
-- WHERE nome_prof = 'Clara Almeida';

update professor
set nome_prof = 'clara de almeida', especialidade_prof = 'mecatronica', data_admissao_prof ='2023-06-11'
where codigo_prof = 5;

select nome_prof from professor where codigo_prof = 5;

DELETE FROM professor
WHERE nome_prof = 'Fernando da Silva';

 select * from professor;
-- ////////
-- 3 //////

INSERT INTO disciplina (nome_disc, ementa_disc)
VALUES
('Python', 'Python é uma linguagem de programação extremamente popular e amplamente utilizada em diversas áreas. Sua sintaxe simples e legibilidade tornam-na uma ótima escolha para iniciantes, bem como para profissionais experientes.' ),
('Arduido', 'Arduino é uma plataforma programável de prototipagem eletrônica de placa única e hardware livre, que permite aos usuários criar objetos eletrônicos interativos e independentes, usando o microcontrolador Atmel AVR ou ARM com suporte de entrada/saída embutido, uma linguagem de programação padrão, essencialmente C/C++.'),
('Kotlin', 'Kotlin é uma linguagem de programação multiplataforma, orientada a objetos e funcional, concisa e estaticamente tipada, desenvolvida pela JetBrains em 2011, que compila para a Máquina virtual Java e que também pode ser traduzida para a linguagem JavaScript e compilada para código nativo.'),
('Rust', 'Rust é uma linguagem de programação multiparadigma compilada desenvolvida pela Mozilla Research. É projetada para ser "segura, concorrente e prática", mas diferente de outras linguagens seguras, Rust não usa coletor de lixo. Possui suporte nativo ao WebAssembly.' ),
('PHP', 'PHP é uma linguagem interpretada livre, usada originalmente apenas para o desenvolvimento de aplicações presentes e atuantes no lado do servidor, capazes de gerar conteúdo dinâmico na World Wide Web' );

UPDATE disciplina
 SET  nome_disc = 'RusT', ementa_disc = 'RusT é uma linguagem de programação multiparadigma compilada desenvolvida pela Mozilla Research. É projetada para ser segura, concorrente e prática, mas diferente de outras linguagens seguras, Rust não usa coletor de lixo. Possui suporte nativo ao WebAssembly'
 WHERE  codigo_disc = 10;

 select * from disciplina;
 -- //////
-- 4/////
-- Inserir novos alunos
INSERT INTO info_pessoais_aluno (cpf, nome, tel_celular_resp, email_resp)
VALUES
('111.222.333-01', 'richard', '0123456789', 'richardpai@meudominio.com'),
('222.333.444-02', 'caetano', '9876543210', 'caetanomae@meudominio.com'),
('333.444.555-03', 'liria', '1234567890', 'liriamae@meudominio.com'),
('444.555.666-04', 'luz', '5555555555', 'luzvo@meudominio.com');

-- Inserir registros na tabela "aluno"
INSERT INTO aluno (data_inicio_aluno, cpf_aluno, email_aluno)
VALUES
('2023-11-01', '111.222.333-01', 'richard1@meudominio.com'),
('2023-11-02', '222.333.444-02', 'caetano@meudominio.com'),
('2023-11-03', '333.444.555-03', 'liria@meudominio.com'),
('2023-11-04', '444.555.666-04', 'luz@meudominio.com');
-- select * from info_pessoais_aluno;

SAVEPOINT savepoint_antes_insert;

UPDATE aluno
SET email_aluno = 'marioalmeida17@educemail.com'
WHERE cpf_aluno = '111.222.333-01';

DELETE FROM aluno
WHERE cpf_aluno = '333.444.555-03';

ROLLBACK TO savepoint_antes_insert;

select * from info_pessoais_aluno ;
-- ///////

-- 5
-- Inserir 2 novos cursos

INSERT INTO curso (nome_curso, duracao_curso)
VALUES
('tecnico em computaçao grafica ', 24),
('tecnico em desenvolvimento de games ', 18);
-- Criar o primeiro savepoint.
 SAVEPOINT savepoint_inserts_curso;
 
 -- Inserir 3 novos cursos adicionais
INSERT INTO curso (nome_curso, duracao_curso)
VALUES
('tecnico em enfermagem ', 12),
('tecnico de logistica ', 36),
('tecnico de construção ', 24);

-- Criar o segundo savepoint.
SAVEPOINT savepoint_inserts_turma;


-- Inserir 4 novas turmas
INSERT INTO turma (qtd_alunos_tur, periodo_tur, semestre_tur)
VALUES
(40, 'Manhã', '1 Semestre'),
(25, 'Tarde', '2 Semestre'),
(30, 'Noite', '3 Semestre'),
(35, 'Manhã', '4 Semestre');

-- Excluir a terceira turma
DELETE FROM matricula
WHERE codigo_turma = 3;

-- rollback para o save point
ROLLBACK TO savepoint_inserts_turma;

-- commit manual
COMMIT;
