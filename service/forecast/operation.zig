pub const Operation = enum {
    add,
    subtract,
    multiply,
    divide,

    pub const json_field_names = .{
        .add = "ADD",
        .subtract = "SUBTRACT",
        .multiply = "MULTIPLY",
        .divide = "DIVIDE",
    };
};
