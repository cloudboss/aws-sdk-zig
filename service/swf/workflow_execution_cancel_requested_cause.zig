pub const WorkflowExecutionCancelRequestedCause = enum {
    child_policy_applied,

    pub const json_field_names = .{
        .child_policy_applied = "CHILD_POLICY_APPLIED",
    };
};
