import "../LifeSimLib.dart";
import "package:CommonLib/Colours.dart";

class GetASpouse extends Scene {

    @override
    String description = "The Protagonist finds true love. Warning, may produce offspring.";
    @override
    Colour cardColor = StatFactory.ROMCOMMERY.color;

    @override
    String name = "Get a Spouse";

    @override
    int id = -140;

    String backgroundName = "ThisIsLoveIGuess.png";
    GetASpouse(owner) : super(owner);
    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.spouses.isEmpty && owner.rand.nextDouble() < triggerChance ) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      Entity spouse = w.makeSpouse();
      //for some reason turnways makes them invisible???
      //spouse.doll.orientation = Doll.TURNWAYS;
      spouse.turnways = true;
      text = "${owner.name} finds true love in ${spouse.name}.";
      owner.addStatLater(StatFactory.ROMCOMMERY, 1);
      owner.spouses.add(spouse);
      others.add(spouse);
      owner.addStatLater(StatFactory.ESTEEM, 1);

      owner.addStatLater(StatFactory.COMMERCE, -1);
      owner.scenesToAdd.add(new GetAKid(owner));
      owner.scenesToAdd.add(new GoOnDates(owner));

      super.renderContent(element, w);
  }

}