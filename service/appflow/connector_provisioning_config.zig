const LambdaConnectorProvisioningConfig = @import("lambda_connector_provisioning_config.zig").LambdaConnectorProvisioningConfig;

/// Contains information about the configuration of the connector being
/// registered.
pub const ConnectorProvisioningConfig = struct {
    /// Contains information about the configuration of the lambda which is being
    /// registered as
    /// the connector.
    lambda: ?LambdaConnectorProvisioningConfig,

    pub const json_field_names = .{
        .lambda = "lambda",
    };
};
