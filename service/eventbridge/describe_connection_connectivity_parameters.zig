const DescribeConnectionResourceParameters = @import("describe_connection_resource_parameters.zig").DescribeConnectionResourceParameters;

/// If the connection uses a private OAuth endpoint, the parameters for
/// EventBridge to use when authenticating against the endpoint.
///
/// For more information, see [Authorization methods for
/// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-target-connection-auth.html) in the *
/// Amazon EventBridge User Guide*
/// .
pub const DescribeConnectionConnectivityParameters = struct {
    /// The parameters for EventBridge to use when invoking the resource endpoint.
    resource_parameters: DescribeConnectionResourceParameters,

    pub const json_field_names = .{
        .resource_parameters = "ResourceParameters",
    };
};
