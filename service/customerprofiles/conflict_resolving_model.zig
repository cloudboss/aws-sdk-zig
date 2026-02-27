pub const ConflictResolvingModel = enum {
    recency,
    source,

    pub const json_field_names = .{
        .recency = "RECENCY",
        .source = "SOURCE",
    };
};
