pub const ColumnType = enum {
    node,
    edge,
    value,

    pub const json_field_names = .{
        .node = "NODE",
        .edge = "EDGE",
        .value = "VALUE",
    };
};
