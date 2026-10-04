const AddressFamily = @import("address_family.zig").AddressFamily;
const AsPathSegment = @import("as_path_segment.zig").AsPathSegment;
const RouteDirection = @import("route_direction.zig").RouteDirection;

/// Information about a route for a virtual interface.
pub const Route = struct {
    /// The address family of the route.
    ///
    /// The valid values are `ipv4` and `ipv6`.
    address_family: ?AddressFamily = null,

    /// The autonomous system (AS) path of the route.
    as_path: ?[]const AsPathSegment = null,

    /// The Direct Connect endpoint that terminates the logical connection. This
    /// device might be
    /// different than the device that terminates the physical connection.
    aws_logical_device_id: ?[]const u8 = null,

    /// The CIDR (prefix) of the route.
    cidr: ?[]const u8 = null,

    /// The BGP communities associated with the route.
    communities: ?[]const []const u8 = null,

    /// The direction of the route.
    ///
    /// The valid values are `accepted` (received from the customer network) and
    /// `advertised` (advertised to the customer network).
    route_direction: ?RouteDirection = null,

    /// The time when the route was installed. The value is displayed in UTC format.
    route_installed_at: ?i64 = null,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .as_path = "asPath",
        .aws_logical_device_id = "awsLogicalDeviceId",
        .cidr = "cidr",
        .communities = "communities",
        .route_direction = "routeDirection",
        .route_installed_at = "routeInstalledAt",
    };
};
