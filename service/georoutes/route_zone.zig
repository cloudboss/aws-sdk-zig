const RouteZoneCategory = @import("route_zone_category.zig").RouteZoneCategory;

/// The zone.
pub const RouteZone = struct {
    /// The zone category.
    category: ?RouteZoneCategory,

    /// The name of the zone.
    name: ?[]const u8,

    pub const json_field_names = .{
        .category = "Category",
        .name = "Name",
    };
};
