pub const FlowOperationType = enum {
    flow_flush,
    flow_capture,

    pub const json_field_names = .{
        .flow_flush = "FLOW_FLUSH",
        .flow_capture = "FLOW_CAPTURE",
    };
};
