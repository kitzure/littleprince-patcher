class Prince3.User
{
   var cardSequence;
   var cards;
   var classLv;
   var className;
   var fullscreen;
   var gameCards;
   var gameResult;
   var gems;
   var items;
   var language;
   var loginName;
   var password;
   var process;
   var schoolName;
   var schoolType;
   var screen_quality;
   var sex;
   var sound_level;
   var userName;
   function User()
   {
      this.userName = "";
      this.loginName = "";
      this.password = "";
      this.sex = 1;
      this.schoolName = "";
      this.schoolType = 1;
      this.classLv = 1;
      this.className = "";
      this.gems = new Array();
      this.gameResult = new Array();
      this.gameCards = new Array();
      this.cards = new Array();
      this.items = new Array();
      this.process = new Array();
      this.cardSequence = new Array();
      this.screen_quality = 2;
      this.fullscreen = 0;
      this.sound_level = 3;
      this.language = 0;
   }
}
