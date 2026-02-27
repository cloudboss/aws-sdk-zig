/// Specify font outline color. Leave Outline color blank and set Style
/// passthrough to enabled to use the font outline color data from your input
/// captions, if present.
pub const BurninSubtitleOutlineColor = enum {
    black,
    white,
    yellow,
    red,
    green,
    blue,
    auto,

    pub const json_field_names = .{
        .black = "BLACK",
        .white = "WHITE",
        .yellow = "YELLOW",
        .red = "RED",
        .green = "GREEN",
        .blue = "BLUE",
        .auto = "AUTO",
    };
};
