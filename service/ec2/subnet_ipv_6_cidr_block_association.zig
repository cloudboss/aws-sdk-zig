const IpSource = @import("ip_source.zig").IpSource;
const Ipv6AddressAttribute = @import("ipv_6_address_attribute.zig").Ipv6AddressAttribute;
const SubnetCidrBlockState = @import("subnet_cidr_block_state.zig").SubnetCidrBlockState;

/// Describes an association between a subnet and an IPv6 CIDR block.
pub const SubnetIpv6CidrBlockAssociation = struct {
    /// The ID of the association.
    association_id: ?[]const u8 = null,

    /// The source that allocated the IP address space. `byoip` or `amazon`
    /// indicates public IP address space allocated by Amazon or space that you have
    /// allocated with Bring your own IP (BYOIP). `none` indicates private space.
    ip_source: ?IpSource = null,

    /// Public IPv6 addresses are those advertised on the internet from Amazon Web
    /// Services. Private IP addresses are not and cannot be advertised on the
    /// internet from Amazon Web Services.
    ipv_6_address_attribute: ?Ipv6AddressAttribute = null,

    /// The IPv6 CIDR block.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// The state of the CIDR block.
    ipv_6_cidr_block_state: ?SubnetCidrBlockState = null,
};
