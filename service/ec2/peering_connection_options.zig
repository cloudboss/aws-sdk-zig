/// Describes the VPC peering connection options.
pub const PeeringConnectionOptions = struct {
    /// If true, the public DNS hostnames of instances in the specified VPC resolve
    /// to private
    /// IP addresses when queried from instances in the peer VPC.
    allow_dns_resolution_from_remote_vpc: ?bool,

    /// Deprecated.
    allow_egress_from_local_classic_link_to_remote_vpc: ?bool,

    /// Deprecated.
    allow_egress_from_local_vpc_to_remote_classic_link: ?bool,
};
