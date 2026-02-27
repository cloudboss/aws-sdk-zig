/// Specifies network configuration information for the gateway associated with
/// the Amazon FSx file system.
pub const EndpointNetworkConfiguration = struct {
    /// A list of gateway IP addresses on which the associated Amazon FSx file
    /// system is
    /// available.
    ///
    /// If multiple file systems are associated with this gateway, this field is
    /// required.
    ip_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .ip_addresses = "IpAddresses",
    };
};
