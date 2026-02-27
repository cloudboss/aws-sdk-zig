pub const DatabaseOutputMode = enum {
    new_table,

    pub const json_field_names = .{
        .new_table = "NEW_TABLE",
    };
};
