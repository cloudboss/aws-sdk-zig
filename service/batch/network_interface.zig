/// An object that represents the elastic network interface for a multi-node
/// parallel job
/// node.
pub const NetworkInterface = struct {
    /// The attachment ID for the network interface.
    attachment_id: ?[]const u8,

    /// The private IPv6 address for the network interface.
    ipv_6_address: ?[]const u8,

    /// The private IPv4 address for the network interface.
    private_ipv_4_address: ?[]const u8,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .ipv_6_address = "ipv6Address",
        .private_ipv_4_address = "privateIpv4Address",
    };
};
