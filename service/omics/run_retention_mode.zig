pub const RunRetentionMode = enum {
    retain,
    remove,

    pub const json_field_names = .{
        .retain = "RETAIN",
        .remove = "REMOVE",
    };
};
