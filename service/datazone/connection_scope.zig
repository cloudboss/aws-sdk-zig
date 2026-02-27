pub const ConnectionScope = enum {
    domain,
    project,

    pub const json_field_names = .{
        .domain = "DOMAIN",
        .project = "PROJECT",
    };
};
