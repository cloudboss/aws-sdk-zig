/// Information about the number of instances that can be launched onto the
/// Dedicated
/// Host.
pub const InstanceCapacity = struct {
    /// The number of instances that can be launched onto the Dedicated Host based
    /// on the
    /// host's available capacity.
    available_capacity: ?i32 = null,

    /// The instance type supported by the Dedicated Host.
    instance_type: ?[]const u8 = null,

    /// The total number of instances that can be launched onto the Dedicated Host
    /// if there
    /// are no instances running on it.
    total_capacity: ?i32 = null,
};
