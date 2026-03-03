const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const Outpost = @import("outpost.zig").Outpost;

/// This data type is used as a response element for the
/// `DescribeDBSubnetGroups` operation.
pub const Subnet = struct {
    subnet_availability_zone: ?AvailabilityZone = null,

    /// The identifier of the subnet.
    subnet_identifier: ?[]const u8 = null,

    /// If the subnet is associated with an Outpost, this value specifies the
    /// Outpost.
    ///
    /// For more information about RDS on Outposts, see [Amazon RDS on Amazon Web
    /// Services
    /// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide.*
    subnet_outpost: ?Outpost = null,

    /// The status of the subnet.
    subnet_status: ?[]const u8 = null,
};
