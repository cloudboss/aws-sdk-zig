pub const FlowConnectionType = enum {
    data,
    conditional,

    pub const json_field_names = .{
        .data = "DATA",
        .conditional = "CONDITIONAL",
    };
};
