const ProtectConfigurationRuleOverrideAction = @import("protect_configuration_rule_override_action.zig").ProtectConfigurationRuleOverrideAction;

/// Provides details on phone number rule overrides for a protect configuration.
pub const ProtectConfigurationRuleSetNumberOverride = struct {
    /// The action for the rule to perform of either blocking or allowing messages
    /// to the destination phone number.
    action: ProtectConfigurationRuleOverrideAction,

    /// The time when the rule was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The destination phone number in E.164 format.
    destination_phone_number: []const u8,

    /// The time the rule will expire at. If `ExpirationTimestamp` is not set then
    /// the rule will not expire.
    expiration_timestamp: ?i64 = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .created_timestamp = "CreatedTimestamp",
        .destination_phone_number = "DestinationPhoneNumber",
        .expiration_timestamp = "ExpirationTimestamp",
        .iso_country_code = "IsoCountryCode",
    };
};
