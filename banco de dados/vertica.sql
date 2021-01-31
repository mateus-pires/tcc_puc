--create database

create database dw;

-- create user, schema and permissions

CREATE USER tccdw identified by 'tccdw@20';

CREATE SCHEMA IF NOT EXISTS tccdw;
GRANT ALL ON SCHEMA tccdw TO tccdw;
GRANT ALL ON ALL TABLES IN SCHEMA tccdw to tccdw;
GRANT USAGE ON SCHEMA tccdw TO tccdw;

-- Dimensão de Data 

CREATE TABLE d_data
    (
    id_data int NOT NULL,
    data date,
    ano int,
    semestre int,
    semestre_ext varchar(9),
    trimestre int,
    trimestre_abr varchar(2),
    trimestre_ext varchar(9),
    mes int,
    mes_abr varchar(3),
    mes_ext varchar(9),
    num_semana_ano int,
    num_semana_mes int,
    dia_mes int,
    num_dia_semana int,
    per_semana varchar(14),
    dia_semana varchar(13),
    data_ext_media varchar(23),
    data_ext_longa varchar(39),
    ano_mes varchar(7),
    ano_mes_abr varchar(8),
    ano_mes_dia varchar(10),
    ind_pri_dia_mes int,
    ind_ult_dia_mes int,
    ind_feriado varchar(25),
    ano_trimestre_abr varchar(8),
    quadrimestre_ext varchar(30),
    quadrimestre_abr varchar(3),
    quadrimestre int
    );
    
    ALTER TABLE d_data ADD CONSTRAINT C_PRIMARY PRIMARY KEY (id_data); 
    
-- Dimensão de Município

      CREATE TABLE d_municipio
(
    id_municipio int NOT NULL,
    cod_municipio varchar(10),
    cod_municipio_ibge varchar(10),
    nome_municipio varchar(255),
    nome_municipio_padronizado varchar(255),
    cod_uf varchar(6),
    uf_nome varchar(255),
    uf_sigla varchar(5),
    cod_regiao varchar(6),
    nome_regiao varchar(255),
    ver_capital varchar(50),
    ver_semi_arido varchar(50),
    ver_extrema_pobreza varchar(50),
    ano_instalacao varchar(5),
    ano_extincao varchar(5),
    latitude float,
    longitude float,
    altitude float,
    area float,
    _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    _id_batch int
);
    
    ALTER TABLE d_municipio ADD CONSTRAINT fk_d_municipio PRIMARY KEY (id_municipio); 
                  
-- Dimensão de Estabelecimento de Saúde 

        CREATE TABLE d_estabelecimento_saude
        (
            id_estabelecimento_saude int NOT NULL,
            cod_cnes varchar(10),       
            cep varchar(8),
            cnpj_mantenedora varchar(15),
            nome_fantasia varchar(100),
            razao_soc_mantenedora varchar(100),
            cod_municipio varchar(10),
            nome_municipio varchar(100),
            _ativador int,
            data_inclusao timestamp,
            data_exclusao timestamp,
            vinculo_sus varchar(15),
            tipo_gestao varchar(255),
            tipo_unidade varchar(255),
            turno_atendimento varchar(255),
            fluxo_clientela varchar(100),
            logradouro varchar(255),
            numero varchar(20),
            bairro varchar(100),
            sigla_estado_processamento varchar(5),
            latitude numeric(9,6),
            longitude numeric(9,6),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );
 
    ALTER TABLE d_estabelecimento_saude ADD CONSTRAINT Pk_estabelecimento_saude PRIMARY KEY (id_estabelecimento_saude); 
 
-- Dimensão de Faixa Etária

        CREATE TABLE d_faixa_anual
        (
            id_faixa_anual int NOT NULL,
            faixa_etaria_siab varchar(50),
            faixa_etaria_siab_ordem int,
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        ); 

    ALTER TABLE d_faixa_anual ADD CONSTRAINT Pk_d_faixa_anual PRIMARY KEY (id_faixa_anual); 
                              
