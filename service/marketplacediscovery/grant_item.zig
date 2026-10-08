const DimensionLabel = @import("dimension_label.zig").DimensionLabel;

/// An entitlement granted to the buyer as part of a pricing term.
pub const GrantItem = struct {
    /// A description of the entitlement.
    description: ?[]const u8 = null,

    /// The machine-readable key identifying the entitlement dimension.
    dimension_key: []const u8,

    /// Labels used to categorize this entitlement, such as by region.
    dimension_labels: ?[]const DimensionLabel = null,

    /// The human-readable name of the entitlement dimension.
    display_name: []const u8,

    /// The maximum quantity of the entitlement that can be granted.
    max_quantity: ?i32 = null,

    /// The unit of measurement for the entitlement.
    unit: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .dimension_key = "dimensionKey",
        .dimension_labels = "dimensionLabels",
        .display_name = "displayName",
        .max_quantity = "maxQuantity",
        .unit = "unit",
    };
};
