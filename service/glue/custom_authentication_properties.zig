const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;

/// Custom authentication configuration that allows for flexible authentication
/// mechanisms beyond standard Basic and OAuth2 flows.
pub const CustomAuthenticationProperties = struct {
    /// A map of custom authentication parameters that define the specific
    /// authentication mechanism and required properties.
    authentication_parameters: []const ConnectorProperty,

    pub const json_field_names = .{
        .authentication_parameters = "AuthenticationParameters",
    };
};
