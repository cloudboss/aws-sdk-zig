/// An Availability Zone for a subnet in a subnet group.
pub const AwsRdsDbSubnetGroupSubnetAvailabilityZone = struct {
    /// The name of the Availability Zone for a subnet in the subnet group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
