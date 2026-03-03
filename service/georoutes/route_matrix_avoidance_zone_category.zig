const RouteMatrixZoneCategory = @import("route_matrix_zone_category.zig").RouteMatrixZoneCategory;

/// Zone categories to be avoided.
pub const RouteMatrixAvoidanceZoneCategory = struct {
    /// Zone category to be avoided.
    category: ?RouteMatrixZoneCategory = null,

    pub const json_field_names = .{
        .category = "Category",
    };
};
