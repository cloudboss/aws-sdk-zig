/// The instance type that you specify determines the combination of CPU,
/// memory, storage, and
/// networking capacity.
pub const InstanceTypeCapacity = struct {
    /// The number of instances for the specified instance type.
    count: i32 = 0,

    /// The instance type of the hosts.
    instance_type: []const u8,

    pub const json_field_names = .{
        .count = "Count",
        .instance_type = "InstanceType",
    };
};
