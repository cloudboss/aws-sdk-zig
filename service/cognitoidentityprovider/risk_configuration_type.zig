const AccountTakeoverRiskConfigurationType = @import("account_takeover_risk_configuration_type.zig").AccountTakeoverRiskConfigurationType;
const CompromisedCredentialsRiskConfigurationType = @import("compromised_credentials_risk_configuration_type.zig").CompromisedCredentialsRiskConfigurationType;
const RiskExceptionConfigurationType = @import("risk_exception_configuration_type.zig").RiskExceptionConfigurationType;

/// The settings of risk configuration for threat protection with threat
/// protection in a
/// user pool.
pub const RiskConfigurationType = struct {
    /// The settings for automated responses and notification templates for adaptive
    /// authentication with threat protection.
    account_takeover_risk_configuration: ?AccountTakeoverRiskConfigurationType,

    /// The app client where this configuration is applied. When this parameter
    /// isn't present,
    /// the risk configuration applies to all user pool app clients that don't have
    /// client-level settings.
    client_id: ?[]const u8,

    /// Settings for compromised-credentials actions and authentication types with
    /// threat
    /// protection in full-function `ENFORCED` mode.
    compromised_credentials_risk_configuration: ?CompromisedCredentialsRiskConfigurationType,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64,

    /// Exceptions to the risk evaluation configuration, including always-allow and
    /// always-block IP address ranges.
    risk_exception_configuration: ?RiskExceptionConfigurationType,

    /// The ID of the user pool that has the risk configuration applied.
    user_pool_id: ?[]const u8,

    pub const json_field_names = .{
        .account_takeover_risk_configuration = "AccountTakeoverRiskConfiguration",
        .client_id = "ClientId",
        .compromised_credentials_risk_configuration = "CompromisedCredentialsRiskConfiguration",
        .last_modified_date = "LastModifiedDate",
        .risk_exception_configuration = "RiskExceptionConfiguration",
        .user_pool_id = "UserPoolId",
    };
};
