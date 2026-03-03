/// Information about an Availability Zone.
pub const AvailabilityZone = struct {
    /// The ID of the subnet. You can specify one subnet per Availability Zone.
    subnet_id: ?[]const u8 = null,

    /// The name of the Availability Zone.
    zone_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_id = "SubnetId",
        .zone_name = "ZoneName",
    };
};
