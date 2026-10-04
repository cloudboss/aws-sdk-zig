const Category = @import("category.zig").Category;

/// A reference to a third-party supplier's identifier for a place, enabling
/// correlation of places across external systems.
pub const CrossReference = struct {
    /// The name of the third-party data supplier (for example, `Yelp` or
    /// `TripAdvisor`).
    source: []const u8,

    /// The list of place category identifiers this supplier reference relates to.
    source_categories: ?[]const Category = null,

    /// The place identifier assigned by the third-party supplier.
    source_place_id: []const u8,

    pub const json_field_names = .{
        .source = "Source",
        .source_categories = "SourceCategories",
        .source_place_id = "SourcePlaceId",
    };
};
