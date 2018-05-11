# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tuto.Repo.insert!(%Tuto.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tuto.Kitchen

dishes = [%{name: "Ceviche", photo: "ceviche.jpg", price: 35},
          %{name: "Pollo a la brasa", photo: "pollo_a_la_brasa.jpg", price: 45},
          %{name: "Picante de Cuy", photo: "picante_de_cuy.jpg", price: 43},
          %{name: "Olluquito con charqui", photo: "olluquito_con_charqui.jpg", price: 35},
          %{name: "Causa rellena", photo: "causa_rellena.jpg", price: 23},
          %{name: "Lomo saltado", photo: "lomo_saltado.jpg", price: 40},
          %{name: "Ají de gallina", photo: "aji_de_gallina.jpg", price: 35},
          %{name: "Rocoto relleno", photo: "rocoto_relleno.jpg", price: 30},
          %{name: "Papa a la huancaina", photo: "papa_a_la_huancaina.jpg", price: 23},
          %{name: "Anticuchos", photo: "anticuchos.jpg", price: 30},
          %{name: "Tacu tacu", photo: "tacu_tacu.jpg", price: 35},
          %{name: "Cau cau", photo: "cau_cau.jpg", price: 30}]

Enum.map(dishes, fn dish -> Kitchen.create_food(dish) end)
