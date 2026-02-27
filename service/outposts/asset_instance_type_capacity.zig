/// The capacity for each instance type.
pub const AssetInstanceTypeCapacity = struct {
    /// The number of each instance type.
    count: i32 = 0,

    /// The type of instance.
    instance_type: []const u8,

    pub const json_field_names = .{
        .count = "Count",
        .instance_type = "InstanceType",
    };
};
