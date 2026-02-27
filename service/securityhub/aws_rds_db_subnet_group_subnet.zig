const AwsRdsDbSubnetGroupSubnetAvailabilityZone = @import("aws_rds_db_subnet_group_subnet_availability_zone.zig").AwsRdsDbSubnetGroupSubnetAvailabilityZone;

/// Information about a subnet in a subnet group.
pub const AwsRdsDbSubnetGroupSubnet = struct {
    /// Information about the Availability Zone for a subnet in the subnet group.
    subnet_availability_zone: ?AwsRdsDbSubnetGroupSubnetAvailabilityZone,

    /// The identifier of a subnet in the subnet group.
    subnet_identifier: ?[]const u8,

    /// The status of a subnet in the subnet group.
    subnet_status: ?[]const u8,

    pub const json_field_names = .{
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_identifier = "SubnetIdentifier",
        .subnet_status = "SubnetStatus",
    };
};
