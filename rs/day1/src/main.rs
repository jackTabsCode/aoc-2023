use std::fs;

fn part1() {
    let file = fs::read_to_string("../../inputs/day1.txt").unwrap();

    let mut answer: u32 = 0;

    for line in file.split("\n") {
        let mut digits = Vec::new();

        for (_, char) in line.char_indices() {
            if let Some(digit) = char.to_digit(10) {
                digits.push(digit);
            }
        }

        if !digits.is_empty() {
            let _str = format!("{}{}", digits.first().unwrap(), digits.last().unwrap());
            let result = _str.parse::<u32>().unwrap();

            answer += result;
        }
    }

    println!("Day 1 answer: {}", answer);
}

fn main() {
    part1()
}
