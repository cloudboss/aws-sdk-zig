const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;

/// A VPC endpoint association defines a single subnet to use for a firewall
/// endpoint for a `Firewall`.
/// You can define VPC endpoint associations only in the Availability Zones that
/// already have
/// a subnet mapping defined in the `Firewall` resource.
///
/// You can retrieve the list of Availability Zones that are available for use
/// by calling `DescribeFirewallMetadata`.
///
/// To manage firewall endpoints, first, in the `Firewall` specification, you
/// specify a single VPC and one subnet
/// for each of the Availability Zones where you want to use the firewall. Then
/// you can define additional endpoints as
/// VPC endpoint associations.
///
/// You can use VPC endpoint associations to expand the protections of the
/// firewall as follows:
///
/// * **Protect multiple VPCs with a single firewall** - You can use the
///   firewall to protect other VPCs, either in your account or in accounts
///   where the firewall is shared. You can only specify Availability Zones that
///   already have a firewall endpoint defined in the `Firewall` subnet
///   mappings.
///
/// * **Define multiple firewall endpoints for a VPC in an Availability Zone** -
///   You can create additional firewall endpoints for the VPC that you have
///   defined in the firewall, in any Availability Zone that already has an
///   endpoint defined in the `Firewall` subnet mappings. You can create
///   multiple VPC endpoint associations for any other VPC where you use the
///   firewall.
///
/// You can use Resource Access Manager to share a `Firewall` that you own with
/// other accounts, which gives them the ability to use the firewall
/// to create VPC endpoint associations. For information about sharing a
/// firewall, see `PutResourcePolicy`
/// in this guide and see
/// [Sharing Network Firewall
/// resources](https://docs.aws.amazon.com/network-firewall/latest/developerguide/sharing.html) in the *Network Firewall Developer Guide*.
///
/// The status of the VPC endpoint association, which indicates whether it's
/// ready to filter network traffic,
/// is provided in the corresponding VpcEndpointAssociationStatus. You can
/// retrieve both
/// the association and its status by calling DescribeVpcEndpointAssociation.
pub const VpcEndpointAssociation = struct {
    /// A description of the VPC endpoint association.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: []const u8,

    subnet_mapping: SubnetMapping,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: []const u8,

    /// The unique identifier of the VPC endpoint association.
    vpc_endpoint_association_id: ?[]const u8 = null,

    /// The unique identifier of the VPC for the endpoint association.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .firewall_arn = "FirewallArn",
        .subnet_mapping = "SubnetMapping",
        .tags = "Tags",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_association_id = "VpcEndpointAssociationId",
        .vpc_id = "VpcId",
    };
};
