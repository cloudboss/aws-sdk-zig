pub const DatasetActionType = enum {
    query,
    container,

    pub const json_field_names = .{
        .query = "QUERY",
        .container = "CONTAINER",
    };
};
