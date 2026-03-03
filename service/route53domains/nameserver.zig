/// Name server includes the following elements.
pub const Nameserver = struct {
    /// Glue IP address of a name server entry. Glue IP addresses are required only
    /// when the
    /// name of the name server is a subdomain of the domain. For example, if your
    /// domain is
    /// example.com and the name server for the domain is ns.example.com, you need
    /// to specify
    /// the IP address for ns.example.com.
    ///
    /// Constraints: The list can contain only one IPv4 and one IPv6 address.
    glue_ips: ?[]const []const u8 = null,

    /// The fully qualified host name of the name server.
    ///
    /// Constraint: Maximum 255 characters
    name: []const u8,

    pub const json_field_names = .{
        .glue_ips = "GlueIps",
        .name = "Name",
    };
};
