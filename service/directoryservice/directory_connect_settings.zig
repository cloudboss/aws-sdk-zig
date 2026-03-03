/// Contains connection settings for creating an AD
/// Connector with the ConnectDirectory action.
pub const DirectoryConnectSettings = struct {
    /// The IP addresses of DNS servers or domain controllers in your
    /// self-managed directory.
    customer_dns_ips: []const []const u8 = &.{},

    /// The IPv6 addresses of DNS servers or domain controllers in your
    /// self-managed directory.
    customer_dns_ips_v6: ?[]const []const u8 = null,

    /// The user name of an account in your self-managed directory that is used to
    /// connect to the
    /// directory. This account must have the following permissions:
    ///
    /// * Read users and groups
    ///
    /// * Create computer objects
    ///
    /// * Join computers to the domain
    customer_user_name: []const u8,

    /// A list of subnet identifiers in the VPC in which the AD Connector is
    /// created.
    subnet_ids: []const []const u8,

    /// The identifier of the VPC in which the AD Connector is created.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .customer_dns_ips = "CustomerDnsIps",
        .customer_dns_ips_v6 = "CustomerDnsIpsV6",
        .customer_user_name = "CustomerUserName",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
