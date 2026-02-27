pub const Scope = enum {
    entity,
    workspace,

    pub const json_field_names = .{
        .entity = "ENTITY",
        .workspace = "WORKSPACE",
    };
};
