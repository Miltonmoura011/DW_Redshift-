select 
	   "dimensional.dimensaocliente"."cliente",
       "dimensional.dimensaocliente"."estado",
       "dimensional.dimensaocliente"."sexo",
       "dimensional.dimensaocliente"."status",
       "dimensional.fatovendas"."quantidade",
       "dimensional.fatovendas"."valorunitario",
       "dimensional.fatovendas"."valortotal",
       "dimensional.fatovendas"."desconto",
       "dimensional.dimensaoproduto"."produto",
       "dimensional.dimensaotempo"."data",
       "dimensional.dimensaotempo"."dia",
       "dimensional.dimensaotempo"."mes",
       "dimensional.dimensaotempo"."ano",
       "dimensional.dimensaotempo"."trimestre",
       "dimensional.dimensaovendedor"."nome"
       
       	INTO dimensional.cubovendas
       
  from (((("dimensional"."dimensaocliente"
       "dimensional.dimensaocliente"
  inner join "dimensional"."fatovendas"
       "dimensional.fatovendas"
       on ("dimensional.fatovendas"."chavecliente" = "dimensional.dimensaocliente"."chavecliente"))
  inner join "dimensional"."dimensaoproduto"
       "dimensional.dimensaoproduto"
       on ("dimensional.dimensaoproduto"."chaveproduto" = "dimensional.fatovendas"."chaveproduto"))
  inner join "dimensional"."dimensaotempo"
       "dimensional.dimensaotempo"
       on ("dimensional.dimensaotempo"."chavetempo" = "dimensional.fatovendas"."chavetempo"))
  inner join "dimensional"."dimensaovendedor"
       "dimensional.dimensaovendedor"
       on ("dimensional.dimensaovendedor"."chavevendedor" = "dimensional.fatovendas"."chavevendedor"))

