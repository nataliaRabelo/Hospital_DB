# 1 Projeto Hospital_DB

O Hospital_DB trata-se de um schema de banco de dados desenvolvido para implementar um projeto piloto de uma base de dados de um hospital. O objetivo é fornecer esta implementação como entrega do trabalho final de tema de escolha livre para a disciplina Princípio de Banco de Dados.

Data: 06/07/2022

# 2 Pré-requisitos

* [PostGreSQL na última versão](https://www.postgresql.org/download/)

# 3 Instruções para execução

Você pode executar através do gerenciador de banco de dados. Você também pode compilar e executar através do terminal cada script através do seguinte exemplo de comando:

```
sqlcmd -S myServernomeInstância -i C:myScript.sql
```

# 4 Modelo Entidade-Relacionamento deste projeto

![MER](https://github.com/nataliaRabelo/Hospital_DB/blob/main/Hospital_MER.jpg)

# 5 Projeto Lógico

As chaves primárias de cada tabela do banco de dados estão destacadas.

* Usuario(`id`,  email, nome,  username, dataNascimento, CPF, RG, telefone, dataCadastro, cep, endereço, numero, complemento, bairro, municipio, estado, tipo)

* Unidade(`id`, nome, CNPJ, telefone, dataCadastro, cep, endereço, numero, complemento, bairro, municipio, estado)
 
* Departamento(`cod`, codUnidade, nome)
    * codUnidade referencia unidade 

* Responsável(`id`, pacienteId, parentesco)
    * pacienteId referencia usuario

* Paciente(`id`, internado, responsavelId)
    * id referencia usuario
    * responsavelId referencia responsavel

* Medicamento(`id`, nome, dataCadastro, pacienteId)
    * pacienteId referencia paciente

* Agenda(`id`, dataInicio, dataFim, dataCadastro)
 
* ConfiguracaoAgenda(`id`, agendaId, dataInicio,dataFim, horaInicio, horaFim, quantidadeVagas, dataCadastro, intervaloMinuto)
    * agendaId referencia agenda
 
* TipoAgenda(`id`, agendaId, nome, dataCadastro)
    * agendaId referencia agenda

* Feriado(`id`, agendaId, data, descricao, dataCadastro)
    * AgendaId referencia agenda

* AgendamentoAtendimento(`id`, agendaId, pacienteid, datacadastro, observacao, statusatendimento, retirouMedicamento, dataAtendimento)
    * pacienteId referencia paciente
    * agendaId referencia agenda
 
* Diagnostico(`cod`, nome, idAtendimento, detalhes)
    * idAtendimento referecia Agendamento_Atendimento
 
* Medico(`id`, nome, CodDepartamento, RG, CPF, CRM, telefone)
    * codDepartamento referencia Departamento

* MedicoAtendimento(`idMedico`, idAtendimento)
    * idMedico referencia medico
    * idAtendimento referencia agendamentoAtendimento

# 6 Estrutura deste repositório

* Hospital_DB/
    * CREATE_SCRIPTS.sql
    * QUERIES.sql