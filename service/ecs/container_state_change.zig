const NetworkBinding = @import("network_binding.zig").NetworkBinding;

/// An object that represents a change in state for a container.
pub const ContainerStateChange = struct {
    /// The name of the container.
    container_name: ?[]const u8 = null,

    /// The exit code for the container, if the state change is a result of the
    /// container
    /// exiting.
    exit_code: ?i32 = null,

    /// The container image SHA 256 digest.
    image_digest: ?[]const u8 = null,

    /// Any network bindings that are associated with the container.
    network_bindings: ?[]const NetworkBinding = null,

    /// The reason for the state change.
    reason: ?[]const u8 = null,

    /// The ID of the Docker container.
    runtime_id: ?[]const u8 = null,

    /// The status of the container.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "containerName",
        .exit_code = "exitCode",
        .image_digest = "imageDigest",
        .network_bindings = "networkBindings",
        .reason = "reason",
        .runtime_id = "runtimeId",
        .status = "status",
    };
};
