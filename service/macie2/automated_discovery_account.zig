const AutomatedDiscoveryAccountStatus = @import("automated_discovery_account_status.zig").AutomatedDiscoveryAccountStatus;

/// Provides information about the status of automated sensitive data discovery
/// for an Amazon Macie account.
pub const AutomatedDiscoveryAccount = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: ?[]const u8 = null,

    /// The current status of automated sensitive data discovery for the account.
    /// Possible values are: ENABLED, perform automated sensitive data discovery
    /// activities for the account; and, DISABLED, don't perform automated sensitive
    /// data discovery activities for the account.
    status: ?AutomatedDiscoveryAccountStatus = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .status = "status",
    };
};
