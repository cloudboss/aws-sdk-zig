/// Dvb Sub Destination Teletext Grid Control
pub const DvbSubDestinationTeletextGridControl = enum {
    fixed,
    scaled,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .scaled = "SCALED",
    };
};
