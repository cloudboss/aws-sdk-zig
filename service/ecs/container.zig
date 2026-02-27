const HealthStatus = @import("health_status.zig").HealthStatus;
const ManagedAgent = @import("managed_agent.zig").ManagedAgent;
const NetworkBinding = @import("network_binding.zig").NetworkBinding;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;

/// A Docker container that's part of a task.
pub const Container = struct {
    /// The Amazon Resource Name (ARN) of the container.
    container_arn: ?[]const u8,

    /// The number of CPU units set for the container. The value is `0` if no value
    /// was specified in the container definition when the task definition was
    /// registered.
    cpu: ?[]const u8,

    /// The exit code returned from the container.
    exit_code: ?i32,

    /// The IDs of each GPU assigned to the container.
    gpu_ids: ?[]const []const u8,

    /// The health status of the container. If health checks aren't configured for
    /// this
    /// container in its task definition, then it reports the health status as
    /// `UNKNOWN`.
    health_status: ?HealthStatus,

    /// The image used for the container.
    image: ?[]const u8,

    /// The container image manifest digest.
    image_digest: ?[]const u8,

    /// The last known status of the container.
    last_status: ?[]const u8,

    /// The details of any Amazon ECS managed agents associated with the container.
    managed_agents: ?[]const ManagedAgent,

    /// The hard limit (in MiB) of memory set for the container.
    memory: ?[]const u8,

    /// The soft limit (in MiB) of memory set for the container.
    memory_reservation: ?[]const u8,

    /// The name of the container.
    name: ?[]const u8,

    /// The network bindings associated with the container.
    network_bindings: ?[]const NetworkBinding,

    /// The network interfaces associated with the container.
    network_interfaces: ?[]const NetworkInterface,

    /// A short (1024 max characters) human-readable string to provide additional
    /// details
    /// about a running or stopped container.
    reason: ?[]const u8,

    /// The ID of the Docker container.
    runtime_id: ?[]const u8,

    /// The ARN of the task.
    task_arn: ?[]const u8,

    pub const json_field_names = .{
        .container_arn = "containerArn",
        .cpu = "cpu",
        .exit_code = "exitCode",
        .gpu_ids = "gpuIds",
        .health_status = "healthStatus",
        .image = "image",
        .image_digest = "imageDigest",
        .last_status = "lastStatus",
        .managed_agents = "managedAgents",
        .memory = "memory",
        .memory_reservation = "memoryReservation",
        .name = "name",
        .network_bindings = "networkBindings",
        .network_interfaces = "networkInterfaces",
        .reason = "reason",
        .runtime_id = "runtimeId",
        .task_arn = "taskArn",
    };
};
