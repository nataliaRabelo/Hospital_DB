
CREATE TABLE public.tb_unidade (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome character varying(50) NOT NULL,
    CNPJ character varying(14) NOT NULL,
    telefone character varying(12),
    datacadastro timestamp without time zone NOT NULL,
    cep character varying(8) NOT NULL,
    endereco character varying(100) NOT NULL,
    numero character varying(8),
    complemento character varying(100),
    bairro character varying(100) NOT NULL,
    municipio character varying(100) NOT NULL,
    estado character varying(2) NOT NULL,
    CONSTRAINT unidade_id__pk PRIMARY KEY (id)
);

CREATE TABLE public.tb_usuario (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    email character varying(100) NOT NULL,
    nome character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    dataNascimento DATE NOT NULL,
    CPF character varying(11) NOT NULL,
    RG character varying(9) NOT NULL,
    telefone character varying(12),
    dataCadastro timestamp without time zone NOT NULL,
    cep character varying(8) NOT NULL,
    endereco character varying(100) NOT NULL,
    numero character varying(8),
    complemento character varying(100),
    bairro character varying(100) NOT NULL,
    municipio character varying(100) NOT NULL,
    estado character varying(2) NOT NULL,
    tipo character varying(20),
    unidadeid integer not null,
    CONSTRAINT usuario_id__pk PRIMARY KEY (id),
    CONSTRAINT fk_unidade_usuario FOREIGN KEY (unidadeid)
        REFERENCES public.tb_unidade (id)
);

CREATE TABLE public.tb_departamento (
    cod int NOT NULL GENERATED ALWAYS AS IDENTITY,
    codUnidade int not null,
    nome varchar,
    CONSTRAINT departamento_cod__pk PRIMARY KEY (Cod),
    CONSTRAINT departamento_codUnidade__fk FOREIGN KEY(CodUnidade) REFERENCES tb_unidade(id)
);

CREATE TABLE IF NOT EXISTS public.tb_responsavel
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    parentesco varchar(200) NOT NULL,
    nome varchar(200),
    CONSTRAINT responsavel_id__pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.tb_paciente
(
    id integer NOT NULL,
    nome varchar(200),
    internado boolean NOT NULL,
    responsavelid integer,
    CONSTRAINT paciente_id__pk PRIMARY KEY (id),
    CONSTRAINT paciente_id__fk FOREIGN KEY (id) REFERENCES public.tb_usuario (id),
    CONSTRAINT paciente_responsavelid__fk FOREIGN KEY (responsavelid) REFERENCES public.tb_responsavel (id)
);

CREATE TABLE public.tb_medicamento (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    nome character varying(300) NOT NULL,
    dataCadastro timestamp without time zone NOT NULL,
    CONSTRAINT medicamento_id__pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.tb_tipoagenda
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
    nome character varying(50) NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    CONSTRAINT tipoagenda_id__pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.tb_configuracaoagenda
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    datainicio date NOT NULL,
    datafim date NOT NULL,
    horainicio character varying(8) COLLATE pg_catalog."default",
    horafim character varying(8) COLLATE pg_catalog."default",
    quantidadevagas integer NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    intervalominuto integer NOT NULL,
    unidadeid integer not null,
    tipoagendaid integer not null,
    CONSTRAINT configuracaoagenda_id__pk PRIMARY KEY (id),
    CONSTRAINT fk_config_agenda_tipo FOREIGN KEY (tipoagendaid) REFERENCES public.tb_tipoagenda (id),
    CONSTRAINT fk_unidadeid FOREIGN KEY (unidadeid) REFERENCES public.tb_unidade (id)
);

CREATE TABLE IF NOT EXISTS public.tb_agenda
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    datainicio date NOT NULL,
    datafim date NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    configuracaoagendaid integer not null,
    CONSTRAINT agenda_id__pk PRIMARY KEY (id),
    CONSTRAINT fk_config_agenda FOREIGN KEY (configuracaoagendaid) REFERENCES public.tb_configuracaoagenda (id)
);

CREATE TABLE public.tb_feriado (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    agendaid integer not null,
    dataferiado date NOT NULL,
    descricao character varying(100) NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    CONSTRAINT feriado_agendaid__fk FOREIGN KEY (agendaid) REFERENCES public.tb_agenda(id)
);

CREATE TABLE public.tb_agendamentoAtendimento (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    agendaId int NOT NULL,
    pacienteId int NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    observacao character varying(200),
    statusatendimento character varying(12) NOT NULL,
    retiroumedicamento boolean NOT NULL,
    CONSTRAINT agendamentoAtendimento_id__pk PRIMARY KEY (id),
    CONSTRAINT agendamentoAtendimento_agendaId__fk FOREIGN KEY(agendaId) REFERENCES tb_agenda(id),
    CONSTRAINT agendamentoAtendimento_pacienteId__fk FOREIGN KEY (pacienteId) REFERENCES tb_paciente(id) 
    ON DELETE RESTRICT    
);

CREATE TABLE public.tb_medico (
    id int GENERATED ALWAYS AS IDENTITY,
    nome varchar,
    codDepartamento int not null,
    CPF character varying(11) NOT NULL,
    RG character varying(9),
    CRM character varying(6) NOT NULL,
    telefone character varying(12),
    CONSTRAINT medico_id__pk PRIMARY KEY (id),
    CONSTRAINT medico_codDepartamento__fk FOREIGN KEY(codDepartamento) REFERENCES tb_departamento(cod)
    ON DELETE SET NULL
);

CREATE TABLE public.tb_medicoatendimento
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    idmedico integer not null,
    idagendamento integer not null,
    dataatendimento timestamp with time zone not null,
    CONSTRAINT medicoatendimento__pk PRIMARY KEY (id),
    CONSTRAINT medicoatendimento_idatendimento__fk FOREIGN KEY (idagendamento) REFERENCES public.tb_agendamentoatendimento (id),
    CONSTRAINT medicoatendimento_idmedico__fk FOREIGN KEY (idmedico) REFERENCES public.tb_medico (id)
);

CREATE TABLE public.tb_diagnostico (
    cod int not null GENERATED ALWAYS AS IDENTITY,
    nome varchar,
    idatendimento int NOT NULL,
    detalhes varchar,
    CONSTRAINT diagnostico_cod__pk PRIMARY KEY (cod),
    CONSTRAINT diagnostico_idatendimento__fk FOREIGN KEY (idatendimento) REFERENCES tb_medicoatendimento(id)
);

CREATE TABLE public.tb_pacientemedicamento
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    pacienteid integer NOT NULL,
    medicamentoid integer NOT NULL,
    agendamentoid integer NOT NULL,
    datacadastro timestamp without time zone NOT NULL,
    CONSTRAINT tb_pacientemedicamento_pkey PRIMARY KEY (id),
    CONSTRAINT fk_pacientemedicamentos_agendamentos_agendamentoid FOREIGN KEY (agendamentoid)
        REFERENCES public.tb_agendamentoatendimento (id),
    CONSTRAINT fk_pacientemedicamentos_medicamentos_medicamentoid FOREIGN KEY (medicamentoid)
        REFERENCES public.tb_medicamento (id),
    CONSTRAINT fk_pacientemedicamentos_pacientes_pacienteid FOREIGN KEY (pacienteid)
        REFERENCES public.tb_paciente (id)
);