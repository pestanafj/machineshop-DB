-- DIO - BOOTCAMP CIÊNCIA DE DADOS EM PYTHON -------------------------
-- DESAFIO DE PROJETO: CRIANDO UM MODELO LÓGICO DO ZERO --------------

-- criar banco de dados
create database machineshopDB;
use machineshopDB;
show tables;

-- CRIAR TABELAS DE ENTIDADE -----------------------------------------

-- CLIENTE

create table clients(
	id int auto_increment primary key,
    _name varchar(45) not null,
    address varchar(255),
    contact varchar(20),
    cpf char(11) not null,
    birth_date date,
    observation varchar(500),
    constraint unique_client_cpf unique (cpf)
);

-- VEÍCULO

create table vehicles(
	id int auto_increment primary key,
    client_id int,
    licence_plate char(7),
    brand varchar(20),
    model varchar(20),
    category enum("SUV", "Sedan", "Hatch"),
    color varchar(20),
    observation varchar(500),
    constraint unique_vehicle_licence_plate unique (licence_plate),
    constraint fk_vehicle_client_id foreign key (client_id) references clients(id)
);

-- PEÇA

create table pieces(
	id int auto_increment primary key,
    piece_name varchar(45),
    model varchar(20),
    producer varchar(30),
    cost float,
    stock int,
    observation varchar(500)
);

-- EQUIPE
create table teams(
	id int auto_increment primary key,
    _name varchar(45) not null,
    expertise varchar(45),
    observation varchar(500)
);

-- MECÂNICO

create table mechanics(
	id int auto_increment primary key,
    team_id int,
    _name varchar(45) not null,
    address varchar(255),
    contact varchar(20),
    cpf char(11) not null,
    birth_date date,
    expertise varchar(45),
    observation varchar(500),
    constraint unique_mechanic_cpf unique (cpf),
    constraint fk_mechanic_team_id foreign key (team_id) references teams(id)
);

-- SERVIÇO

create table services(
	id int auto_increment primary key,
    _name varchar(45) not null,
    _type enum("Manutenção Corretiva", "Manutenção Preventiva"),
    _description varchar(300),
    duration_time float,
    cost float,
    observation varchar(500)
);

-- ORDEM DE SERVIÇO

create table service_orders(
	id int auto_increment primary key,
    vehicle_id int,
    team_id int,
    _status enum("Em análise", "Aguardando autorização", "Em andamento", "Finalizado"),
    start_date date,
    return_date date,
    _description varchar(300),
    cost float,
    observation varchar(500),
    constraint fk_service_order_vehicle_id foreign key (vehicle_id) references vehicles(id),
    constraint fk_service_order_team_id foreign key (team_id) references teams(id)
);


-- CRIAR TABELAS RELACIONAIS -----------------------------------------

-- PEÇA NECESSÁRIA

create table need_piece(
	piece_id int,
    service_id int,
    quantity int,
    constraint fk_need_piece_piece_id foreign key (piece_id) references pieces(id),
    constraint fk_need_piece_service_id foreign key (service_id) references services(id)
);

-- SERVIÇO NECESSÁRIO

create table need_service(
	service_order_id int,
    service_id int,
   constraint fk_need_service_service_order_id foreign key (service_order_id) references service_orders(id),
   constraint fk_need_service_service_id foreign key (service_id) references services(id)
);