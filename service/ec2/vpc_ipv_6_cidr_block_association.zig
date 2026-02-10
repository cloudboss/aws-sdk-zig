const IpSource = @import("ip_source.zig").IpSource;
const Ipv6AddressAttribute = @import("ipv_6_address_attribute.zig").Ipv6AddressAttribute;
const VpcCidrBlockState = @import("vpc_cidr_block_state.zig").VpcCidrBlockState;

/// Describes an IPv6 CIDR block associated with a VPC.
pub const VpcIpv6CidrBlockAssociation = struct {
    /// The association ID for the IPv6 CIDR block.
    association_id: ?[]const u8,

    /// The source that allocated the IP address space. `byoip` or `amazon`
    /// indicates public IP address space allocated by Amazon or space that you have
    /// allocated with Bring your own IP (BYOIP). `none` indicates private space.
    ip_source: ?IpSource,

    /// Public IPv6 addresses are those advertised on the internet from Amazon Web
    /// Services. Private IP addresses are not and cannot be advertised on the
    /// internet from Amazon Web Services.
    ipv_6_address_attribute: ?Ipv6AddressAttribute,

    /// The IPv6 CIDR block.
    ipv_6_cidr_block: ?[]const u8,

    /// Information about the state of the CIDR block.
    ipv_6_cidr_block_state: ?VpcCidrBlockState,

    /// The ID of the IPv6 address pool from which the IPv6 CIDR block is allocated.
    ipv_6_pool: ?[]const u8,

    /// The name of the unique set of Availability Zones, Local Zones, or Wavelength
    /// Zones from
    /// which Amazon Web Services advertises IP addresses, for example,
    /// `us-east-1-wl1-bos-wlz-1`.
    network_border_group: ?[]const u8,
};
