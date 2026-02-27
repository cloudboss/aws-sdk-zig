pub const AdMarkupType = enum {
    daterange,
    scte35_enhanced,

    pub const json_field_names = .{
        .daterange = "DATERANGE",
        .scte35_enhanced = "SCTE35_ENHANCED",
    };
};
