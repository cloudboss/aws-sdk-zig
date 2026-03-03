const ConnectorProfileCredentials = @import("connector_profile_credentials.zig").ConnectorProfileCredentials;
const ConnectorProfileProperties = @import("connector_profile_properties.zig").ConnectorProfileProperties;

/// Defines the connector-specific configuration and credentials for the
/// connector profile.
pub const ConnectorProfileConfig = struct {
    /// The connector-specific credentials required by each connector.
    connector_profile_credentials: ?ConnectorProfileCredentials = null,

    /// The connector-specific properties of the profile configuration.
    connector_profile_properties: ConnectorProfileProperties,

    pub const json_field_names = .{
        .connector_profile_credentials = "connectorProfileCredentials",
        .connector_profile_properties = "connectorProfileProperties",
    };
};
