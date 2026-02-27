const RuleConfigurationPropertyType = @import("rule_configuration_property_type.zig").RuleConfigurationPropertyType;

/// Represents information about a rule configuration property.
pub const RuleConfigurationProperty = struct {
    /// The description of the action configuration property that is displayed to
    /// users.
    description: ?[]const u8,

    /// Whether the configuration property is a key.
    key: bool = false,

    /// The name of the rule configuration property.
    name: []const u8,

    /// Indicates whether the property can be queried.
    ///
    /// If you create a pipeline with a condition and rule, and that rule contains a
    /// queryable property, the value for that configuration property is subject to
    /// other
    /// restrictions. The value must be less than or equal to twenty (20)
    /// characters. The value
    /// can contain only alphanumeric characters, underscores, and hyphens.
    queryable: bool = false,

    /// Whether the configuration property is a required value.
    required: bool = false,

    /// Whether the configuration property is secret.
    ///
    /// When updating a pipeline, passing * * * * * without changing any other
    /// values of
    /// the action preserves the previous value of the secret.
    secret: bool = false,

    /// The type of the configuration property.
    type: ?RuleConfigurationPropertyType,

    pub const json_field_names = .{
        .description = "description",
        .key = "key",
        .name = "name",
        .queryable = "queryable",
        .required = "required",
        .secret = "secret",
        .type = "type",
    };
};
