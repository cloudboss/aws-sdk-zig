/// Configuration for connecting a stream group location to resources in your
/// Amazon VPC using AWS Transit Gateway. When you specify a VPC transit
/// configuration, Amazon GameLift Streams creates a Transit Gateway and shares
/// it with your account using AWS Resource Access Manager. After the stream
/// group is active, you must complete the setup by accepting the resource
/// share, creating a VPC attachment, and configuring routing.
pub const VpcTransitConfiguration = struct {
    /// A list of IPv4 CIDR blocks in your VPC that you want the stream group to be
    /// able to access. You can specify up to 5 CIDR blocks. The CIDR blocks must be
    /// valid subsets of the VPC's CIDR blocks and cannot overlap with the service
    /// VPC CIDR block.
    ipv_4_cidr_blocks: []const []const u8,

    /// The ID of the Amazon VPC that you want to connect to the stream group. The
    /// VPC must be in the same Amazon Web Services account as the stream group.
    /// This value cannot be changed after the stream group is created.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .ipv_4_cidr_blocks = "Ipv4CidrBlocks",
        .vpc_id = "VpcId",
    };
};
