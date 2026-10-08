/// Contains supported Amazon EBS volume information for an AMI fulfillment
/// option.
pub const AmazonMachineImageEbsVolume = struct {
    /// The total number of provisioned IOPS supported.
    iops: ?i32 = null,

    /// The supported Amazon EBS volume types.
    volume_types: []const []const u8,

    pub const json_field_names = .{
        .iops = "iops",
        .volume_types = "volumeTypes",
    };
};
