/// An Amazon FSx for NetApp ONTAP storage virtual machine (SVM) has
/// four endpoints that are used to access data or to manage the SVM
/// using the NetApp ONTAP CLI, REST API, or NetApp CloudManager. They
/// are the `Iscsi`, `Management`, `Nfs`,
/// and `Smb` endpoints.
pub const SvmEndpoint = struct {
    dns_name: ?[]const u8,

    /// The SVM endpoint's IPv4 addresses.
    ip_addresses: ?[]const []const u8,

    /// The SVM endpoint's IPv6 addresses.
    ipv_6_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .dns_name = "DNSName",
        .ip_addresses = "IpAddresses",
        .ipv_6_addresses = "Ipv6Addresses",
    };
};
