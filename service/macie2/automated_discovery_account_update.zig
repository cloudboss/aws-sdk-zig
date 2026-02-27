const AutomatedDiscoveryAccountStatus = @import("automated_discovery_account_status.zig").AutomatedDiscoveryAccountStatus;

/// Changes the status of automated sensitive data discovery for an Amazon Macie
/// account.
pub const AutomatedDiscoveryAccountUpdate = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: ?[]const u8,

    /// The new status of automated sensitive data discovery for the account. Valid
    /// values are: ENABLED, perform automated sensitive data discovery activities
    /// for the account; and, DISABLED, don't perform automated sensitive data
    /// discovery activities for the account.
    status: ?AutomatedDiscoveryAccountStatus,

    pub const json_field_names = .{
        .account_id = "accountId",
        .status = "status",
    };
};
