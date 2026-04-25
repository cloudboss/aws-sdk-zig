/// The VPC transit configuration details for a stream group location, including
/// the Transit Gateway information needed to complete the VPC attachment setup.
pub const VpcTransitConfigurationResponse = struct {
    /// The IPv4 CIDR blocks in your VPC that the stream group can access.
    ipv_4_cidr_blocks: ?[]const []const u8 = null,

    /// The ID of the Transit Gateway that Amazon GameLift Streams created for this
    /// VPC connection. Use this ID when creating your VPC attachment.
    transit_gateway_id: ?[]const u8 = null,

    /// The ARN of the AWS Resource Access Manager resource share for the Transit
    /// Gateway. You must accept this resource share before you can create a VPC
    /// attachment.
    transit_gateway_resource_share_arn: ?[]const u8 = null,

    /// The ID of the Amazon VPC that is connected to the stream group.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ipv_4_cidr_blocks = "Ipv4CidrBlocks",
        .transit_gateway_id = "TransitGatewayId",
        .transit_gateway_resource_share_arn = "TransitGatewayResourceShareArn",
        .vpc_id = "VpcId",
    };
};
