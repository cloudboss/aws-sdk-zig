pub const FlowControlNodeType = enum {
    iterator,
    loop,

    pub const json_field_names = .{
        .iterator = "ITERATOR",
        .loop = "LOOP",
    };
};
