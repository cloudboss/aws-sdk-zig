/// An object that contains the details of an Security Hub CSPM configuration
/// policy that’s returned in a
/// `ListConfigurationPolicies` request.
pub const ConfigurationPolicySummary = struct {
    /// The Amazon Resource Name (ARN) of the configuration policy.
    arn: ?[]const u8 = null,

    /// The description of the configuration policy.
    description: ?[]const u8 = null,

    /// The universally unique identifier (UUID) of the configuration policy.
    id: ?[]const u8 = null,

    /// The name of the configuration policy. Alphanumeric characters and the
    /// following ASCII characters are permitted:
    /// `-, ., !, *, /`.
    name: ?[]const u8 = null,

    /// Indicates whether the service that the configuration policy applies to is
    /// enabled in the policy.
    service_enabled: ?bool = null,

    /// The date and time, in UTC and ISO 8601 format, that the configuration policy
    /// was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .service_enabled = "ServiceEnabled",
        .updated_at = "UpdatedAt",
    };
};
