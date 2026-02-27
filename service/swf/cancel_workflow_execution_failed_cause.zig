pub const CancelWorkflowExecutionFailedCause = enum {
    unhandled_decision,
    operation_not_permitted,

    pub const json_field_names = .{
        .unhandled_decision = "UNHANDLED_DECISION",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };
};
