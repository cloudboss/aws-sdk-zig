/// An Amazon FSx for NetApp ONTAP file system has two endpoints
/// that are used to access data or to manage the file system
/// using the NetApp ONTAP CLI, REST API, or NetApp SnapMirror. They
/// are the `Management` and `Intercluster` endpoints.
pub const FileSystemEndpoint = struct {
    dns_name: ?[]const u8,

    /// The IPv4 addresses of the file system endpoint.
    ip_addresses: ?[]const []const u8,

    /// The IPv6 addresses of the file system endpoint.
    ipv_6_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .dns_name = "DNSName",
        .ip_addresses = "IpAddresses",
        .ipv_6_addresses = "Ipv6Addresses",
    };
};
