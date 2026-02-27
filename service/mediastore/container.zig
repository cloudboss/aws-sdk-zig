const ContainerStatus = @import("container_status.zig").ContainerStatus;

/// This section describes operations that you can perform on an AWS Elemental
/// MediaStore
/// container.
pub const Container = struct {
    /// The state of access logging on the container. This value is `false` by
    /// default, indicating that AWS Elemental MediaStore does not send access logs
    /// to Amazon CloudWatch Logs. When you enable access logging on the container,
    /// MediaStore changes this value to `true`, indicating that the service
    /// delivers access logs for objects stored in that container to CloudWatch
    /// Logs.
    access_logging_enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the container. The ARN has the following
    /// format:
    ///
    /// arn:aws:::container/
    ///
    /// For example: arn:aws:mediastore:us-west-2:111122223333:container/movies
    arn: ?[]const u8,

    /// Unix timestamp.
    creation_time: ?i64,

    /// The DNS endpoint of the container. Use the endpoint to identify the specific
    /// container when sending requests to the data plane. The service assigns this
    /// value when the
    /// container is created. Once the value has been assigned, it does not change.
    endpoint: ?[]const u8,

    /// The name of the container.
    name: ?[]const u8,

    /// The status of container creation or deletion. The status is one of the
    /// following:
    /// `CREATING`, `ACTIVE`, or `DELETING`. While the service
    /// is creating the container, the status is `CREATING`. When the endpoint is
    /// available, the status changes to `ACTIVE`.
    status: ?ContainerStatus,

    pub const json_field_names = .{
        .access_logging_enabled = "AccessLoggingEnabled",
        .arn = "ARN",
        .creation_time = "CreationTime",
        .endpoint = "Endpoint",
        .name = "Name",
        .status = "Status",
    };
};
