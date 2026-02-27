/// Dvb Sub Destination Font Color
pub const DvbSubDestinationFontColor = enum {
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
