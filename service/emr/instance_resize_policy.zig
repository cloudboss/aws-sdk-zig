/// Custom policy for requesting termination protection or termination of
/// specific instances
/// when shrinking an instance group.
pub const InstanceResizePolicy = struct {
    /// Specific list of instances to be protected when shrinking an instance group.
    instances_to_protect: ?[]const []const u8 = null,

    /// Specific list of instances to be terminated when shrinking an instance
    /// group.
    instances_to_terminate: ?[]const []const u8 = null,

    /// Decommissioning timeout override for the specific list of instances to be
    /// terminated.
    instance_termination_timeout: ?i32 = null,

    pub const json_field_names = .{
        .instances_to_protect = "InstancesToProtect",
        .instances_to_terminate = "InstancesToTerminate",
        .instance_termination_timeout = "InstanceTerminationTimeout",
    };
};
