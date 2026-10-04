const ConnectorScanConfiguration = @import("connector_scan_configuration.zig").ConnectorScanConfiguration;

/// Represents a scan configuration and the connectors it applies to. Returned
/// in the results of a `ListConnectorScanConfigurations` request.
pub const ConnectorScanConfigurationItem = struct {
    /// The ARN of the Amazon Web Services Config connector.
    aws_config_connector_arn: []const u8,

    /// The list of connector ARNs associated with this Amazon Web Services Config
    /// connector.
    connector_arns: []const []const u8,

    /// The scan configuration settings.
    scan_configuration: ConnectorScanConfiguration,

    pub const json_field_names = .{
        .aws_config_connector_arn = "awsConfigConnectorArn",
        .connector_arns = "connectorArns",
        .scan_configuration = "scanConfiguration",
    };
};
