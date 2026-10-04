const AzureScopeConfiguration = @import("azure_scope_configuration.zig").AzureScopeConfiguration;

/// The detailed Azure configuration for a connector.
pub const AzureDetail = struct {
    /// The ARN of the multi-cloud configuration connector used to establish the
    /// connection to Azure.
    aws_config_connector_arn: []const u8,

    /// The list of Azure regions being monitored.
    azure_regions: []const []const u8,

    /// The scope configuration that defines which Azure resources are monitored.
    scope_configuration: AzureScopeConfiguration,

    pub const json_field_names = .{
        .aws_config_connector_arn = "AWSConfigConnectorArn",
        .azure_regions = "AzureRegions",
        .scope_configuration = "ScopeConfiguration",
    };
};
