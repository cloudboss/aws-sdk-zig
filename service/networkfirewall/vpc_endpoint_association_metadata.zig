/// High-level information about a VPC endpoint association, returned by
/// `ListVpcEndpointAssociations`. You can use the information provided in the
/// metadata to retrieve and manage a VPC endpoint association.
pub const VpcEndpointAssociationMetadata = struct {
    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8,

    pub const json_field_names = .{
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
    };
};
