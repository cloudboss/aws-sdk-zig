pub const TableTagPolicyLFPermission = enum {
    describe,
    select,

    pub const json_field_names = .{
        .describe = "DESCRIBE",
        .select = "SELECT",
    };
};
