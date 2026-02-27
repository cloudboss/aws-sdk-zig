/// Contains information about the configuration of the lambda which is being
/// registered as
/// the connector.
pub const LambdaConnectorProvisioningConfig = struct {
    /// Lambda ARN of the connector being registered.
    lambda_arn: []const u8,

    pub const json_field_names = .{
        .lambda_arn = "lambdaArn",
    };
};
