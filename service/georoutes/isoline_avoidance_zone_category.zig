const IsolineZoneCategory = @import("isoline_zone_category.zig").IsolineZoneCategory;

/// Zone category to be avoided.
pub const IsolineAvoidanceZoneCategory = struct {
    /// Zone category to be avoided.
    category: ?IsolineZoneCategory = null,

    pub const json_field_names = .{
        .category = "Category",
    };
};
