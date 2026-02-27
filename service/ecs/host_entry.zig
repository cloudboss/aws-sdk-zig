/// Hostnames and IP address entries that are added to the `/etc/hosts` file of
/// a container via the `extraHosts` parameter of its
/// [ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html).
pub const HostEntry = struct {
    /// The hostname to use in the `/etc/hosts` entry.
    hostname: []const u8,

    /// The IP address to use in the `/etc/hosts` entry.
    ip_address: []const u8,

    pub const json_field_names = .{
        .hostname = "hostname",
        .ip_address = "ipAddress",
    };
};
