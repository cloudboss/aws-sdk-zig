/// For private hosted zones, this is a complex type that contains information
/// about an Amazon VPC.
pub const AwsRoute53HostedZoneVpcDetails = struct {
    /// The identifier of an Amazon VPC.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region that an Amazon VPC was created in.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .region = "Region",
    };
};
