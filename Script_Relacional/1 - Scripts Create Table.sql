CREATE SCHEMA Dimensional;
CREATE SCHEMA Relacional;

CREATE SEQUENCE Dimensional.ChaveVendedor;
CREATE TABLE Dimensional.DimensaoVendedor(
  ChaveVendedor int default nextval('Dimensional.ChaveVendedor'::regclass) PRIMARY KEY,
  IDVendedor int,
  Nome Varchar(50),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveCliente;
CREATE TABLE Dimensional.DimensaoCliente(
  ChaveCliente int default nextval('Dimensional.ChaveCliente'::regclass) PRIMARY KEY,
  IDCliente int,
  Cliente Varchar(50),
  Estado Varchar(2),
  Sexo Char(1),
  Status Varchar(50),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveProduto;
CREATE TABLE Dimensional.DimensaoProduto(
  ChaveProduto int default nextval('Dimensional.ChaveProduto'::regclass) PRIMARY KEY,
  IDProduto int,
  Produto Varchar(100),
  DataInicioValidade date not null,
  DataFimValidade date
);

CREATE SEQUENCE Dimensional.ChaveTempo;
CREATE TABLE Dimensional.DimensaoTempo(
  ChaveTempo int default nextval('Dimensional.ChaveTempo'::regclass) PRIMARY KEY,
  Data Date,
  Dia int,
  Mes int,
  Ano int,
  DiaSemana int,
  Trimestre int
);

CREATE SEQUENCE Dimensional.ChaveVendas;
CREATE TABLE Dimensional.FatoVendas(
  ChaveVendas int default nextval('Dimensional.ChaveVendas'::regclass) PRIMARY KEY,
  ChaveVendedor int references Dimensional.DimensaoVendedor (ChaveVendedor),
  ChaveCliente int references Dimensional.DimensaoCliente (ChaveCliente),
  ChaveProduto int references Dimensional.DimensaoProduto (ChaveProduto),
  ChaveTempo int references Dimensional.DimensaoTempo (ChaveTempo),
  Quantidade int,
  ValorUnitario Numeric(10,2),
  ValorTotal Numeric(10,2),
  Desconto Numeric(10,2)
);

CREATE SEQUENCE Relacional.IDVendedor;
CREATE TABLE Relacional.Vendedores(
  IDVendedor int default nextval('Relacional.IDVendedor'::regclass) PRIMARY KEY,
  Nome Varchar(50)
);

CREATE SEQUENCE Relacional.IDProduto;
CREATE TABLE Relacional.Produtos(
  IDProduto int default nextval('Relacional.IDProduto'::regclass) PRIMARY KEY,
  Produto Varchar(100),
  Preco Numeric(10,2)
);

CREATE SEQUENCE Relacional.IDCliente;
CREATE TABLE Relacional.Clientes(
  IDCliente int default nextval('Relacional.IDCliente'::regclass) PRIMARY KEY,
  Cliente Varchar(50),
  Estado Varchar(2),
  Sexo Char(1),
  Status Varchar(50)
);

CREATE SEQUENCE Relacional.IDVenda;
CREATE TABLE Relacional.Vendas(
  IDVenda int default nextval('Relacional.IDVenda'::regclass) PRIMARY KEY,
  IDVendedor int references Relacional.Vendedores (IDVendedor),
  IDCliente int references Relacional.Clientes (IDCliente),
  Data Date,
  Total Numeric(10,2)
);

CREATE TABLE Relacional.ItensVenda (
    IDProduto int REFERENCES Relacional.Produtos ON DELETE RESTRICT,
    IDVenda int REFERENCES Relacional.Vendas ON DELETE CASCADE,
    Quantidade int,
    ValorUnitario decimal(10,2),
    ValorTotal decimal(10,2),
	Desconto decimal(10,2),
    PRIMARY KEY (IDProduto, IDVenda)
);