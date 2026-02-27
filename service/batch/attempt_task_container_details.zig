const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// An object that represents the details of a container that's part of a job
/// attempt.
pub const AttemptTaskContainerDetails = struct {
    /// The exit code for the container’s attempt. A non-zero exit code is
    /// considered failed.
    exit_code: ?i32,

    /// The name of the Amazon CloudWatch Logs log stream that's associated with the
    /// container. The log
    /// group for Batch jobs is `/aws/batch/job`. Each container attempt receives a
    /// log stream name
    /// when they reach the `RUNNING` status.
    log_stream_name: ?[]const u8,

    /// The name of a container.
    name: ?[]const u8,

    /// The network interfaces that are associated with the job attempt.
    network_interfaces: ?[]const NetworkInterface,

    /// A short (255 max characters) string that's easy to understand and provides
    /// additional details for a
    /// running or stopped container.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .exit_code = "exitCode",
        .log_stream_name = "logStreamName",
        .name = "name",
        .network_interfaces = "networkInterfaces",
        .reason = "reason",
    };
};
