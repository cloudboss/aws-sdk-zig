/// Provides information about the VPC peering connection options for the
/// accepter or requester VPC.
pub const VpcInfoPeeringOptionsDetails = struct {
    /// Indicates whether a local VPC can resolve public DNS hostnames to private IP
    /// addresses when queried from instances in a peer VPC.
    allow_dns_resolution_from_remote_vpc: ?bool,

    /// Indicates whether a local ClassicLink connection can communicate with the
    /// peer VPC over the VPC peering connection.
    allow_egress_from_local_classic_link_to_remote_vpc: ?bool,

    /// Indicates whether a local VPC can communicate with a ClassicLink connection
    /// in the peer VPC over the VPC peering connection.
    allow_egress_from_local_vpc_to_remote_classic_link: ?bool,

    pub const json_field_names = .{
        .allow_dns_resolution_from_remote_vpc = "AllowDnsResolutionFromRemoteVpc",
        .allow_egress_from_local_classic_link_to_remote_vpc = "AllowEgressFromLocalClassicLinkToRemoteVpc",
        .allow_egress_from_local_vpc_to_remote_classic_link = "AllowEgressFromLocalVpcToRemoteClassicLink",
    };
};
