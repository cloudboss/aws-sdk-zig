/// Information about the server's network for which the assessment was run.
pub const NetworkInfo = struct {
    /// Information about the name of the interface of the server for which the
    /// assessment was
    /// run.
    interface_name: []const u8,

    /// Information about the IP address of the server for which the assessment was
    /// run.
    ip_address: []const u8,

    /// Information about the MAC address of the server for which the assessment was
    /// run.
    mac_address: []const u8,

    /// Information about the subnet mask of the server for which the assessment was
    /// run.
    net_mask: []const u8,

    pub const json_field_names = .{
        .interface_name = "interfaceName",
        .ip_address = "ipAddress",
        .mac_address = "macAddress",
        .net_mask = "netMask",
    };
};
