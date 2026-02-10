/// Describes the VPC peering connection options.
pub const VpcPeeringConnectionOptionsDescription = struct {
    /// Indicates whether a local VPC can resolve public DNS hostnames to private IP
    /// addresses
    /// when queried from instances in a peer VPC.
    allow_dns_resolution_from_remote_vpc: ?bool,

    /// Deprecated.
    allow_egress_from_local_classic_link_to_remote_vpc: ?bool,

    /// Deprecated.
    allow_egress_from_local_vpc_to_remote_classic_link: ?bool,
};
