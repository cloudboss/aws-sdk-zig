/// Dvb Sub Destination Subtitle Rows
pub const DvbSubDestinationSubtitleRows = enum {
    rows_16,
    rows_20,
    rows_24,

    pub const json_field_names = .{
        .rows_16 = "ROWS_16",
        .rows_20 = "ROWS_20",
        .rows_24 = "ROWS_24",
    };
};
