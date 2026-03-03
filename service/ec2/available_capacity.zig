const InstanceCapacity = @import("instance_capacity.zig").InstanceCapacity;

/// The capacity information for instances that can be launched onto the
/// Dedicated Host.
pub const AvailableCapacity = struct {
    /// The number of instances that can be launched onto the Dedicated Host
    /// depending on the
    /// host's available capacity. For Dedicated Hosts that support multiple
    /// instance types,
    /// this parameter represents the number of instances for each instance size
    /// that is
    /// supported on the host.
    available_instance_capacity: ?[]const InstanceCapacity = null,

    /// The number of vCPUs available for launching instances onto the Dedicated
    /// Host.
    available_v_cpus: ?i32 = null,
};
