const IpamPublicAddressTag = @import("ipam_public_address_tag.zig").IpamPublicAddressTag;

/// Tags for a public IP address discovered by IPAM.
pub const IpamPublicAddressTags = struct {
    /// Tags for an Elastic IP address.
    eip_tags: ?[]const IpamPublicAddressTag,
};
