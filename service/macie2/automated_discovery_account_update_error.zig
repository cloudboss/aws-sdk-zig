const AutomatedDiscoveryAccountUpdateErrorCode = @import("automated_discovery_account_update_error_code.zig").AutomatedDiscoveryAccountUpdateErrorCode;

/// Provides information about a request that failed to change the status of
/// automated sensitive data discovery for an Amazon Macie account.
pub const AutomatedDiscoveryAccountUpdateError = struct {
    /// The Amazon Web Services account ID for the account that the request applied
    /// to.
    account_id: ?[]const u8,

    /// The error code for the error that caused the request to fail for the account
    /// (accountId). Possible values are: ACCOUNT_NOT_FOUND, the account doesn’t
    /// exist or you're not the Amazon Macie administrator for the account; and,
    /// ACCOUNT_PAUSED, Macie isn’t enabled for the account in the current Amazon
    /// Web Services Region.
    error_code: ?AutomatedDiscoveryAccountUpdateErrorCode,

    pub const json_field_names = .{
        .account_id = "accountId",
        .error_code = "errorCode",
    };
};
