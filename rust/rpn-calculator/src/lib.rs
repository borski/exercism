#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut stack = Vec::new();

    for op in inputs {
        if let CalculatorInput::Value(number) = op {
            stack.push(*number);
        }
        else {
            let a = stack.pop()?;
            let b = stack.pop()?;
            match op {
                CalculatorInput::Add => stack.push(b + a),
                CalculatorInput::Subtract => stack.push(b - a),
                CalculatorInput::Multiply => stack.push(b * a),
                CalculatorInput::Divide => stack.push(b / a),
                _ => (),
            }
        }
    }

    if stack.len() == 1 {
        stack.pop()
    } else {
        None
    }
}
