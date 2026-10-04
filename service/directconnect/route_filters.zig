const AddressFamily = @import("address_family.zig").AddressFamily;
const RouteDirection = @import("route_direction.zig").RouteDirection;

/// The filters used to limit the routes returned by ListVirtualInterfaceRoutes.
pub const RouteFilters = struct {
    /// The address family of the routes to return.
    ///
    /// The valid values are `ipv4` and `ipv6`.
    address_family: ?AddressFamily = null,

    /// The autonomous system (AS) numbers used to filter the routes by their AS
    /// path.
    as_path: ?[]const i64 = null,

    /// The CIDRs (prefixes) used to filter the routes. You can specify up to 10
    /// CIDRs.
    cidrs: ?[]const []const u8 = null,

    /// The BGP communities used to filter the routes.
    communities: ?[]const []const u8 = null,

    /// The direction of the routes to return.
    ///
    /// The valid values are `accepted` (routes received from the customer network)
    /// and `advertised` (routes advertised to the customer network).
    route_direction: ?RouteDirection = null,

    pub const json_field_names = .{
        .address_family = "addressFamily",
        .as_path = "asPath",
        .cidrs = "cidrs",
        .communities = "communities",
        .route_direction = "routeDirection",
    };
};
