pub const ScanBy = enum {
    timestamp_descending,
    timestamp_ascending,

    pub const json_field_names = .{
        .timestamp_descending = "TIMESTAMP_DESCENDING",
        .timestamp_ascending = "TIMESTAMP_ASCENDING",
    };
};
