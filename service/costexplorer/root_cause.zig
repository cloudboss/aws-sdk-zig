const RootCauseImpact = @import("root_cause_impact.zig").RootCauseImpact;

/// The combination of Amazon Web Services service, linked account, linked
/// account name,
/// Region, and usage type where a cost anomaly is observed, along with the
/// dollar and
/// percentage amount of the anomaly impact. The linked account name will only
/// be available
/// when the account name can be identified.
pub const RootCause = struct {
    /// The dollar impact for the root cause.
    impact: ?RootCauseImpact = null,

    /// The member account value that's associated with the cost anomaly.
    linked_account: ?[]const u8 = null,

    /// The member account name value that's associated with the cost anomaly.
    linked_account_name: ?[]const u8 = null,

    /// The Amazon Web Services Region that's associated with the cost anomaly.
    region: ?[]const u8 = null,

    /// The Amazon Web Services service name that's associated with the cost
    /// anomaly.
    service: ?[]const u8 = null,

    /// The `UsageType` value that's associated with the cost anomaly.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .impact = "Impact",
        .linked_account = "LinkedAccount",
        .linked_account_name = "LinkedAccountName",
        .region = "Region",
        .service = "Service",
        .usage_type = "UsageType",
    };
};
