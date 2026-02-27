pub const IndexType = enum {
    enterprise,
    starter,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .starter = "STARTER",
    };
};
