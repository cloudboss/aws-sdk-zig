pub const OrderByFieldType = enum {
    relevance,
    name,
    size,
    created_timestamp,
    modified_timestamp,

    pub const json_field_names = .{
        .relevance = "RELEVANCE",
        .name = "NAME",
        .size = "SIZE",
        .created_timestamp = "CREATED_TIMESTAMP",
        .modified_timestamp = "MODIFIED_TIMESTAMP",
    };
};
