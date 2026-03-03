/// Provides details about the primary Amazon Web Services Region of the
/// endpoint.
pub const AwsEventsEndpointRoutingConfigFailoverConfigPrimaryDetails = struct {
    /// The Amazon Resource Name (ARN) of the health check used by the endpoint to
    /// determine whether failover is triggered.
    health_check: ?[]const u8 = null,

    pub const json_field_names = .{
        .health_check = "HealthCheck",
    };
};
