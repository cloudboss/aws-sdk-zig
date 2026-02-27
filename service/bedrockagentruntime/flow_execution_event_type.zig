pub const FlowExecutionEventType = enum {
    node,
    flow,

    pub const json_field_names = .{
        .node = "NODE",
        .flow = "FLOW",
    };
};
