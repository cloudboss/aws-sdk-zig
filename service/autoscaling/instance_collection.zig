/// Contains details about a collection of instances launched in the Auto
/// Scaling group.
pub const InstanceCollection = struct {
    /// The Availability Zone where the instances were launched.
    availability_zone: ?[]const u8,

    /// The Availability Zone ID where the instances in this collection were
    /// launched.
    availability_zone_id: ?[]const u8,

    /// A list of instance IDs for the successfully launched instances.
    instance_ids: ?[]const []const u8,

    /// The instance type of the launched instances.
    instance_type: ?[]const u8,

    /// The market type for the instances (On-Demand or Spot).
    market_type: ?[]const u8,

    /// The ID of the subnet where the instances were launched.
    subnet_id: ?[]const u8,
};
