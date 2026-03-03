/// High-level information about a firewall, returned by operations like create
/// and
/// describe. You can use the information provided in the metadata to retrieve
/// and manage a
/// firewall.
pub const FirewallMetadata = struct {
    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: ?[]const u8 = null,

    /// The unique identifier of the transit gateway attachment associated with this
    /// firewall. This field is only present for transit gateway-attached firewalls.
    transit_gateway_attachment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .transit_gateway_attachment_id = "TransitGatewayAttachmentId",
    };
};
