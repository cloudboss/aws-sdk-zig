/// Defines the settings and parameters required for integrating external
/// security tools and services.
pub const ExternalIntegrationConfiguration = struct {
    /// The ARN of the connector that establishes the integration.
    connector_arn: ?[]const u8,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
    };
};
