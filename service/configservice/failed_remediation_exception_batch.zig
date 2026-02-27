const RemediationException = @import("remediation_exception.zig").RemediationException;

/// List of each of the failed remediation exceptions with specific reasons.
pub const FailedRemediationExceptionBatch = struct {
    /// Returns remediation exception resource key object of the failed items.
    failed_items: ?[]const RemediationException,

    /// Returns a failure message. For example, the auto-remediation has failed.
    failure_message: ?[]const u8,

    pub const json_field_names = .{
        .failed_items = "FailedItems",
        .failure_message = "FailureMessage",
    };
};
