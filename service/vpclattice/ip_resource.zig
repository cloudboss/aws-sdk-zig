/// Describes an IP resource.
pub const IpResource = struct {
    /// The IP address of the IP resource.
    ip_address: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "ipAddress",
    };
};
