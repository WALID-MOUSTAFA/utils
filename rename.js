const fs = require("fs");
const readline = require("readline");
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

let COLOR_RED = "\x1b[31m";
let COLOR_RESET = "\x1b[0m";
let COLOR_BLINK = "\x1b[5m";
let COLOR_GREEN = "\x1b[32m";

let EASTERN_NUMERS_STR = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"];
let EASTERN_WESTERN_NUMERS_MAP = {
					"٠": 0,
					"١": 1,
					"٢": 2,
					"٣": 3,
					"٤": 4,
					"٥": 5,
					"٦": 6,
					"٧": 7,
					"٨": 8,
					"٩": 9,
				}

function testStrign(str) {
	return	str.match(/.*[٠١٢٣٤٥٦٧٨٩].*/);
}

function renameFileCorrectly(file) {
	let easternName = file;
	let westernName = "";
	file.split('').forEach(letter=> {
		if(EASTERN_NUMERS_STR.includes(letter)){
			westernName+=EASTERN_WESTERN_NUMERS_MAP[letter];
		} else {
			westernName+=letter;
		}
	})
	fs.rename(file, westernName, ()=> {
		console.log(`renamed file ${file} to ${westernName}`) 
	});
}

function prompt(question) {
	return new Promise(resolve => rl.question(question, resolve));
}

function handleCountTargetedFiles(args){
	let directory = process.argv[2];
	fs.readdir(directory, (err, files)=> {
		let easternNameCounter = 0;
		files.forEach(file=> {
			if(testStrign(file)) {
				easternNameCounter+=1;
			}
		});
		console.log( `there is `,
			COLOR_BLINK, 
			easternNameCounter,
			COLOR_RESET, 
			`files with eastern names`);
	});
}

function handlelistTargetedFiles(args){
	let directory = process.argv[2];
	fs.readdir(directory, (err, files)=> {
		files.forEach(file=> {
			if(testStrign(file)) {
				console.log( COLOR_GREEN, file, COLOR_RESET,)
			}
		});
	});
}

function handleRenameTargetedFiles(args) {
	let directory = process.argv[2];
	fs.readdir(directory, (err, files)=> {
		let targetedFiles = [];
		let easternNameCounter = 0;
		files.forEach(file=> {
			if(testStrign(file)) {
				targetedFiles.push(file);
				easternNameCounter+=1;
			}
		});
		targetedFiles.forEach(file=> {
			renameFileCorrectly(file)
		});
		console.log("DONE, ", `renaming `, COLOR_BLINK, easternNameCounter, 
			COLOR_RESET, "files")
	});
}

async function main() {
	let keepAlive =  true;
	let args = process.argv;
	if(args.length < 3) {
		console.error(COLOR_RED, "Error in number of supplied arguments", 
			COLOR_RESET)
		process.exit();
	}

	while (keepAlive) {
		let answer = await prompt("Enter option(count, list, rename, exit) > ");
		if(answer == "count")  {
			handleCountTargetedFiles(args);
		} else if (answer == "rename") {
			handleRenameTargetedFiles(args)
		} else if (answer == "list") {
			handlelistTargetedFiles(args);
		} else if(answer == "exit") {
			process.exit();
		} else {
			console.log(COLOR_RED, "Wrong Choice!!!!", COLOR_RESET);
		}
	}
}

main();
