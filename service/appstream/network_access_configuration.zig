/// Describes the network details of the fleet or image builder instance.
pub const NetworkAccessConfiguration = struct {
    /// The resource identifier of the elastic network interface that is attached to
    /// instances in your VPC. All network interfaces have the eni-xxxxxxxx resource
    /// identifier.
    eni_id: ?[]const u8,

    /// The IPv6 addresses assigned to the elastic network interface. This field
    /// supports IPv6 connectivity for WorkSpaces Applications instances.
    eni_ipv_6_addresses: ?[]const []const u8,

    /// The private IP address of the elastic network interface that is attached to
    /// instances in your VPC.
    eni_private_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .eni_id = "EniId",
        .eni_ipv_6_addresses = "EniIpv6Addresses",
        .eni_private_ip_address = "EniPrivateIpAddress",
    };
};
