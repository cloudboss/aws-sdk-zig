const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;

/// The VPC and subnets for a proxy mode firewall endpoint. This is used in
/// CreateFirewall when `NoSourcePreservation` is `TRUE`, to specify where
/// Network Firewall creates the firewall endpoint.
///
/// This differs from VpcEndpointAssociation, which defines additional secondary
/// endpoints for a firewall in other VPCs.
pub const VpcEndpoint = struct {
    /// The subnets in which Network Firewall creates the firewall endpoint for a
    /// proxy mode firewall. Each subnet must belong to a different Availability
    /// Zone in the VPC.
    subnet_mappings: []const SubnetMapping,

    /// The unique identifier of the VPC where Network Firewall creates the proxy
    /// mode firewall endpoint.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .subnet_mappings = "SubnetMappings",
        .vpc_id = "VpcId",
    };
};
