/// Configuration details for a standard router output stream type. Contains
/// information about the destination IP address and connection state for basic
/// output routing.
pub const StandardRouterOutputStreamDetails = struct {
    /// The IP address where the output stream will be sent. This is the destination
    /// address that will receive the routed media content.
    destination_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_ip_address = "DestinationIpAddress",
    };
};
