class ShoppingListNameArg{
  String tittle;
  String email;
  String actualUser;
  ShoppingListNameArg({this.tittle,this.email});
  ShoppingListNameArg.withActualUser({this.email,this.tittle,this.actualUser});
}