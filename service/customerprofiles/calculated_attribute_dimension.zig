const ConditionOverrides = @import("condition_overrides.zig").ConditionOverrides;
const AttributeDimensionType = @import("attribute_dimension_type.zig").AttributeDimensionType;

/// Object that segments on Customer Profile's Calculated Attributes.
pub const CalculatedAttributeDimension = struct {
    /// Applies the given condition over the initial Calculated Attribute's
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// The action to segment with.
    dimension_type: AttributeDimensionType,

    /// The values to apply the DimensionType with.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition_overrides = "ConditionOverrides",
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
