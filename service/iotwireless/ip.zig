/// IP address used for resolving device location.
pub const Ip = struct {
    /// IP address information.
    ip_address: []const u8,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
    };
};
