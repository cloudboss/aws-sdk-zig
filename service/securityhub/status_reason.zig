/// Provides additional context for the value of `Compliance.Status`.
pub const StatusReason = struct {
    /// The corresponding description for the status reason code.
    description: ?[]const u8,

    /// A code that represents a reason for the control status. For the list of
    /// status reason
    /// codes and their meanings, see [Compliance details for control
    /// findings](https://docs.aws.amazon.com/securityhub/latest/userguide/controls-findings-create-update.html#control-findings-asff-compliance) in the
    /// *Security Hub User Guide*.
    reason_code: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .reason_code = "ReasonCode",
    };
};
