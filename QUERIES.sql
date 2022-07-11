-- 1) todos os pacientes que contém responsáveis de uma unidade hospitalar e que estão internados.
select responsavel.nome, responsavel.parentesco, usuario.nome, usuario.datanascimento, paciente.internado
from tb_paciente as paciente
join tb_usuario usuario on usuario.id = paciente.id
join tb_responsavel responsavel on responsavel.id = paciente.responsavelid
where paciente.internado = true;

-- 2 )todos os feriados da agenda do ano de atual.
SELECT * FROM tb_feriado WHERE date_part('year', dataferiado) = date_part('year', CURRENT_DATE);

-- 3) Médicos de um departamento da unidade hospitalar.
select unid.nome as unidade, dep.nome as departamento, med.nome as medico from tb_departamento as dep
join tb_medico med on med.coddepartamento = dep.cod
join tb_unidade unid on unid.id = dep.codunidade 
order by unidade;

-- 4) os atendimentos de um medico em determinada unidade hospitalar
select 
unid.nome as UNIDADE_HOSPITALAR, 
dep.nome as Departamento, 
med.nome as Médico, 
pac.nome as PACIENTE, 
agend.statusatendimento as Situação, 
atend.dataAtendimento as data_hora
from tb_medicoatendimento as atend
join tb_medico med on med.id = atend.idmedico
join tb_agendamentoatendimento agend on agend.id = atend.idagendamento
join tb_departamento dep on dep.cod = med.coddepartamento
join tb_paciente pac on pac.id = agend.pacienteid
join tb_unidade unid on unid.id = dep.codunidade
order by agend.id, atend.dataatendimento;

-- 5) os atendimentos de um medico em determinado departamento
select dep.nome as Departamento, med.nome as Médico, pac.nome as PACIENTE, agend.statusatendimento as Situação, atend.dataatendimento from tb_medicoatendimento as atend
join tb_medico med on med.id = atend.idmedico
join tb_agendamentoatendimento agend on agend.id = atend.idagendamento
join tb_departamento dep on dep.cod = med.coddepartamento
join tb_paciente pac on pac.id = agend.pacienteid
where dep.nome = 'oftalmologia';

-- 6) todos os diagnosticos de um paciente de uma unidade hospitalar
select 
unid.nome as unidade_hospitalar,
pac.nome as paciente,
med.nome as médico, 
dep.nome as departamento, 
diag.nome as diagnóstico,
diag.detalhes
from tb_diagnostico as diag
join tb_medicoatendimento atend on atend.id = diag.idatendimento
join tb_agendamentoatendimento agend on agend.id = atend.idagendamento
join tb_usuario pac on pac.id = agend.pacienteid
join tb_unidade unid on unid.id = pac.unidadeid
join tb_medico med on med.id = atend.idmedico
join tb_departamento dep on dep.cod = med.coddepartamento;

-- 7) todos os departamentos de uma determinada unidade hospitalar.
select unid.nome, dep.nome as Departamento from tb_departamento as dep
join tb_unidade unid on unid.id = dep.codunidade
where unid.nome = 'Unidade Pedro Honório';

-- 8) todos os medicamentos de todos dos pacientes de um responsável
select  pac.nome as paciente, resp.nome as responsavel, medic.nome as medicamento from tb_pacientemedicamento as pac_med
join tb_paciente pac on pac.id = pac_med.pacienteid
join tb_responsavel resp on resp.id = pac.responsavelid
join tb_medicamento medic on medic.id = pac_med.medicamentoid;


-- 9) todos os usuarios de uma unidade hospitalar
select unid.nome unidade_hospitalar, usu.nome as usuario from tb_usuario as usu
join tb_unidade unid on unid.id = usu.unidadeid
order by unid.nome;

-- 10) todos os usuarios pacientes sem responsável
select  pac.nome as paciente from tb_paciente as pac
left join tb_responsavel resp on resp.id = pac.responsavelid
where resp.id is null;