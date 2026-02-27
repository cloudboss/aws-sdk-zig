/// The error code that indicates why a request failed to change the status of
/// automated sensitive data discovery for an Amazon Macie account. Possible
/// values are:
pub const AutomatedDiscoveryAccountUpdateErrorCode = enum {
    account_paused,
    account_not_found,

    pub const json_field_names = .{
        .account_paused = "ACCOUNT_PAUSED",
        .account_not_found = "ACCOUNT_NOT_FOUND",
    };
};
