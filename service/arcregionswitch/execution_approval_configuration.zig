/// Configuration for approval steps in a Region switch plan execution. Approval
/// steps require manual intervention before the execution can proceed.
pub const ExecutionApprovalConfiguration = struct {
    /// The IAM approval role for the configuration.
    approval_role: []const u8,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    pub const json_field_names = .{
        .approval_role = "approvalRole",
        .timeout_minutes = "timeoutMinutes",
    };
};
