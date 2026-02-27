/// Specify the color of the captions text. Leave Font color blank and set Style
/// passthrough to enabled to use the font color data from your input captions,
/// if present. Within your job settings, all of your DVB-Sub settings must be
/// identical.
pub const DvbSubtitleFontColor = enum {
    white,
    black,
    yellow,
    red,
    green,
    blue,
    hex,
    auto,

    pub const json_field_names = .{
        .white = "WHITE",
        .black = "BLACK",
        .yellow = "YELLOW",
        .red = "RED",
        .green = "GREEN",
        .blue = "BLUE",
        .hex = "HEX",
        .auto = "AUTO",
    };
};
