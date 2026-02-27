/// The network settings for a gateway.
pub const GatewayNetwork = struct {
    /// A unique IP address range to use for this network. These IP addresses should
    /// be in the form of a Classless Inter-Domain Routing (CIDR) block; for
    /// example, 10.0.0.0/16.
    cidr_block: []const u8,

    /// The name of the network. This name is used to reference the network and must
    /// be unique among networks in this gateway.
    name: []const u8,

    pub const json_field_names = .{
        .cidr_block = "CidrBlock",
        .name = "Name",
    };
};
