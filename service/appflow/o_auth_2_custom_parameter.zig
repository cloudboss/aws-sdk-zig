const OAuth2CustomPropType = @import("o_auth_2_custom_prop_type.zig").OAuth2CustomPropType;

/// Custom parameter required for OAuth 2.0 authentication.
pub const OAuth2CustomParameter = struct {
    /// Contains default values for this authentication parameter that are supplied
    /// by the
    /// connector.
    connector_supplied_values: ?[]const []const u8,

    /// A description about the custom parameter used for OAuth 2.0 authentication.
    description: ?[]const u8,

    /// Indicates whether the custom parameter for OAuth 2.0 authentication is
    /// required.
    is_required: bool = false,

    /// Indicates whether this authentication custom parameter is a sensitive field.
    is_sensitive_field: bool = false,

    /// The key of the custom parameter required for OAuth 2.0 authentication.
    key: ?[]const u8,

    /// The label of the custom parameter used for OAuth 2.0 authentication.
    label: ?[]const u8,

    /// Indicates whether custom parameter is used with TokenUrl or AuthUrl.
    type: ?OAuth2CustomPropType,

    pub const json_field_names = .{
        .connector_supplied_values = "connectorSuppliedValues",
        .description = "description",
        .is_required = "isRequired",
        .is_sensitive_field = "isSensitiveField",
        .key = "key",
        .label = "label",
        .type = "type",
    };
};
