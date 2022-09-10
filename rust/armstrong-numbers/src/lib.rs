pub fn is_armstrong_number(num: u32) -> bool {
    let digits: Vec<_> = num.to_string()
                            .chars()
                            .map( |d| d.to_digit(10).unwrap())
                            .collect();

    let len = digits.len() as u32;
    let mut sum = 0;

    for digit in digits {
        sum += digit.pow(len)
    }

    sum == num
}
