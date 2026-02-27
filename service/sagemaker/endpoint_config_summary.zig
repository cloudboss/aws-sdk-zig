/// Provides summary information for an endpoint configuration.
pub const EndpointConfigSummary = struct {
    /// A timestamp that shows when the endpoint configuration was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint configuration.
    endpoint_config_arn: []const u8,

    /// The name of the endpoint configuration.
    endpoint_config_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_config_arn = "EndpointConfigArn",
        .endpoint_config_name = "EndpointConfigName",
    };
};
