/// Describes the network details of a WorkSpaces Pool.
pub const NetworkAccessConfiguration = struct {
    /// The resource identifier of the elastic network interface that is attached to
    /// instances in your
    /// VPC. All network interfaces have the eni-xxxxxxxx resource identifier.
    eni_id: ?[]const u8,

    /// The private IP address of the elastic network interface that is attached to
    /// instances in your VPC.
    eni_private_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .eni_id = "EniId",
        .eni_private_ip_address = "EniPrivateIpAddress",
    };
};
