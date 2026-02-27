/// Dvb Sub Destination Background Color
pub const DvbSubDestinationBackgroundColor = enum {
    black,
    none,
    white,

    pub const json_field_names = .{
        .black = "BLACK",
        .none = "NONE",
        .white = "WHITE",
    };
};
