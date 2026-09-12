class Report
{
   var _gameSpec;
   var _gemBoard;
   var _itemBoard;
   var _itemSpec;
   var _scoreBoard;
   function Report(agScoreBoard, agGameSpec, agGemBoard, agGemSpec, agItemBoard, agItemSpec)
   {
      var _loc3_;
      var _loc2_;
      if(!(agScoreBoard == undefined && agGameSpec == undefined && agGemBoard == undefined && agGemSpec == undefined && agItemBoard == undefined && agItemSpec == undefined))
      {
         this.setSpec(agGameSpec,agItemSpec);
         if(agGemBoard == undefined)
         {
            agGemBoard = new Array();
            _loc3_ = 0;
            while(_loc3_ < agGemSpec.length)
            {
               agGemBoard.push(0);
               _loc3_ = _loc3_ + 1;
            }
         }
         this.setGemBoard(agGemBoard);
         if(agItemBoard == undefined)
         {
            agItemBoard = new Array();
         }
         this.setItemBoard(agItemBoard);
         if(agScoreBoard == undefined)
         {
            agScoreBoard = new Array();
         }
         _loc2_ = 0;
         for(var _loc7_ in this._gameSpec)
         {
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = agScoreBoard.length;
         while(_loc3_ < _loc2_)
         {
            agScoreBoard.push(new Array());
            _loc3_ = _loc3_ + 1;
         }
         while(_loc2_)
         {
            _loc3_ = agScoreBoard[_loc2_ - 1].length;
            while(_loc3_ < this._gameSpec["game" + _loc2_].dat.length)
            {
               agScoreBoard[_loc2_ - 1].push([0,null,0,null,0,null]);
               _loc3_ = _loc3_ + 1;
            }
            _loc2_ = _loc2_ - 1;
         }
         this.setScoreBoard(agScoreBoard);
      }
   }
   function setSpec(agGameSpec, agItemSpec)
   {
      this._gameSpec = agGameSpec;
      this._itemSpec = agItemSpec;
   }
   function getSpec()
   {
      return this._itemSpec.trader1.dat[1].cost;
   }
   function getHighestScore(agGameID, agLevel)
   {
      if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestDate == null)
      {
         return null;
      }
      return this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestScore;
   }
   function getScore(agGameID, agLevel)
   {
      if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestDate == null)
      {
         return null;
      }
      return this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestScore;
   }
   function getInitScore(agGameID, agLevel)
   {
      if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initDate == null)
      {
         return null;
      }
      return this._scoreBoard["game" + agGameID].dat[agLevel - 1].initScore;
   }
   function setScore(agGameID, agLevel, agScore)
   {
      if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initDate == null)
      {
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].initScore = agScore;
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].initDate = new Date();
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestScore = agScore;
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestDate = new Date();
      }
      else if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initDate != null && agScore >= this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestScore)
      {
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestScore = agScore;
         this._scoreBoard["game" + agGameID].dat[agLevel - 1].highestDate = new Date();
      }
      this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestScore = agScore;
      this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestDate = new Date();
   }
   function getCompletedLevel(agGameID, agPassMark)
   {
      var _loc5_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._scoreBoard["game" + agGameID].dat.length)
      {
         if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate != null && this._scoreBoard["game" + agGameID].dat[_loc2_].highestScore / (this._gameSpec["game" + agGameID].dat[_loc2_].playQ * this._gameSpec["game" + agGameID].dat[_loc2_].score) >= agPassMark)
         {
            _loc5_ = _loc5_ + 1;
         }
         else if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate == null || this._scoreBoard["game" + agGameID].dat[_loc2_].initDate != null && this._scoreBoard["game" + agGameID].dat[_loc2_].highestScore / (this._gameSpec["game" + agGameID].dat[_loc2_].playQ * this._gameSpec["game" + agGameID].dat[_loc2_].score) < agPassMark)
         {
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function getNewLevel(agGameID, agPassMark)
   {
      var _loc4_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._scoreBoard["game" + agGameID].dat.length)
      {
         if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate != null && this._scoreBoard["game" + agGameID].dat[_loc2_].highestScore / (this._gameSpec["game" + agGameID].dat[_loc2_].playQ * this._gameSpec["game" + agGameID].dat[_loc2_].score) < agPassMark)
         {
            _loc4_ = 0;
            break;
         }
         if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate == null)
         {
            _loc4_ = _loc2_ + 1;
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function getTotalCompletedLevel(agPassMark)
   {
      var _loc2_ = 0;
      for(var _loc4_ in this._scoreBoard)
      {
         _loc2_ += this.getCompletedLevel(this._scoreBoard[_loc4_].id,agPassMark);
      }
      return _loc2_;
   }
   function checkImprovement(agGameID, agLevel)
   {
      var _loc7_;
      var _loc4_;
      var _loc5_;
      var _loc2_;
      if(agGameID && agLevel)
      {
         if(!(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initDate != null && this._scoreBoard["game" + agGameID].dat[agLevel - 1].initScore != this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestScore))
         {
            return 0;
         }
         if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initScore > this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestScore)
         {
            return -1;
         }
         if(this._scoreBoard["game" + agGameID].dat[agLevel - 1].initScore < this._scoreBoard["game" + agGameID].dat[agLevel - 1].latestScore)
         {
            return 1;
         }
      }
      else if(agGameID)
      {
         _loc7_ = 0;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this._scoreBoard["game" + agGameID].dat.length)
         {
            if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate != null)
            {
               _loc7_ = _loc7_ + 1;
               _loc4_ += this._scoreBoard["game" + agGameID].dat[_loc2_].latestScore;
               _loc5_ += this._scoreBoard["game" + agGameID].dat[_loc2_].initScore;
            }
            _loc2_ = _loc2_ + 1;
         }
         if(_loc5_ > _loc4_)
         {
            return -1;
         }
         if(_loc5_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
   function setScoreBoard(agScoreBoard)
   {
      this._scoreBoard = new Object();
      var _loc2_ = 0;
      var _loc3_;
      var _loc9_;
      var _loc10_;
      var _loc7_;
      var _loc8_;
      var _loc5_;
      var _loc6_;
      while(_loc2_ < agScoreBoard.length)
      {
         this._scoreBoard["game" + (_loc2_ + 1)] = new Object();
         this._scoreBoard["game" + (_loc2_ + 1)].id = _loc2_ + 1;
         this._scoreBoard["game" + (_loc2_ + 1)].dat = new Array();
         _loc3_ = 0;
         while(_loc3_ < agScoreBoard[_loc2_].length)
         {
            if(!agScoreBoard[_loc2_][_loc3_][0])
            {
               _loc9_ = 0;
            }
            else
            {
               _loc9_ = agScoreBoard[_loc2_][_loc3_][0];
            }
            if(!agScoreBoard[_loc2_][_loc3_][2])
            {
               _loc7_ = 0;
            }
            else
            {
               _loc7_ = agScoreBoard[_loc2_][_loc3_][2];
            }
            if(!agScoreBoard[_loc2_][_loc3_][4])
            {
               _loc5_ = 0;
            }
            else
            {
               _loc5_ = agScoreBoard[_loc2_][_loc3_][4];
            }
            if(!agScoreBoard[_loc2_][_loc3_][1])
            {
               _loc10_ = null;
            }
            else
            {
               _loc10_ = this.String2Date(agScoreBoard[_loc2_][_loc3_][1]);
            }
            if(!agScoreBoard[_loc2_][_loc3_][3])
            {
               _loc8_ = null;
            }
            else
            {
               _loc8_ = this.String2Date(agScoreBoard[_loc2_][_loc3_][3]);
            }
            if(!agScoreBoard[_loc2_][_loc3_][5])
            {
               _loc6_ = null;
            }
            else
            {
               _loc6_ = this.String2Date(agScoreBoard[_loc2_][_loc3_][5]);
            }
            this._scoreBoard["game" + (_loc2_ + 1)].dat.push({initScore:_loc9_,initDate:_loc10_,highestScore:_loc7_,highestDate:_loc8_,latestScore:_loc5_,latestDate:_loc6_});
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getScoreBoard()
   {
      return this._scoreBoard;
   }
   function getScoreBoardInArray()
   {
      var _loc4_ = new Array();
      var _loc3_ = 1;
      var _loc2_;
      for(var _loc5_ in this._gameSpec)
      {
         _loc4_.push(new Array());
         _loc2_ = 0;
         while(_loc2_ < this._scoreBoard["game" + _loc3_].dat.length)
         {
            _loc4_[_loc3_ - 1][_loc2_] = new Array();
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].initScore);
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].initDate);
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].highestScore);
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].highestDate);
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].latestScore);
            _loc4_[_loc3_ - 1][_loc2_].push(this._scoreBoard["game" + _loc3_].dat[_loc2_].latestDate);
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc4_;
   }
   function getScoreBoardSummary()
   {
      var _loc8_ = new Array();
      var _loc3_ = 1;
      var _loc4_;
      var _loc5_;
      var _loc6_;
      var _loc7_;
      var _loc2_;
      for(var _loc9_ in this._gameSpec)
      {
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this._scoreBoard["game" + _loc3_].dat.length)
         {
            if(this._scoreBoard["game" + _loc3_].dat[_loc2_].initDate != null)
            {
               _loc4_ = _loc4_ + 1;
               _loc5_ += this._scoreBoard["game" + _loc3_].dat[_loc2_].latestScore;
               _loc6_ += this._scoreBoard["game" + _loc3_].dat[_loc2_].initScore;
               _loc7_ += this._scoreBoard["game" + _loc3_].dat[_loc2_].highestScore;
            }
            _loc2_ = _loc2_ + 1;
         }
         if(_loc4_ > 0)
         {
            _loc8_.push([this._scoreBoard["game" + _loc3_].dat.length,Math.round(_loc7_ / _loc4_),Math.round(_loc6_ / _loc4_),Math.round(_loc5_ / _loc4_),this.checkImprovement(_loc3_)]);
         }
         else
         {
            _loc8_.push([this._scoreBoard["game" + _loc3_].dat.length,null,null,null,0]);
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc8_;
   }
   function getScoreBoardDetail(agGameID)
   {
      var _loc4_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._scoreBoard["game" + agGameID].dat.length)
      {
         if(this._scoreBoard["game" + agGameID].dat[_loc2_].initDate != null)
         {
            _loc4_.push([this._scoreBoard["game" + agGameID].dat[_loc2_].highestScore,this._scoreBoard["game" + agGameID].dat[_loc2_].initScore,this._scoreBoard["game" + agGameID].dat[_loc2_].latestScore,this.checkImprovement(agGameID,_loc2_ + 1)]);
         }
         else
         {
            _loc4_.push([null,null,null,0]);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function setGemBoard(agGemBoard)
   {
      this._gemBoard = agGemBoard.slice(0);
   }
   function setGem(agGemID, agAmount)
   {
      this._gemBoard[agGemID - 1] = agAmount;
   }
   function getGem(agGemID)
   {
      return this._gemBoard[agGemID - 1];
   }
   function getTotalGem()
   {
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._gemBoard.length)
      {
         _loc3_ += this._gemBoard[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function getTotalNormalGem()
   {
      var _loc3_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         _loc3_ += this._gemBoard[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function getTotalSpecialGem()
   {
      var _loc3_ = 0;
      var _loc2_ = 5;
      while(_loc2_ < this._gemBoard.length)
      {
         _loc3_ += this._gemBoard[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function reduceGem(agGemID, agAmount)
   {
      this._gemBoard[agGemID - 1] -= agAmount;
   }
   function addGem(agGemID, agAmount)
   {
      this._gemBoard[agGemID - 1] += agAmount;
   }
   function getGemBoard()
   {
      return this._gemBoard;
   }
   function setItemBoard(agItemBoard)
   {
      this._itemBoard = new Array();
      var _loc2_;
      var _loc4_;
      if(agItemBoard.length > 0)
      {
         _loc2_ = 0;
         while(_loc2_ < agItemBoard.length)
         {
            _loc4_ = agItemBoard[_loc2_][0].split("-");
            this._itemBoard.push({name:agItemBoard[_loc2_][0],traderID:_loc4_[0],itemID:_loc4_[1],amount:agItemBoard[_loc2_][1]});
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function setItem(agItemID, agAmount)
   {
      var _loc3_ = false;
      var _loc2_ = 0;
      while(_loc2_ < this._itemBoard.length)
      {
         if(this._itemBoard[_loc2_].name == agItemID)
         {
            this._itemBoard[_loc2_].amount = agAmount;
            _loc3_ = true;
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc6_;
      if(!_loc3_)
      {
         _loc6_ = agItemID.split("-");
         this._itemBoard.push({name:agItemID,traderID:_loc6_[0],itemID:_loc6_[1],amount:agAmount});
      }
   }
   function addItem(agItemID, agAmount)
   {
      trace("hung adding item/agItemID:" + agItemID + "/agAmount" + agAmount);
      var _loc4_ = false;
      var _loc2_ = 0;
      while(_loc2_ < this._itemBoard.length)
      {
         if(this._itemBoard[_loc2_].name == agItemID)
         {
            this._itemBoard[_loc2_].amount += agAmount;
            _loc4_ = true;
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc6_;
      if(!_loc4_)
      {
         _loc6_ = agItemID.split("-");
         this._itemBoard.push({name:agItemID,traderID:_loc6_[0],itemID:_loc6_[1],amount:agAmount});
      }
   }
   function reduceItem(agItemID, agAmount)
   {
      var _loc2_ = 0;
      var _loc3_;
      var _loc4_;
      while(_loc2_ < this._itemBoard.length)
      {
         if(this._itemBoard[_loc2_].name == agItemID)
         {
            if(this._itemBoard[_loc2_].amount > agAmount)
            {
               this._itemBoard[_loc2_].amount -= agAmount;
            }
            else
            {
               _loc3_ = this._itemBoard.slice(0,_loc2_);
               _loc4_ = this._itemBoard.slice(_loc2_ + 1,this._itemBoard.length);
               this._itemBoard = _loc3_.concat(_loc4_);
            }
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getItemBoard()
   {
      return this._itemBoard;
   }
   function getItemBoardInArray()
   {
      var _loc3_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._itemBoard.length)
      {
         _loc3_.push([this._itemBoard[_loc2_].name,this._itemBoard[_loc2_].amount]);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function getItemAmount(agItemID)
   {
      var _loc3_ = false;
      var _loc2_ = 0;
      while(_loc2_ < this._itemBoard.length)
      {
         if(this._itemBoard[_loc2_].name == agItemID)
         {
            return this._itemBoard[_loc2_].amount;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(!_loc3_)
      {
         return 0;
      }
   }
   function getTotalItemKind(agTraderID)
   {
      var _loc3_ = 0;
      var _loc2_;
      if(agTraderID == undefined)
      {
         _loc3_ = this._itemBoard.length;
      }
      else
      {
         _loc2_ = 0;
         while(_loc2_ < this._itemBoard.length)
         {
            if(this._itemBoard[_loc2_].traderID == agTraderID)
            {
               _loc3_ += 1;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      return _loc3_;
   }
   function getTotalItemAmount(agTraderID)
   {
      var _loc4_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._itemBoard.length)
      {
         if(agTraderID == undefined || this._itemBoard[_loc2_].traderID == agTraderID)
         {
            _loc4_ += this._itemBoard[_loc2_].amount;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function getTotalItemCost(agTraderID)
   {
      var _loc5_ = 0;
      var _loc2_ = 0;
      var _loc3_;
      var _loc4_;
      while(_loc2_ < this._itemBoard.length)
      {
         if(agTraderID == undefined || this._itemBoard[_loc2_].traderID == agTraderID)
         {
            _loc3_ = this._itemSpec["trader" + this._itemBoard[_loc2_].traderID].dat[this._itemBoard[_loc2_].itemID].cost;
            _loc4_ = this._itemSpec["trader" + this._itemBoard[_loc2_].traderID].dat[this._itemBoard[_loc2_].itemID].amount;
            if(_loc4_ > 0)
            {
               _loc5_ += this._itemBoard[_loc2_].amount * _loc3_ / _loc4_;
            }
            else
            {
               _loc5_ += this._itemBoard[_loc2_].amount * _loc3_;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function String2Date(agDateString)
   {
      var _loc6_;
      var _loc2_;
      var _loc3_;
      var _loc4_;
      var _loc1_;
      if(agDateString.indexOf("-") >= 0 && agDateString.split("-").length == 3)
      {
         _loc6_ = agDateString.split(" ");
         _loc2_ = _loc6_[0].split("-");
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(isNaN(_loc2_[_loc1_]))
            {
               return new Date();
            }
            if(_loc1_ == 1)
            {
               if(!(Number(_loc2_[_loc1_]) >= 1 && Number(_loc2_[_loc1_]) <= 12))
               {
                  return new Date();
               }
            }
            else if(_loc1_ == 2)
            {
               if(!(Number(_loc2_[_loc1_]) >= 1 && Number(_loc2_[_loc1_]) <= 31))
               {
                  return new Date();
               }
            }
            _loc1_ = _loc1_ + 1;
         }
         if(agDateString.indexOf(" ") >= 0)
         {
            _loc3_ = _loc6_[1].slice(0).split(":");
            _loc1_ = 0;
            while(_loc1_ < _loc3_.length)
            {
               if(isNaN(_loc3_[_loc1_]))
               {
                  return new Date();
               }
               if(_loc1_ == 0)
               {
                  if(!(Number(_loc3_[_loc1_]) >= 0 && Number(_loc3_[_loc1_]) <= 23))
                  {
                     return new Date();
                  }
               }
               else if(_loc1_ == 1 || _loc1_ == 2)
               {
                  if(!(Number(_loc2_[_loc1_]) >= 0 && Number(_loc2_[_loc1_]) <= 59))
                  {
                     return new Date();
                  }
               }
               _loc1_ = _loc1_ + 1;
            }
            _loc4_ = new Date(Number(_loc2_[0]),Number(_loc2_[1] - 1),Number(_loc2_[2]),Number(_loc3_[0]),Number(_loc3_[1]),Number(_loc3_[2]));
            return _loc4_;
         }
         _loc4_ = new Date(Number(_loc2_[0]),Number(_loc2_[1] - 1),Number(_loc2_[2]));
         return _loc4_;
      }
      return new Date();
   }
}
