/// Represents information about each property specified in the action
/// configuration, such
/// as the description and key name that display for the customer using the
/// action
/// type.
pub const ActionTypeProperty = struct {
    /// The description of the property that is displayed to users.
    description: ?[]const u8,

    /// Whether the configuration property is a key.
    key: bool = false,

    /// The property name that is displayed to users.
    name: []const u8,

    /// Whether to omit the field value entered by the customer in the log. If
    /// `true`, the value is not saved in CloudTrail logs for the action
    /// execution.
    no_echo: bool = false,

    /// Whether the configuration property is an optional value.
    optional: bool = false,

    /// Indicates that the property is used with polling. An action type can have up
    /// to one
    /// queryable property. If it has one, that property must be both required and
    /// not
    /// secret.
    queryable: bool = false,

    pub const json_field_names = .{
        .description = "description",
        .key = "key",
        .name = "name",
        .no_echo = "noEcho",
        .optional = "optional",
        .queryable = "queryable",
    };
};
