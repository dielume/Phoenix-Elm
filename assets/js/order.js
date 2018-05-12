var Order = {
  init(){
    console.log("holi");
    $('.food-order-food input').change( function(){
      var food = $(this)
      let foodId = food.attr("id").slice(18).split("_")[0]
      let quantityID = "#"+"order_food_orders_" + foodId + "_quantity"
      var quantity = $(quantityID)

      console.log(quantityID);
      if (food[0].checked == true) {
        quantity.attr({"min" : 1})
        quantity.val(1)
        quantity.prop('disabled', false)
      } else{
        quantity.attr({"min" : 0})
        quantity.val(0)
        quantity.prop('disabled', true)
      }
    })
  }
}

export default Order
