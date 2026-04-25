const RouteZoneCategory = @import("route_zone_category.zig").RouteZoneCategory;

/// Zone categories to be avoided. Not supported in `ap-southeast-1` and
/// `ap-southeast-5` regions for
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
pub const RouteAvoidanceZoneCategory = struct {
    /// Zone category to be avoided.
    category: RouteZoneCategory,

    pub const json_field_names = .{
        .category = "Category",
    };
};
