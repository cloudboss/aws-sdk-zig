/// Information about the expected route in the route table.
pub const ExpectedRoute = struct {
    /// Information about the allowed targets.
    allowed_targets: ?[]const []const u8,

    /// Information about the contributing subnets.
    contributing_subnets: ?[]const []const u8,

    /// Information about the IPv4 CIDR block.
    ip_v4_cidr: ?[]const u8,

    /// Information about the IPv6 CIDR block.
    ip_v6_cidr: ?[]const u8,

    /// Information about the ID of the prefix list for the route.
    prefix_list_id: ?[]const u8,

    /// Information about the route table ID.
    route_table_id: ?[]const u8,

    pub const json_field_names = .{
        .allowed_targets = "AllowedTargets",
        .contributing_subnets = "ContributingSubnets",
        .ip_v4_cidr = "IpV4Cidr",
        .ip_v6_cidr = "IpV6Cidr",
        .prefix_list_id = "PrefixListId",
        .route_table_id = "RouteTableId",
    };
};
