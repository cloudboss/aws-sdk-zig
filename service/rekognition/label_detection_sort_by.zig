pub const LabelDetectionSortBy = enum {
    name,
    timestamp,

    pub const json_field_names = .{
        .name = "NAME",
        .timestamp = "TIMESTAMP",
    };
};
