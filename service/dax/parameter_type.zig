pub const ParameterType = enum {
    default,
    node_type_specific,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .node_type_specific = "NODE_TYPE_SPECIFIC",
    };
};
