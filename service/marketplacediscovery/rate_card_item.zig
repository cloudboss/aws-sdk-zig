const DimensionLabel = @import("dimension_label.zig").DimensionLabel;

/// A per-unit rate within a rate card, defining the price for a specific
/// dimension.
pub const RateCardItem = struct {
    /// A description of the dimension being priced.
    description: ?[]const u8 = null,

    /// The machine-readable key identifying the dimension being priced.
    dimension_key: []const u8,

    /// Labels used to categorize this dimension, such as by region.
    dimension_labels: ?[]const DimensionLabel = null,

    /// The human-readable name of the dimension.
    display_name: []const u8,

    /// The price per unit for the dimension.
    price: []const u8,

    /// The unit of measurement for the dimension.
    unit: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .dimension_key = "dimensionKey",
        .dimension_labels = "dimensionLabels",
        .display_name = "displayName",
        .price = "price",
        .unit = "unit",
    };
};
