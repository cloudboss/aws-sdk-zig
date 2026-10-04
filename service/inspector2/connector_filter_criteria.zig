const StringFilter = @import("string_filter.zig").StringFilter;
const AwsConfigConnectorArnFilter = @import("aws_config_connector_arn_filter.zig").AwsConfigConnectorArnFilter;
const ConnectorArnFilter = @import("connector_arn_filter.zig").ConnectorArnFilter;
const ConnectorTypeFilter = @import("connector_type_filter.zig").ConnectorTypeFilter;
const ProviderFilter = @import("provider_filter.zig").ProviderFilter;

/// Contains the filter criteria for narrowing the results returned by a
/// `ListConnectors` request. You can filter by connector ARN, Amazon Web
/// Services account ID, Amazon Web Services Config connector ARN, connector
/// type, or cloud provider.
pub const ConnectorFilterCriteria = struct {
    /// Filter by Amazon Web Services account IDs.
    accounts: ?[]const StringFilter = null,

    /// Filter by Amazon Web Services Config connector ARNs.
    aws_config_connector_arns: ?[]const AwsConfigConnectorArnFilter = null,

    /// Filter by connector ARNs.
    connector_arns: ?[]const ConnectorArnFilter = null,

    /// Filter by connector type.
    connector_type: ?[]const ConnectorTypeFilter = null,

    /// Filter by cloud provider.
    provider: ?[]const ProviderFilter = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .aws_config_connector_arns = "awsConfigConnectorArns",
        .connector_arns = "connectorArns",
        .connector_type = "connectorType",
        .provider = "provider",
    };
};
