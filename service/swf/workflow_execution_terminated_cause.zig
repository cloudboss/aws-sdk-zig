pub const WorkflowExecutionTerminatedCause = enum {
    child_policy_applied,
    event_limit_exceeded,
    operator_initiated,

    pub const json_field_names = .{
        .child_policy_applied = "CHILD_POLICY_APPLIED",
        .event_limit_exceeded = "EVENT_LIMIT_EXCEEDED",
        .operator_initiated = "OPERATOR_INITIATED",
    };
};
