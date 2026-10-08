/// Contains a recommended security group configuration for an AMI fulfillment
/// option.
pub const AmazonMachineImageSecurityGroup = struct {
    /// The IP address ranges in CIDR format.
    cidr_ip_addresses: []const []const u8,

    /// The start of the port range.
    from_port: i32,

    /// The IP protocol name, such as `tcp`.
    protocol: []const u8,

    /// The end of the port range.
    to_port: i32,

    pub const json_field_names = .{
        .cidr_ip_addresses = "cidrIpAddresses",
        .from_port = "fromPort",
        .protocol = "protocol",
        .to_port = "toPort",
    };
};
