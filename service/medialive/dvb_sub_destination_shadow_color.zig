/// Dvb Sub Destination Shadow Color
pub const DvbSubDestinationShadowColor = enum {
    black,
    none,
    white,

    pub const json_field_names = .{
        .black = "BLACK",
        .none = "NONE",
        .white = "WHITE",
    };
};
