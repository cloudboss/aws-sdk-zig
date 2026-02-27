pub const ColumnDataSubType = enum {
    float,
    fixed,

    pub const json_field_names = .{
        .float = "FLOAT",
        .fixed = "FIXED",
    };
};
