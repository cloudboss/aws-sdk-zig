/// Information about the number of instances that can be launched onto the
/// Dedicated
/// Host.
pub const InstanceCapacity = struct {
    /// The number of instances that can be launched onto the Dedicated Host based
    /// on the
    /// host's available capacity.
    available_capacity: ?i32,

    /// The instance type supported by the Dedicated Host.
    instance_type: ?[]const u8,

    /// The total number of instances that can be launched onto the Dedicated Host
    /// if there
    /// are no instances running on it.
    total_capacity: ?i32,
};
