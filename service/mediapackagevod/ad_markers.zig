pub const AdMarkers = enum {
    none,
    scte35_enhanced,
    passthrough,

    pub const json_field_names = .{
        .none = "NONE",
        .scte35_enhanced = "SCTE35_ENHANCED",
        .passthrough = "PASSTHROUGH",
    };
};
