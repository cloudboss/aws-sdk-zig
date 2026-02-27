/// Burn In Font Color
pub const BurnInFontColor = enum {
    black,
    blue,
    green,
    red,
    white,
    yellow,

    pub const json_field_names = .{
        .black = "BLACK",
        .blue = "BLUE",
        .green = "GREEN",
        .red = "RED",
        .white = "WHITE",
        .yellow = "YELLOW",
    };
};
