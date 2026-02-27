pub const FlowErrorCode = enum {
    validation,
    internal_server,
    node_execution_failed,

    pub const json_field_names = .{
        .validation = "VALIDATION",
        .internal_server = "INTERNAL_SERVER",
        .node_execution_failed = "NODE_EXECUTION_FAILED",
    };
};
