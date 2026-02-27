pub const CelebrityRecognitionSortBy = enum {
    id,
    timestamp,

    pub const json_field_names = .{
        .id = "ID",
        .timestamp = "TIMESTAMP",
    };
};
