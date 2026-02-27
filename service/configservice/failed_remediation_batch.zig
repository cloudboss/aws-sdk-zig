const RemediationConfiguration = @import("remediation_configuration.zig").RemediationConfiguration;

/// List of each of the failed remediations with specific reasons.
pub const FailedRemediationBatch = struct {
    /// Returns remediation configurations of the failed items.
    failed_items: ?[]const RemediationConfiguration,

    /// Returns a failure message. For example, the resource is already compliant.
    failure_message: ?[]const u8,

    pub const json_field_names = .{
        .failed_items = "FailedItems",
        .failure_message = "FailureMessage",
    };
};
