const SourceConnectorType = @import("source_connector_type.zig").SourceConnectorType;
const IncrementalPullConfig = @import("incremental_pull_config.zig").IncrementalPullConfig;
const SourceConnectorProperties = @import("source_connector_properties.zig").SourceConnectorProperties;

/// Contains information about the configuration of the source connector used in
/// the
/// flow.
pub const SourceFlowConfig = struct {
    /// The name of the AppFlow connector profile. This name must be unique for each
    /// connector
    /// profile in the AWS account.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector, such as Salesforce, Marketo, and so on.
    connector_type: SourceConnectorType,

    /// Defines the configuration for a scheduled incremental data pull. If a valid
    /// configuration is provided, the fields specified in the configuration are
    /// used when querying
    /// for the incremental data pull.
    incremental_pull_config: ?IncrementalPullConfig = null,

    /// Specifies the information that is required to query a particular source
    /// connector.
    source_connector_properties: SourceConnectorProperties,

    pub const json_field_names = .{
        .connector_profile_name = "ConnectorProfileName",
        .connector_type = "ConnectorType",
        .incremental_pull_config = "IncrementalPullConfig",
        .source_connector_properties = "SourceConnectorProperties",
    };
};
