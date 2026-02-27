pub const ObjectType = enum {
    node,
    leaf_node,
    policy,
    index,

    pub const json_field_names = .{
        .node = "NODE",
        .leaf_node = "LEAF_NODE",
        .policy = "POLICY",
        .index = "INDEX",
    };
};
