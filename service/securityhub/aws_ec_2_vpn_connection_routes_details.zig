/// A static routes associated with
/// the VPN connection.
pub const AwsEc2VpnConnectionRoutesDetails = struct {
    /// The CIDR block associated with the local subnet of the customer data center.
    destination_cidr_block: ?[]const u8,

    /// The current state of the static route.
    state: ?[]const u8,

    pub const json_field_names = .{
        .destination_cidr_block = "DestinationCidrBlock",
        .state = "State",
    };
};
