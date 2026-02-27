pub const GraphQLApiVisibility = enum {
    global,
    private,

    pub const json_field_names = .{
        .global = "GLOBAL",
        .private = "PRIVATE",
    };
};
