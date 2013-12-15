class Levels

	@EmptyLevel:{
		pickups:{},
		startPos:{x:0, y:0}
	}

	@LevelOne:{
		pickups:{
			"3_2" : "true",
			"3_7" : "true",
			"6_5" : "true",
		},
		startPos:{
			x:5,
			y:0
		},
		"0_9" : "exit_open",
		"1_9" : "metal",
		"2_9" : "metal",
		"3_0" : "metal",
		"3_1" : "metal",
		"3_2" : "metal",
		"3_3" : "metal",
		"3_6" : "metal",
		"3_7" : "metal",
		"3_8" : "metal",
		"3_9" : "metal",
		"4_0" : "metal",
		"4_3" : "metal",
		"4_6" : "metal",
		"5_0" : "corner",
		"5_3" : "metal",
		"5_6" : "metal",
		"6_3" : "metal",
		"6_4" : "metal",
		"6_5" : "metal",
		"6_6" : "metal"
	}

	@LevelTwo:{
		pickups:{
			"5_3" : "true",
			"5_7" : "true",
		},
		startPos:{
			x:2,
			y:3
		},
		"2_3" : "corner",
		"2_7" : "exit_open",
		"3_3" : "metal",
		"3_7" : "metal",
		"4_3" : "metal",
		"4_4" : "metal",
		"4_7" : "metal",
		"5_3" : "metal",
		"5_4" : "jump",
		"5_7" : "metal",
		"6_3" : "metal",
		"6_7" : "metal",
		"7_3" : "metal",
		"7_4" : "jump",
		"7_6" : "metal",
		"7_7" : "metal"
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
		"2_7" : "metal",
		"3_3" : "jump",
		"3_7" : "metal",
		"4_4" : "metal",
		"4_5" : "metal",
		"4_6" : "metal",
		"4_7" : "metal",
		"5_3" : "jump",
		"6_2" : "metal",
		"6_3" : "metal",
		"6_4" : "jump",
		"6_6" : "metal",
		"6_7" : "metal",
		"7_3" : "metal",
		"7_4" : "metal",
		"7_6" : "jump",
		"7_7" : "metal"
	}

	@LevelFour:{
		pickups:{
			"1_3" : "true",
			"4_2" : "true",
			"7_7" : "true",
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
		"7_5" : "metal",
		"7_6" : "metal",
		"7_7" : "jump",
		"8_6" : "metal",
		"8_7" : "metal"
	}

	@Levels = [Levels.LevelOne, Levels.LevelTwo, Levels.LevelThree, Levels.LevelFour]