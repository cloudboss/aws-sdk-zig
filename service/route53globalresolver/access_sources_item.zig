const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const DnsProtocol = @import("dns_protocol.zig").DnsProtocol;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// Summary information about an access source.
pub const AccessSourcesItem = struct {
    /// The Amazon Resource Name (ARN) of the access source.
    arn: []const u8,

    /// The CIDR block that defines the IP address range for the access source.
    cidr: []const u8,

    /// The date and time when the access source was created.
    created_at: i64,

    /// The ID of the DNS view that the access source is associated with.
    dns_view_id: []const u8,

    /// The unique identifier of the access source.
    id: []const u8,

    /// The IP address type of the access source.
    ip_address_type: IpAddressType,

    /// The name of the access source.
    name: ?[]const u8,

    /// The protocol used by the access source.
    protocol: DnsProtocol,

    /// The current status of the access source.
    status: CRResourceStatus,

    /// The date and time when the access source was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .cidr = "cidr",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .protocol = "protocol",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
