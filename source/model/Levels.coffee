class Levels

	@EmptyLevel:{
		pickups:{},
		startPos:{x:0, y:0}
	}

	@LevelOne:{
		pickups:{
			"3_6" : "true",
			"5_4" : "true",
			"7_2" : "true",
		},
		startPos:{
			x:3,
			y:2
		},
		"1_5" : "falling",
		"1_6" : "falling",
		"1_7" : "falling",
		"2_7" : "falling",
		"3_2" : "corner",
		"3_4" : "metal",
		"3_5" : "jump",
		"3_6" : "falling",
		"3_7" : "metal",
		"4_2" : "metal",
		"4_4" : "metal",
		"4_5" : "metal",
		"4_7" : "falling",
		"5_2" : "metal",
		"5_4" : "metal",
		"5_7" : "falling",
		"6_2" : "metal",
		"6_7" : "falling",
		"7_2" : "metal",
		"7_4" : "jump",
		"7_7" : "falling",
		"8_2" : "metal",
		"8_3" : "metal",
		"8_4" : "metal",
		"8_7" : "exit_open"
	}

	@LevelTwo:{
		pickups:{
			"4_3" : "true",
			"4_7" : "true",
		},
		startPos:{
			x:1,
			y:3
		},
		"1_3" : "corner",
		"1_7" : "exit_closed",
		"2_3" : "metal",
		"2_7" : "metal",
		"3_3" : "metal",
		"3_4" : "metal",
		"3_7" : "metal",
		"4_3" : "metal",
		"4_4" : "jump",
		"4_7" : "metal",
		"5_3" : "metal",
		"5_7" : "metal",
		"6_3" : "metal",
		"6_4" : "jump",
		"6_6" : "metal",
		"6_7" : "metal",
		"7_6" : "falling",
		"8_4" : "falling",
		"8_5" : "falling",
		"8_6" : "falling"
	}

	@LevelThree:{
		pickups:{
			"4_4" : "true",
			"7_4" : "true",
			"7_7" : "true",
		},
		startPos:{
			x:1,
			y:3
		},
		"1_3" : "corner",
		"1_7" : "exit_closed",
		"2_3" : "metal",
		"2_7" : "falling",
		"3_3" : "jump",
		"3_7" : "falling",
		"4_4" : "falling",
		"4_5" : "falling",
		"4_6" : "falling",
		"4_7" : "falling",
		"5_3" : "jump",
		"6_2" : "metal",
		"6_3" : "metal",
		"6_4" : "jump",
		"6_6" : "metal",
		"6_7" : "metal",
		"7_3" : "falling",
		"7_4" : "metal",
		"7_6" : "jump",
		"7_7" : "metal"
	}

	@LevelFour:{
		pickups:{
			"1_3" : "true",
			"4_2" : "true",
			"8_7" : "true",
		},
		startPos:{
			x:4,
			y:8
		},
		"1_3" : "metal",
		"1_4" : "metal",
		"1_5" : "metal",
		"2_3" : "metal",
		"2_5" : "jump",
		"3_3" : "metal",
		"3_4" : "metal",
		"3_6" : "jump",
		"3_7" : "metal",
		"4_1" : "exit_open",
		"4_2" : "metal",
		"4_4" : "jump",
		"4_5" : "jump",
		"4_6" : "jump",
		"4_7" : "metal",
		"4_8" : "corner",
		"5_4" : "metal",
		"5_6" : "jump",
		"5_7" : "metal",
		"6_5" : "metal",
		"6_6" : "falling",
		"6_7" : "falling",
		"7_5" : "metal",
		"7_6" : "falling",
		"7_7" : "jump",
		"8_6" : "falling",
		"8_7" : "metal"
	}

	@LevelFive:{
		pickups:{
			"2_4" : "true",
			"4_4" : "true",
			"4_7" : "true",
			"7_4" : "true",
		},
		startPos:{
			x:4,
			y:0
		},
		"2_3" : "falling",
		"2_4" : "metal",
		"2_5" : "falling",
		"3_3" : "metal",
		"3_5" : "metal",
		"4_0" : "corner",
		"4_1" : "jump",
		"4_3" : "falling",
		"4_4" : "metal",
		"4_5" : "jump",
		"4_7" : "jump",
		"4_9" : "exit_open",
		"5_3" : "metal",
		"5_5" : "metal",
		"6_3" : "falling",
		"6_4" : "jump",
		"6_5" : "falling",
		"7_3" : "metal",
		"7_4" : "metal",
		"7_5" : "metal",
	}

	@LevelSix:{
		pickups:{
			"3_3" : "true",
			"3_6" : "true",
			"6_3" : "true",
			"6_6" : "true",
		},
		startPos:{
			x:4,
			y:1
		},
		"3_3" : "falling",
		"3_4" : "jump",
		"3_5" : "metal",
		"3_6" : "falling",
		"4_1" : "corner",
		"4_2" : "jump",
		"4_3" : "falling",
		"4_4" : "metal",
		"4_5" : "falling",
		"4_6" : "jump",
		"5_3" : "jump",
		"5_4" : "falling",
		"5_5" : "falling",
		"5_6" : "metal",
		"6_3" : "falling",
		"6_4" : "metal",
		"6_5" : "jump",
		"6_6" : "falling",
		"7_3" : "metal",
		"7_4" : "jump",
		"7_6" : "exit_closed"
	}

	@LevelSeven:{
		pickups:{
			"1_2" : "true",
			"1_5" : "true",
			"4_4" : "true",
			"5_2" : "true",
			"5_8" : "true",
			"8_2" : "true",
			"8_8" : "true",
		},
		startPos:{
			x:1,
			y:8
		},
		"0_5" : "metal",
		"0_8" : "falling",
		"1_1" : "metal",
		"1_2" : "falling",
		"1_4" : "jump",
		"1_5" : "metal",
		"1_7" : "jump",
		"1_8" : "corner",
		"2_1" : "metal",
		"2_5" : "jump",
		"2_8" : "jump",
		"3_1" : "jump",
		"4_2" : "metal",
		"4_4" : "falling",
		"4_5" : "falling",
		"4_8" : "jump",
		"5_1" : "metal",
		"5_2" : "falling",
		"5_4" : "falling",
		"5_5" : "jump",
		"5_7" : "falling",
		"5_8" : "falling",
		"6_2" : "jump",
		"6_7" : "jump",
		"7_8" : "jump",
		"7_9" : "metal",
		"8_2" : "falling",
		"8_3" : "metal",
		"8_4" : "metal",
		"8_5" : "jump",
		"8_7" : "exit_open",
		"8_8" : "falling"
	}

	@Levels = [Levels.LevelTwo, Levels.LevelOne, Levels.LevelThree, Levels.LevelFour, Levels.LevelFive, Levels.LevelSix, Levels.LevelSeven]