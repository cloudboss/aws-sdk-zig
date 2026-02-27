const RemediationExceptionResourceKey = @import("remediation_exception_resource_key.zig").RemediationExceptionResourceKey;

/// List of each of the failed delete remediation exceptions with specific
/// reasons.
pub const FailedDeleteRemediationExceptionsBatch = struct {
    /// Returns remediation exception resource key object of the failed items.
    failed_items: ?[]const RemediationExceptionResourceKey,

    /// Returns a failure message for delete remediation exception. For example,
    /// Config creates an exception due to an internal error.
    failure_message: ?[]const u8,

    pub const json_field_names = .{
        .failed_items = "FailedItems",
        .failure_message = "FailureMessage",
    };
};
