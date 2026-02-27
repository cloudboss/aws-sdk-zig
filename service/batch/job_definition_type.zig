pub const JobDefinitionType = enum {
    container,
    multinode,

    pub const json_field_names = .{
        .container = "Container",
        .multinode = "Multinode",
    };
};
