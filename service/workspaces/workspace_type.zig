pub const WorkspaceType = enum {
    personal,
    pools,

    pub const json_field_names = .{
        .personal = "PERSONAL",
        .pools = "POOLS",
    };
};
