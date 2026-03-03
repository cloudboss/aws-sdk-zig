/// Information about required authentication parameters.
pub const AuthParameter = struct {
    /// Contains default values for this authentication parameter that are supplied
    /// by the
    /// connector.
    connector_supplied_values: ?[]const []const u8 = null,

    /// A description about the authentication parameter.
    description: ?[]const u8 = null,

    /// Indicates whether this authentication parameter is required.
    is_required: bool = false,

    /// Indicates whether this authentication parameter is a sensitive field.
    is_sensitive_field: bool = false,

    /// The authentication key required to authenticate with the connector.
    key: ?[]const u8 = null,

    /// Label used for authentication parameter.
    label: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_supplied_values = "connectorSuppliedValues",
        .description = "description",
        .is_required = "isRequired",
        .is_sensitive_field = "isSensitiveField",
        .key = "key",
        .label = "label",
    };
};
