function saveScore(agGameID, agLevel, agGameScore, agFinalScore)
{
   trace("saveScore(" + agGameID + ", " + agLevel + ", " + agGameScore + ", " + agFinalScore + ")");
   user.report.setScore(agGameID,agLevel,agGameScore);
   user.score = agFinalScore;
   saveUserData(user);
}
