class GameModel{
  GameModel(this.target,
   [
      this.current = sliderStart,
      this.totalScore = scoreStart,
      this.round = roudStart
    ]
  );

  static const sliderStart = 50;
  static const scoreStart = 0; 
  static const roudStart  = 1;

  int target; 
  int current;
  int totalScore;
  int round;

}