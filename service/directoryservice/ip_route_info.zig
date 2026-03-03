const IpRouteStatusMsg = @import("ip_route_status_msg.zig").IpRouteStatusMsg;

/// Information about one or more IP address blocks.
pub const IpRouteInfo = struct {
    /// The date and time the address block was added to the directory.
    added_date_time: ?i64 = null,

    /// IP address block in the IpRoute.
    cidr_ip: ?[]const u8 = null,

    /// IPv6 address block in the IpRoute.
    cidr_ipv_6: ?[]const u8 = null,

    /// Description of the IpRouteInfo.
    description: ?[]const u8 = null,

    /// Identifier (ID) of the directory associated with the IP addresses.
    directory_id: ?[]const u8 = null,

    /// The status of the IP address block.
    ip_route_status_msg: ?IpRouteStatusMsg = null,

    /// The reason for the IpRouteStatusMsg.
    ip_route_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .added_date_time = "AddedDateTime",
        .cidr_ip = "CidrIp",
        .cidr_ipv_6 = "CidrIpv6",
        .description = "Description",
        .directory_id = "DirectoryId",
        .ip_route_status_msg = "IpRouteStatusMsg",
        .ip_route_status_reason = "IpRouteStatusReason",
    };
};
