/// Dvb Sub Destination Alignment
pub const DvbSubDestinationAlignment = enum {
    centered,
    left,
    smart,

    pub const json_field_names = .{
        .centered = "CENTERED",
        .left = "LEFT",
        .smart = "SMART",
    };
};
