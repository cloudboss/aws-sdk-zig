/// The domain name and port information for a UDP endpoint.
pub const UDPEndpoint = struct {
    /// The domain name of the UDP endpoint.
    domain: ?[]const u8,

    /// The port number of the UDP endpoint.
    port: ?i32,

    pub const json_field_names = .{
        .domain = "Domain",
        .port = "Port",
    };
};
