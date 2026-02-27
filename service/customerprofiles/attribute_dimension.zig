const AttributeDimensionType = @import("attribute_dimension_type.zig").AttributeDimensionType;

/// Object that segments on various Customer Profile's fields.
pub const AttributeDimension = struct {
    /// The action to segment with.
    dimension_type: AttributeDimensionType,

    /// The values to apply the DimensionType on.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
