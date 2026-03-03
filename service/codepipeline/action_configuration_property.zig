const ActionConfigurationPropertyType = @import("action_configuration_property_type.zig").ActionConfigurationPropertyType;

/// Represents information about an action configuration property.
pub const ActionConfigurationProperty = struct {
    /// The description of the action configuration property that is displayed to
    /// users.
    description: ?[]const u8 = null,

    /// Whether the configuration property is a key.
    key: bool = false,

    /// The name of the action configuration property.
    name: []const u8,

    /// Indicates that the property is used with `PollForJobs`. When creating a
    /// custom action, an action can have up to one queryable property. If it has
    /// one, that
    /// property must be both required and not secret.
    ///
    /// If you create a pipeline with a custom action type, and that custom action
    /// contains
    /// a queryable property, the value for that configuration property is subject
    /// to other
    /// restrictions. The value must be less than or equal to twenty (20)
    /// characters. The value
    /// can contain only alphanumeric characters, underscores, and hyphens.
    queryable: bool = false,

    /// Whether the configuration property is a required value.
    required: bool = false,

    /// Whether the configuration property is secret. Secrets are hidden from all
    /// calls
    /// except for `GetJobDetails`, `GetThirdPartyJobDetails`,
    /// `PollForJobs`, and `PollForThirdPartyJobs`.
    ///
    /// When updating a pipeline, passing * * * * * without changing any other
    /// values of
    /// the action preserves the previous value of the secret.
    secret: bool = false,

    /// The type of the configuration property.
    @"type": ?ActionConfigurationPropertyType = null,

    pub const json_field_names = .{
        .description = "description",
        .key = "key",
        .name = "name",
        .queryable = "queryable",
        .required = "required",
        .secret = "secret",
        .@"type" = "type",
    };
};
