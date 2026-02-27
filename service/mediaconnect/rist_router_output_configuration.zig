/// The configuration settings for a router output using the RIST (Reliable
/// Internet Stream Transport) protocol, including the destination address and
/// port.
pub const RistRouterOutputConfiguration = struct {
    /// The destination IP address for the RIST protocol in the router output
    /// configuration.
    destination_address: []const u8,

    /// The destination port number for the RIST protocol in the router output
    /// configuration.
    destination_port: i32,

    pub const json_field_names = .{
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
    };
};
