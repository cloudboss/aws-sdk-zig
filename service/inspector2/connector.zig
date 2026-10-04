const aws = @import("aws");

const EnablementStatus = @import("enablement_status.zig").EnablementStatus;
const ConnectorHealth = @import("connector_health.zig").ConnectorHealth;
const ConnectorCloudProvider = @import("connector_cloud_provider.zig").ConnectorCloudProvider;
const AzureScopeConfiguration = @import("azure_scope_configuration.zig").AzureScopeConfiguration;

/// Describes a connector that links an external cloud provider to Amazon
/// Inspector for vulnerability scanning.
pub const Connector = struct {
    /// Specifies whether the VM scanner is automatically installed on connected
    /// resources.
    auto_install_vm_scanner: ?bool = null,

    /// The ARN of the Amazon Web Services Config connector associated with this
    /// connector.
    aws_config_connector_arn: ?[]const u8 = null,

    /// The Azure regions configured for the connector.
    azure_regions: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: []const u8,

    /// The date and time when the connector was created.
    created_at: i64,

    /// A description of the connector.
    description: ?[]const u8 = null,

    /// The enablement status of the connector, which indicates whether the
    /// connector is active and scanning resources.
    enablement_status: ?EnablementStatus = null,

    /// Additional information about the current enablement status of the connector.
    enablement_status_reason: ?[]const u8 = null,

    /// The health of the connector, which indicates whether Amazon Inspector can
    /// reach and scan the connected resources.
    health: ?ConnectorHealth = null,

    /// The name of the connector.
    name: ?[]const u8 = null,

    /// The cloud provider for the connector.
    provider: ConnectorCloudProvider,

    /// The Azure scope configuration for the connector.
    scope_configuration: ?AzureScopeConfiguration = null,

    /// The tags associated with the connector.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The date and time when the connector was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .auto_install_vm_scanner = "autoInstallVMScanner",
        .aws_config_connector_arn = "awsConfigConnectorArn",
        .azure_regions = "azureRegions",
        .connector_arn = "connectorArn",
        .created_at = "createdAt",
        .description = "description",
        .enablement_status = "enablementStatus",
        .enablement_status_reason = "enablementStatusReason",
        .health = "health",
        .name = "name",
        .provider = "provider",
        .scope_configuration = "scopeConfiguration",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
