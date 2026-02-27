const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// The metadata of the endpoint.
pub const EndpointMetadata = struct {
    /// The name of the endpoint configuration.
    endpoint_config_name: ?[]const u8,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    /// The status of the endpoint. For possible values of the status of an
    /// endpoint, see
    /// [EndpointSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_EndpointSummary.html).
    endpoint_status: ?EndpointStatus,

    /// If the status of the endpoint is `Failed`, or the status is `InService` but
    /// update operation fails, this provides the reason why it failed.
    failure_reason: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_config_name = "EndpointConfigName",
        .endpoint_name = "EndpointName",
        .endpoint_status = "EndpointStatus",
        .failure_reason = "FailureReason",
    };
};
