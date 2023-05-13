# DW_Redshift-
Este é um projeto acadêmico que fiz para praticar conceitos de BI e DW!
Olá! Este foi um projeto acadêmico com a finalidade de praticar conceitos sobre BI e Data Warehouse, neste projeto populei o banco de dados postgresSQL e o Redshift na nuvem da AWS, porém dei prioridade de apresentar os dados na nuvem. Vamos a uma breve explicação do Data Warehouse no postgres. No PostgresSQL eu criei dois schemas um para o modelo relacional e outro para o modelo dimensional:

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/c2cb0d58-f578-489c-9e7f-87288cc8cef2)

No modelo relacional temos as tabelas de clientes, itensvendas, produtos, vendas e vendedores. No modelo dimensional temos as tabelas DimensaoClientes, DimensaoProduto, DimensaoTempo, DimensaoVendedores e fatovendas. Vamos supor que o modelo relacional já tenha os dados, e que já estamos com a modelagem star schema pronta, então é hora de popular as tabelas dimensões e a fato. O SQL é muito poderoso e podemos fazer essa importante tarefa através dele!
Para popular as dimensões eu usei um select, basicamente foi só alterar as tabelas :

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/4a654d05-22a5-4164-bc44-19062b0ac9c6)

Hora de carregar a fato! Observação: Nas tabelas de dimensão e na fato temos duas colunas adicionais que são colunas para auxiliar a fato a ter um “histórico”, ou seja, vamos supor que todo mês temos uma nova carga de dados na fato se algum dado for alterado no modelo relacional, quando esse dado for para o modelo dimensional ele terá a data em que de inicio em que ocorreu a primeira carga e data de fimvalidade, por exemplo, a primeira carga foi no dia 01/06/2023 essa é a data de inicio se esse dado foi alterado no dia 20/06/2023 ele terá essa data como fimvalidade, vamos ver a primeira carga e depois a segunda carga com o dado alterado:

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/be2b51e9-b059-4f51-90aa-063e12ba6e6e)

Agora supondo um update no modelo relacional:

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/8ceb3615-90ed-4688-a8a8-50f4b604f92a)

Realizando um select nos dados alterados:

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/6b92590e-9998-4ce3-9b08-9d3167f21f76)

O que acontece é que o Data Warehouse armazena o momento em que um cliente deixou de ser um cliente silver e passou para gold. Utilizando o mesmo script da primeira imagem populando a tabela fato podemos continuar populando mês a mês basta mudar os números dos meses ou utilizamos no ultimo comando “Where date_part('MONTH', V.DATA) > 01”. 
Hora de subir as tabelas para nuvem da AWS! Importante destacar que eu importei as tabelas em formato csv, mas poderia ser em .sql já que vamos subir para o s3.
De inicio vamos criar um cluster do redshift, eu utilizei um cluster provisionado de apenas 1 nó, na região de São Paulo pois era o local que eu achei o free trial de um cluster provisionado, o tipo do nó era o dc2.large.
Para acessar é bem fácil, após a criação do cluster e o status estiver “Available”, basta clicar no “editor de consultas v2”.

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/b7146f4e-f8b3-447f-abc7-6e4b0a37841d)

Ao acessar ele abre o editor de query em uma nova aba, basta criar o database e as tabelas.

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/28fb2d64-7c5f-461a-82b0-c8691274f825)

Criando as tabelas:

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/c1ed8e7e-0c03-4c0e-a43d-3654faa3f5bb)

Ao total foram 8 tabelas criadas, agora basta popular as tabelas! Vamos fazer isso subindo as tabelas para o bucket do s3! 
Importante destacar que o nome do bucket do s3 ele tem que ser único no mundo todo! A criação é bem rápida e prática, e para carregar os dados basta sabe em qual pasta estão é bem rápido com poucos cliques os dados já estão na nuvem.

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/9e70864b-13c6-41d0-b719-b6aeea28a9d7)

Não podemos nos esquecer de criarmos uma credencial para o nosso usuário sem as chaves da credencial não conseguimos puxar os dados do s3! Basta ir no IAM > Credenciais de segurança e rolar a página toda para baixo e ir em chaves de acesso e criar uma. Não se esqueça de fazer o download ou copiar para um arquivo local pois precisará desta chave, são criadas duas uma é secreta e ela é essencial, por isso guarde-a bem!
Chaves de acesso criadas vamos ao Redshift Importar os dados!

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/627f383f-ff67-42d6-9bfa-d2ae0ed5bae4)

No comando importamos os dados para as tabelas, basta indicar qual o bucket que vamos puxar os dados, as chaves de acesso(credenciais) e a região do bucket.

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/48ecc998-c747-402e-82ec-e791d40e1443)

Podemos inclusive criar uma tabela a partir de um select!

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/7339e416-95ed-488a-b49a-f938ec8e451a)

Visualizando a nova tabela

![image](https://github.com/Miltonmoura011/DW_Redshift-/assets/110420164/8c4ce41f-3184-4576-b9b4-5a0be3afab86)

O Redshift é um excelente banco de dados para se armazenar um Data Warehouse, é escalável e bem fácil de mexer (para quem sabe SQL), em poucos minutos criamos uma tabela dos vendedores armazenando o total de vendas de 2022. Além de ser um banco extremamente rápido não podemos deixar de citar que podemos criar tabelas externas para ambientes de testes!
