pub const DataLabelOverlap = enum {
    disable_overlap,
    enable_overlap,

    pub const json_field_names = .{
        .disable_overlap = "DISABLE_OVERLAP",
        .enable_overlap = "ENABLE_OVERLAP",
    };
};
