const ConnectivityResourceConfigurationArn = @import("connectivity_resource_configuration_arn.zig").ConnectivityResourceConfigurationArn;

/// The parameters for EventBridge to use when invoking the resource endpoint.
pub const ConnectivityResourceParameters = struct {
    /// The parameters for EventBridge to use when invoking the resource endpoint.
    resource_parameters: ConnectivityResourceConfigurationArn,

    pub const json_field_names = .{
        .resource_parameters = "ResourceParameters",
    };
};
