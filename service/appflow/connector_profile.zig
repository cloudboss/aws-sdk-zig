const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ConnectorProfileProperties = @import("connector_profile_properties.zig").ConnectorProfileProperties;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const PrivateConnectionProvisioningState = @import("private_connection_provisioning_state.zig").PrivateConnectionProvisioningState;

/// Describes an instance of a connector. This includes the provided name,
/// credentials ARN,
/// connection-mode, and so on. To keep the API intuitive and extensible, the
/// fields that are
/// common to all types of connector profiles are explicitly specified at the
/// top level. The rest
/// of the connector-specific properties are available via the
/// `connectorProfileProperties` field.
pub const ConnectorProfile = struct {
    /// Indicates the connection mode and if it is public or private.
    connection_mode: ?ConnectionMode,

    /// The label for the connector profile being created.
    connector_label: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the connector profile.
    connector_profile_arn: ?[]const u8,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in the Amazon Web Services account.
    connector_profile_name: ?[]const u8,

    /// The connector-specific properties of the profile configuration.
    connector_profile_properties: ?ConnectorProfileProperties,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ?ConnectorType,

    /// Specifies when the connector profile was created.
    created_at: ?i64,

    /// The Amazon Resource Name (ARN) of the connector profile credentials.
    credentials_arn: ?[]const u8,

    /// Specifies when the connector profile was last updated.
    last_updated_at: ?i64,

    /// Specifies the private connection provisioning state.
    private_connection_provisioning_state: ?PrivateConnectionProvisioningState,

    pub const json_field_names = .{
        .connection_mode = "connectionMode",
        .connector_label = "connectorLabel",
        .connector_profile_arn = "connectorProfileArn",
        .connector_profile_name = "connectorProfileName",
        .connector_profile_properties = "connectorProfileProperties",
        .connector_type = "connectorType",
        .created_at = "createdAt",
        .credentials_arn = "credentialsArn",
        .last_updated_at = "lastUpdatedAt",
        .private_connection_provisioning_state = "privateConnectionProvisioningState",
    };
};
