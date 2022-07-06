# 1 Projeto Hospital_DB

O Hospital_DB trata-se de um schema de banco de dados desenvolvido para implementar um projeto piloto de uma base de dados de um hospital. O objetivo é fornecer esta implementação como entrega do trabalho final de tema de escolha livre para a disciplina Princípio de Banco de Dados.

Data: 06/07/2022

# 2 Pré-requisitos

* [PostGreSQL na última versão](https://www.postgresql.org/download/)

# 3 Instruções para execução

Você pode executar através da IDE. Você também pode compilar e executar através do terminal cada script através do seguinte exemplo de comando:

```
sqlcmd -S myServernomeInstância -i C:myScript.sql
```
# 4 Estrutura deste repositório

TODO:

# 4 Modelo Entidade-Relacionamento deste projeto

![MER](https://github.com/nataliaRabelo/Hospital_DB/blob/main/Hospital_MER.jpg)

# 5 Projeto Lógico

usuario(<u>id</u>,  email, nome,  username, dataNascimento, CPF, RG, telefone, dataCadastro, cep, endereço, numero, complemento, bairro, municipio, estado, tipo)

unidade(<u>id</u>, nome, CNPJ, telefone, dataCadastro, cep, endereço, numero, complemento, bairro, municipio, estado)
 
Departamento(<u>cod</u>, codUnidade, nome)
codUnidade referencia unidade

responsável(<u>id</u>, pacienteId, parentesco)
pacienteId referencia usuario

paciente(<u>id</u>, internado, responsavelId)
id referencia usuario
responsavelId referencia responsavel

medicamento(<u>id</u>, nome, dataCadastro, pacienteId)
pacienteId referencia paciente

agenda(<u>id</u>, dataInicio, dataFim, dataCadastro)
 
configuracaoAgenda(<u>id</u>, agendaId, dataInicio,dataFim, horaInicio, horaFim, quantidadeVagas, dataCadastro, intervaloMinuto)
agendaId referencia agenda
 
tipoAgenda(<u>id</u>, agendaId, nome, dataCadastro)
agendaId referencia agenda

feriado(<u>id</u>, agendaId, data, descricao, dataCadastro)
agendaId referencia agenda

agendamentoAtendimento(<u>id</u>, agendaId, pacienteid, datacadastro, observacao, statusatendimento, retirouMedicamento, dataAtendimento)
pacienteId referencia paciente
agendaId referencia agenda
 
diagnostico(<u>cod</u>, nome, idAtendimento, detalhes)
idAtendimento referecia Agendamento_Atendimento
 
medico(<u>id</u>, nome, CodDepartamento, RG, CPF, CRM, telefone)
codDepartamento referencia Departamento

medicoAtendimento(<u>idMedico</u>, idAtendimento)
idMedico referencia medico
idAtendimento referencia agendamentoAtendimento
