const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// An object that represents the details of a container that's part of a job
/// attempt.
pub const AttemptContainerDetail = struct {
    /// The Amazon Resource Name (ARN) of the Amazon ECS container instance that
    /// hosts the job attempt.
    container_instance_arn: ?[]const u8,

    /// The exit code for the job attempt. A non-zero exit code is considered
    /// failed.
    exit_code: ?i32,

    /// The name of the CloudWatch Logs log stream that's associated with the
    /// container. The log
    /// group for Batch jobs is `/aws/batch/job`. Each container attempt receives a
    /// log
    /// stream name when they reach the `RUNNING` status.
    log_stream_name: ?[]const u8,

    /// The network interfaces that are associated with the job attempt.
    network_interfaces: ?[]const NetworkInterface,

    /// A short (255 max characters) human-readable string to provide additional
    /// details for a
    /// running or stopped container.
    reason: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon ECS task that's associated with
    /// the job attempt. Each container
    /// attempt receives a task ARN when they reach the `STARTING` status.
    task_arn: ?[]const u8,

    pub const json_field_names = .{
        .container_instance_arn = "containerInstanceArn",
        .exit_code = "exitCode",
        .log_stream_name = "logStreamName",
        .network_interfaces = "networkInterfaces",
        .reason = "reason",
        .task_arn = "taskArn",
    };
};
