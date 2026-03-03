const ConnectorType = @import("connector_type.zig").ConnectorType;
const IncrementalPullConfig = @import("incremental_pull_config.zig").IncrementalPullConfig;
const SourceConnectorProperties = @import("source_connector_properties.zig").SourceConnectorProperties;

/// Contains information about the configuration of the source connector used in
/// the flow.
pub const SourceFlowConfig = struct {
    /// The API version of the connector when it's used as a source in the flow.
    api_version: ?[]const u8 = null,

    /// The name of the connector profile. This name must be unique for each
    /// connector profile in
    /// the Amazon Web Services account.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ConnectorType,

    /// Defines the configuration for a scheduled incremental data pull. If a valid
    /// configuration
    /// is provided, the fields specified in the configuration are used when
    /// querying for the
    /// incremental data pull.
    incremental_pull_config: ?IncrementalPullConfig = null,

    /// Specifies the information that is required to query a particular source
    /// connector.
    source_connector_properties: SourceConnectorProperties,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .incremental_pull_config = "incrementalPullConfig",
        .source_connector_properties = "sourceConnectorProperties",
    };
};
