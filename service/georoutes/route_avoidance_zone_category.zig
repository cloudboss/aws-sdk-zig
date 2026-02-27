const RouteZoneCategory = @import("route_zone_category.zig").RouteZoneCategory;

/// Zone categories to be avoided.
pub const RouteAvoidanceZoneCategory = struct {
    /// Zone category to be avoided.
    category: RouteZoneCategory,

    pub const json_field_names = .{
        .category = "Category",
    };
};