-- Dimensão de CID

        CREATE TABLE d_cid
        (
            id_cid int NOT NULL,
            cod_categoria_cid varchar(5),
            categoria_cid varchar(300),
            grupo_cid varchar(300),
            capitulo_cid varchar(300),
            cid_nome varchar(300),
            cod_capitulo int,
            cod_cid varchar(10),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_cid ADD CONSTRAINT Pk_d_cid PRIMARY KEY (id_cid); 

-- Tabelas Temporárias para Dimensão de CID

        CREATE TABLE t_grupo_cid
        (
            id_grupo_cid int NOT NULL,
            cat_inicial_grupo varchar(5),
            cat_final_grupo varchar(5),
            nome_grupo varchar(300),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE t_grupo_cid ADD CONSTRAINT Pk_t_cid PRIMARY KEY (id_grupo_cid);

     CREATE TABLE t_capitulo_cid
    (
        id_capitulo_cid int NOT NULL,
        cat_inicial_capitulo varchar(5),
        cat_final_capitulo varchar(5),
        nome_capitulo varchar(300),
        _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
        _id_batch int
    );

    ALTER TABLE t_capitulo_cid ADD CONSTRAINT Pk_t_capitulo_cid PRIMARY KEY (id_capitulo_cid); 
    
-- Dimensão de Procedimentos Tabela Unificada 

     CREATE TABLE d_procedimento_tabela_unificada
(
    id_procedimento int NOT NULL,
    cod_procedimento varchar(20),
    nome_procedimento varchar(280),
    complexidade varchar(50),
    sexo varchar(15),
    cod_grupo_procedimento varchar(6),
    nome_grupo_procedimento varchar(255),
    cod_sub_grupo_procedimento varchar(6),
    nome_sub_grupo_procedimento varchar(255),
    cod_forma_organizacao_procedimento varchar(6),
    nome_forma_organizacao_procedimento varchar(255),
    cod_financiamento varchar(6),
    nome_financiamento varchar(255),
    _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    _id_batch int
);
   
    ALTER TABLE d_procedimento_tabela_unificada ADD CONSTRAINT pk_d_procedimento_t_u PRIMARY KEY (id_procedimento); 
                                      
-- Dimensão de Tipo de Gestão

        CREATE TABLE d_tipo_gestao
        (
            id_tipo_gestao int NOT NULL,
            cod_tipo_gestao varchar(4),
            tipo_gestao varchar(50),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );
    
    ALTER TABLE d_tipo_gestao ADD CONSTRAINT Pk_d_tipo_gestao PRIMARY KEY (id_tipo_gestao); 
                                                                      
-- Dimensão de Sexo

        CREATE TABLE d_sexo
        (
            id_sexo int NOT NULL,
            cod_sexo varchar(2),
            descricao varchar(50),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_sexo ADD CONSTRAINT Pk_d_sexo PRIMARY KEY (id_sexo); 
    
-- Dimensão de Tipo de Atendimento

        CREATE TABLE d_tipo_atendimento
        (
            id_tipo_atendimento int NOT NULL,
            cod_tipo_atendimento varchar(2),
            tipo_atendimento varchar(50),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_tipo_atendimento ADD CONSTRAINT Pk_d_tipo_atendimento PRIMARY KEY (id_tipo_atendimento);   
      
-- Dimensão de Informações Apacs

        CREATE TABLE d_informacoes_apacs
        (
            id_informacoes_apacs int NOT NULL,
            cod_tipo_apac varchar(2),
            tipo_apac varchar(20),
            cod_carater_atendimento varchar(2),
            carater_atendimento varchar(90),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_informacoes_apacs ADD CONSTRAINT Pk_d_informacoes_apacs PRIMARY KEY (id_informacoes_apacs); 
    
-- Dimensão de Raça/Cor

        CREATE TABLE d_raca_cor
        (
            id_raca_cor int NOT NULL,
            cod_raca_cor varchar(2),
            raca_cor varchar(40),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_raca_cor ADD CONSTRAINT Pk_d_raca_cor PRIMARY KEY (id_raca_cor); 
    
--Dimensão de Indicador Munícipe

        CREATE TABLE d_indicador_municipe
        (
            id_indicador_municipe int NOT NULL,
            cod_indicador_municipe int,
            indicador_municipe varchar(40),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_indicador_municipe ADD CONSTRAINT Pk_d_indicador_municipe PRIMARY KEY (id_indicador_municipe); 
    
-- Dimensão de Finalidade de Tratamento

        CREATE TABLE d_finalidade_tratamento
        (
            id_finalidade_tratamento int NOT NULL,
            cod_finalidade_tratamento int,
            finalidade_tratamento varchar(40),
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE d_finalidade_tratamento ADD CONSTRAINT Pk_d_finalidade_tratamento PRIMARY KEY (id_finalidade_tratamento); 
               
-- Fato de Quimioterapia

          CREATE TABLE f_quimioterapia
    (   
        numero_apac varchar(15),
        id_data_processamento int NOT NULL,
        id_cid int ,
        id_data_atendimento int NOT NULL,
        id_data_identificacao_patologia int NOT NULL,
        id_data_autorizacao int,
        id_data_inicio_tratamento int,
        id_data_solicitacao int,
        id_estabelecimento_saude int NOT NULL,
        id_estabelecimento_solicitante int ,
        id_faixa_etaria int,
        id_informacoes_apacs int ,
        id_municipio_gestor int NOT NULL,
        id_municipio_atendimento int NOT NULL,
        id_municipio_paciente int NOT NULL,
        id_procedimento_apac int NOT NULL,
        id_raca_cor int,
        id_sexo int,
        id_tipo_atendimento int,
        id_tipo_gestao int,
        qtd_alta int,
        qtd_apac int,
        qtd_encerramento int,
        qtd_obito int,
        qtd_transferencia int,
        qtd_permanencia int,
        valor_total_apac float,
        _dt_hr_carga timestamp,
        _id_batch int,
        sigla_estado_processamento varchar(2),
        id_indicador_municipe int
    );

    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_processamento FOREIGN KEY (id_data_processamento) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_atendimento FOREIGN KEY (id_data_atendimento) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_municipio_gestor FOREIGN KEY (id_municipio_gestor) references d_municipio (id_municipio);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_procedimento_apac FOREIGN KEY (id_procedimento_apac) references d_procedimento_tabela_unificada (id_procedimento);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_municipio_atendimento FOREIGN KEY (id_municipio_atendimento) references d_municipio (id_municipio);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_inicio_tratamento FOREIGN KEY (id_data_inicio_tratamento) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_identificacao_patologia FOREIGN KEY (id_data_identificacao_patologia) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_municipio_paciente FOREIGN KEY (id_municipio_paciente) references d_municipio (id_municipio);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_solicitacao FOREIGN KEY (id_data_solicitacao) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_data_autorizacao FOREIGN KEY (id_data_autorizacao) references d_data (id_data);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_cid FOREIGN KEY (id_cid) references d_cid (id_cid);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_estabelecimento_saude FOREIGN KEY (id_estabelecimento_saude) references d_estabelecimento_saude (id_estabelecimento_saude);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_estabelecimento_solicitante FOREIGN KEY (id_estabelecimento_solicitante) references d_estabelecimento_saude (id_estabelecimento_saude);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_faixa_anual FOREIGN KEY (id_faixa_etaria) references d_faixa_anual (id_faixa_anual);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_informacoes_apacs FOREIGN KEY (id_informacoes_apacs) references d_informacoes_apacs (id_informacoes_apacs);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_raca_cor FOREIGN KEY (id_raca_cor) references d_raca_cor (id_raca_cor);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_sexo FOREIGN KEY (id_sexo) references d_sexo (id_sexo);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_tipo_atendimento FOREIGN KEY (id_tipo_atendimento) references d_tipo_atendimento (id_tipo_atendimento);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_tipo_gestao FOREIGN KEY (id_tipo_gestao) references d_tipo_gestao (id_tipo_gestao);
    ALTER TABLE f_quimioterapia ADD CONSTRAINT fk_d_indicador_municipe FOREIGN KEY (id_indicador_municipe) references d_indicador_municipe (id_indicador_municipe);
       
-- Fato de Radioterapia

          CREATE TABLE f_radioterapia
    (   
        numero_apac varchar(15),
        id_data_processamento int NOT NULL,
        id_cid int ,
        id_data_atendimento int NOT NULL,
        id_data_identificacao_patologia int NOT NULL,
        id_data_autorizacao int,
        id_data_inicio_tratamento int,
        id_data_solicitacao int,
        id_estabelecimento_saude int NOT NULL,
        id_estabelecimento_solicitante int ,
        id_faixa_etaria int,
        id_informacoes_apacs int ,
        id_municipio_gestor int NOT NULL,
        id_municipio_atendimento int NOT NULL,
        id_municipio_paciente int NOT NULL,
        id_procedimento_apac int NOT NULL,
        id_raca_cor int,
        id_sexo int,
        id_tipo_atendimento int,
        id_tipo_gestao int,
        id_finalidade_tratamento int,
        qtd_alta int,
        qtd_apac int,
        qtd_encerramento int,
        qtd_obito int,
        qtd_transferencia int,
        qtd_permanencia int,
        valor_total_apac float,
        _dt_hr_carga timestamp,
        _id_batch int,
        sigla_estado_processamento varchar(2),
        id_indicador_municipe int
    );

    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_processamento FOREIGN KEY (id_data_processamento) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_atendimento FOREIGN KEY (id_data_atendimento) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_municipio_gestor FOREIGN KEY (id_municipio_gestor) references d_municipio (id_municipio);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_procedimento_apac FOREIGN KEY (id_procedimento_apac) references d_procedimento_tabela_unificada (id_procedimento);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_municipio_atendimento FOREIGN KEY (id_municipio_atendimento) references d_municipio (id_municipio);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_inicio_tratamento FOREIGN KEY (id_data_inicio_tratamento) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_identificacao_patologia FOREIGN KEY (id_data_identificacao_patologia) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_municipio_paciente FOREIGN KEY (id_municipio_paciente) references d_municipio (id_municipio);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_solicitacao FOREIGN KEY (id_data_solicitacao) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_data_autorizacao FOREIGN KEY (id_data_autorizacao) references d_data (id_data);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_cid FOREIGN KEY (id_cid) references d_cid (id_cid);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_estabelecimento_saude FOREIGN KEY (id_estabelecimento_saude) references d_estabelecimento_saude (id_estabelecimento_saude);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_estabelecimento_solicitante FOREIGN KEY (id_estabelecimento_solicitante) references d_estabelecimento_saude (id_estabelecimento_saude);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_faixa_anual FOREIGN KEY (id_faixa_etaria) references d_faixa_anual (id_faixa_anual);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_informacoes_apacs FOREIGN KEY (id_informacoes_apacs) references d_informacoes_apacs (id_informacoes_apacs);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_raca_cor FOREIGN KEY (id_raca_cor) references d_raca_cor (id_raca_cor);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_sexo FOREIGN KEY (id_sexo) references d_sexo (id_sexo);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_tipo_atendimento FOREIGN KEY (id_tipo_atendimento) references d_tipo_atendimento (id_tipo_atendimento);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_tipo_gestao FOREIGN KEY (id_tipo_gestao) references d_tipo_gestao (id_tipo_gestao);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_indicador_municipe FOREIGN KEY (id_indicador_municipe) references d_indicador_municipe (id_indicador_municipe);
    ALTER TABLE f_radioterapia ADD CONSTRAINT fk_d_finalidade_tratamento  FOREIGN KEY (id_finalidade_tratamento ) references d_finalidade_tratamento (id_finalidade_tratamento );
          
 -- Fato de Estimativa de Censo

        CREATE TABLE f_censo_populacao
        (
            id_data_referencia int NOT NULL,
            id_municipio int NOT NULL,
            qtd_populacao int,
            _dt_hr_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
            _id_batch int
        );

    ALTER TABLE f_censo_populacao ADD CONSTRAINT Pk_censo_populacao PRIMARY KEY (id_data_referencia,id_municipio); 
    ALTER TABLE f_censo_populacao ADD CONSTRAINT fk_d_data_referencia FOREIGN KEY (id_data_referencia) references d_data (id_data);
    ALTER TABLE f_censo_populacao ADD CONSTRAINT fk_d_municipio FOREIGN KEY (id_municipio) references d_municipio (id_municipio);

-- View da dimensão de CID

CREATE  VIEW tccdw.vw_d_cid AS
 SELECT d_cid.id_cid,
        d_cid.cod_categoria_cid,
        d_cid.categoria_cid,
        d_cid.grupo_cid,
        d_cid.capitulo_cid,
        d_cid.cid_nome,
        d_cid.cod_capitulo,
        d_cid.cod_cid,
        d_cid._dt_hr_carga,
        d_cid._id_batch
 FROM tccdw.d_cid
 WHERE (d_cid.id_cid IN ( SELECT f_quimioterapia.id_cid
 FROM tccdw.f_quimioterapia
 GROUP BY f_quimioterapia.id_cid UNION  SELECT f_radioterapia.id_cid
 FROM tccdw.f_radioterapia
 GROUP BY f_radioterapia.id_cid));
 
 -- View da dimensão de estabelecimento de saúde

CREATE  VIEW tccdw.vw_d_estabelecimento_saude AS
 SELECT d_estabelecimento_saude.id_estabelecimento_saude,
        d_estabelecimento_saude.cod_cnes,
        d_estabelecimento_saude.cep,
        d_estabelecimento_saude.cnpj_mantenedora,
        initcap(d_estabelecimento_saude.nome_fantasia) AS nome_fantasia,
        d_estabelecimento_saude.razao_soc_mantenedora,
        d_estabelecimento_saude._ativador,
        d_estabelecimento_saude.data_inclusao,
        d_estabelecimento_saude.data_exclusao,
        d_estabelecimento_saude.vinculo_sus,
        d_estabelecimento_saude.tipo_gestao,
        d_estabelecimento_saude.tipo_unidade,
        d_estabelecimento_saude.turno_atendimento,
        d_estabelecimento_saude.fluxo_clientela,
        d_estabelecimento_saude.logradouro,
        d_estabelecimento_saude.numero,
        d_estabelecimento_saude.bairro,
        d_estabelecimento_saude.sigla_estado_processamento,
        d_estabelecimento_saude.latitude,
        d_estabelecimento_saude.longitude,
        d_estabelecimento_saude._dt_hr_carga,
        d_estabelecimento_saude._id_batch
 FROM tccdw.d_estabelecimento_saude
 WHERE (d_estabelecimento_saude.id_estabelecimento_saude IN ( SELECT f_quimioterapia.id_estabelecimento_saude
 FROM tccdw.f_quimioterapia
 GROUP BY f_quimioterapia.id_estabelecimento_saude UNION  SELECT f_radioterapia.id_estabelecimento_saude
 FROM tccdw.f_radioterapia
 GROUP BY f_radioterapia.id_estabelecimento_saude));
 
 -- View da dimensão de município, com papel de município de atendimento

CREATE  VIEW tccdw.vw_d_municipio_atendimento AS
 SELECT d_municipio.id_municipio,
        d_municipio.cod_municipio,
        d_municipio.cod_municipio_ibge,
        d_municipio.nome_municipio,
        d_municipio.nome_municipio_padronizado,
        d_municipio.cod_uf,
        d_municipio.uf_nome,
        d_municipio.uf_sigla,
        d_municipio.cod_regiao,
        d_municipio.nome_regiao,
        d_municipio.ver_capital,
        d_municipio.ver_semi_arido,
        d_municipio.ver_extrema_pobreza,
        d_municipio.ano_instalacao,
        d_municipio.ano_extincao,
        d_municipio.latitude,
        d_municipio.longitude,
        d_municipio.altitude,
        d_municipio.area,
        d_municipio._dt_hr_carga,
        d_municipio._id_batch
 FROM tccdw.d_municipio
 WHERE (d_municipio.id_municipio IN ( SELECT f_quimioterapia.id_municipio_atendimento
 FROM tccdw.f_quimioterapia
 GROUP BY f_quimioterapia.id_municipio_atendimento UNION  SELECT f_radioterapia.id_municipio_atendimento
 FROM tccdw.f_radioterapia
 GROUP BY f_radioterapia.id_municipio_atendimento));

-- View da dimensão de Procedimento Tabela Unificada

CREATE  VIEW tccdw.vw_d_procedimento_tabela_unificada AS
 SELECT d_procedimento_tabela_unificada.id_procedimento,
        d_procedimento_tabela_unificada.cod_procedimento,
        initcap(d_procedimento_tabela_unificada.nome_procedimento) AS nome_procedimento,
        d_procedimento_tabela_unificada.complexidade,
        d_procedimento_tabela_unificada.sexo,
        d_procedimento_tabela_unificada.cod_grupo_procedimento,
        d_procedimento_tabela_unificada.nome_grupo_procedimento,
        d_procedimento_tabela_unificada.cod_sub_grupo_procedimento,
        d_procedimento_tabela_unificada.nome_sub_grupo_procedimento,
        d_procedimento_tabela_unificada.cod_forma_organizacao_procedimento,
        d_procedimento_tabela_unificada.nome_forma_organizacao_procedimento,
        d_procedimento_tabela_unificada.cod_financiamento,
        d_procedimento_tabela_unificada.nome_financiamento,
        d_procedimento_tabela_unificada._dt_hr_carga,
        d_procedimento_tabela_unificada._id_batch
 FROM tccdw.d_procedimento_tabela_unificada
 WHERE (d_procedimento_tabela_unificada.id_procedimento IN ( SELECT f_quimioterapia.id_procedimento_apac
 FROM tccdw.f_quimioterapia
 GROUP BY f_quimioterapia.id_procedimento_apac UNION  SELECT f_radioterapia.id_procedimento_apac
 FROM tccdw.f_radioterapia
 GROUP BY f_radioterapia.id_procedimento_apac));
 
-- View das médias mensais de quimioterapia

CREATE  VIEW tccdw.vw_f_medias_mensais_quimioterapia AS
 SELECT coalesce(round((sum(f.qtd_apac) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_apacs,
        coalesce(round((sum(f.valor_total_apac) / count(DISTINCT dd.ano_mes))), 0::float) AS media_valor_apacs,
        coalesce(round((sum(f.qtd_alta) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_altas,
        coalesce(round((sum(f.qtd_permanencia) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_permanencia,
        coalesce(round((sum(f.qtd_transferencia) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_transferencias,
        coalesce(round((sum(f.qtd_encerramento) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_encerramento,
        coalesce(round((sum(f.qtd_obito) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_obitos
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)));

-- View das médias mensais de radioterapia

CREATE  VIEW tccdw.vw_f_medias_mensais_radioterapia AS
 SELECT coalesce(round((sum(f.qtd_apac) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_apacs,
        coalesce(round((sum(f.valor_total_apac) / count(DISTINCT dd.ano_mes))), 0::float) AS media_valor_apacs,
        coalesce(round((sum(f.qtd_alta) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_altas,
        coalesce(round((sum(f.qtd_permanencia) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_permanencia,
        coalesce(round((sum(f.qtd_transferencia) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_transferencias,
        coalesce(round((sum(f.qtd_encerramento) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_encerramento,
        coalesce(round((sum(f.qtd_obito) / count(DISTINCT dd.ano_mes)), 0), 0::numeric(18,0)) AS media_obitos
 FROM (tccdw.f_radioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)));

-- View com valores mensais de quimioterapia

CREATE  VIEW tccdw.vw_f_quimioterapia_mensal AS
 SELECT coalesce(sum(f_quimioterapia.qtd_apac), 0) AS atendimentos_quimio,
        coalesce(sum(f_quimioterapia.qtd_obito), 0) AS obitos_quimio,
        f_quimioterapia.id_data_atendimento,
        f_quimioterapia.id_municipio_atendimento,
        f_quimioterapia.id_estabelecimento_saude,
        f_quimioterapia.id_cid,
        f_quimioterapia.id_procedimento_apac
 FROM tccdw.f_quimioterapia
 GROUP BY f_quimioterapia.id_data_atendimento,
          f_quimioterapia.id_municipio_atendimento,
          f_quimioterapia.id_estabelecimento_saude,
          f_quimioterapia.id_cid,
          f_quimioterapia.id_procedimento_apac;
          
-- View de Radioterapia para gráfico box splot

CREATE  VIEW tccdw.vw_f_radioterapia_box_splot AS
 SELECT sum(f.qtd_apac) AS apacs,
        sum(f.valor_total_apac) AS valor,
        f.id_municipio_atendimento,
        f.id_data_atendimento
 FROM (tccdw.f_radioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))
 GROUP BY f.id_municipio_atendimento,
          f.id_data_atendimento;   
          
-- View com valores mensais de Radioterapia

CREATE  VIEW tccdw.vw_f_radioterapia_mensal AS
 SELECT coalesce(sum(f_radioterapia.qtd_apac), 0) AS atendimentos_radio,
        coalesce(sum(f_radioterapia.qtd_obito), 0) AS obitos_radio,
        f_radioterapia.id_data_atendimento,
        f_radioterapia.id_municipio_atendimento,
        f_radioterapia.id_estabelecimento_saude,
        f_radioterapia.id_cid,
        f_radioterapia.id_procedimento_apac
 FROM tccdw.f_radioterapia
 GROUP BY f_radioterapia.id_data_atendimento,
          f_radioterapia.id_municipio_atendimento,
          f_radioterapia.id_estabelecimento_saude,
          f_radioterapia.id_cid,
          f_radioterapia.id_procedimento_apac;  
          
-- View com dados do último mês carregado de Quimioterapia

CREATE  VIEW tccdw.vw_f_ultimos_mes_quimioterapia AS
 SELECT coalesce(sum(f.qtd_apac), 0) AS qtd_atual_apacs,
        coalesce(sum(f.valor_total_apac), 0::float) AS valor_atual_apacs,
        coalesce(sum(f.qtd_alta), 0) AS qtd_atual_altas,
        coalesce(sum(f.qtd_permanencia), 0) AS qtd_atual_permanencia,
        coalesce(sum(f.qtd_transferencia), 0) AS qtd_atual_transferencias,
        coalesce(sum(f.qtd_encerramento), 0) AS qtd_atual_encerramento,
        coalesce(sum(f.qtd_obito), 0) AS qtd_atual_obitos,
        f.id_sexo,
        f.id_faixa_etaria,
        f.id_cid
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))
 WHERE (dd.ano_mes = ( SELECT max(dd.ano_mes) AS max
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))))
 GROUP BY f.id_sexo,
          f.id_faixa_etaria,
          f.id_cid;          
          
-- View com dados do último mês carregado de Radioterapia

CREATE  VIEW tccdw.vw_f_ultimos_mes_radioterapia AS
 SELECT coalesce(sum(f.qtd_apac), 0) AS qtd_atual_apacs,
        coalesce(sum(f.valor_total_apac), 0::float) AS valor_atual_apacs,
        coalesce(sum(f.qtd_alta), 0) AS qtd_atual_altas,
        coalesce(sum(f.qtd_permanencia), 0) AS qtd_atual_permanencia,
        coalesce(sum(f.qtd_transferencia), 0) AS qtd_atual_transferencias,
        coalesce(sum(f.qtd_encerramento), 0) AS qtd_atual_encerramento,
        coalesce(sum(f.qtd_obito), 0) AS qtd_atual_obitos
 FROM (tccdw.f_radioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))
 WHERE (dd.ano_mes = ( SELECT max(dd.ano_mes) AS max
 FROM (tccdw.f_radioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))));
          
-- View top 10 de métricas de quimioterapia do último mês carregado

CREATE  VIEW tccdw.vw_quimioterapia_top_10_municipes AS
 SELECT sum(f.qtd_apac) AS apacs,
        sum(CASE WHEN (mun.cod_indicador_municipe = 1) THEN f.qtd_apac ELSE 0 END) AS qtd_municipe,
        round(((sum(CASE WHEN (mun.cod_indicador_municipe = 1) THEN f.qtd_apac ELSE 0 END) / sum(f.qtd_apac)) * 100::numeric(18,0)), 2) AS percent_municipe,
        sum(CASE WHEN (mun.cod_indicador_municipe = 2) THEN f.qtd_apac ELSE 0 END) AS qtd_n_municipe,
        round(((sum(CASE WHEN (mun.cod_indicador_municipe = 2) THEN f.qtd_apac ELSE 0 END) / sum(f.qtd_apac)) * 100::numeric(18,0)), 2) AS percent_n_municipe,
        mu.id_municipio
 FROM (((tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento))) JOIN tccdw.d_indicador_municipe mun ON ((mun.id_indicador_municipe = f.id_indicador_municipe))) JOIN tccdw.d_municipio mu ON ((mu.id_municipio = f.id_municipio_atendimento)))
 WHERE (dd.ano_mes = ( SELECT max(dd.ano_mes) AS max
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))))
 GROUP BY mu.id_municipio
 ORDER BY sum(f.qtd_apac) DESC
 LIMIT 10;
          
-- View de top 5 de quimioterapia por cid com dados do último mês

CREATE  VIEW tccdw.vw_quimioterapia_top_5_obitos_cid AS
 SELECT sum(f.qtd_obito) AS obitos,
        f.id_cid
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))
 WHERE (dd.ano_mes = ( SELECT max(dd.ano_mes) AS max
 FROM (tccdw.f_quimioterapia f JOIN tccdw.d_data dd ON ((dd.id_data = f.id_data_atendimento)))))
 GROUP BY f.id_cid
 ORDER BY sum(f.qtd_obito) DESC
 LIMIT 5;          