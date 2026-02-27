const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// An endpoint that hosts a model displayed in the Amazon SageMaker Model
/// Dashboard.
pub const ModelDashboardEndpoint = struct {
    /// A timestamp that indicates when the endpoint was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The endpoint name.
    endpoint_name: []const u8,

    /// The endpoint status.
    endpoint_status: EndpointStatus,

    /// The last time the endpoint was modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_arn = "EndpointArn",
        .endpoint_name = "EndpointName",
        .endpoint_status = "EndpointStatus",
        .last_modified_time = "LastModifiedTime",
    };
};
