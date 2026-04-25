const IsolineZoneCategory = @import("isoline_zone_category.zig").IsolineZoneCategory;

/// Types of regulated zones that may affect routing.
pub const IsolineAvoidanceZoneCategory = struct {
    /// The type of regulated zone: `CongestionPricing` for toll zones based on
    /// traffic levels, `Environmental` for low-emission zones, or `Vignette` for
    /// areas requiring special permits or stickers.
    category: ?IsolineZoneCategory = null,

    pub const json_field_names = .{
        .category = "Category",
    };
};
