pub const PersonTrackingSortBy = enum {
    index,
    timestamp,

    pub const json_field_names = .{
        .index = "INDEX",
        .timestamp = "TIMESTAMP",
    };
};
