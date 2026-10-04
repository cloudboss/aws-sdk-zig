const ConditionOverrides = @import("condition_overrides.zig").ConditionOverrides;
const AttributeDimensionType = @import("attribute_dimension_type.zig").AttributeDimensionType;

/// Object that segments on Customer Profile's Calculated Attributes.
pub const CalculatedAttributeDimension = struct {
    /// Applies the given condition over the initial Calculated Attribute's
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// The action to segment with.
    dimension_type: AttributeDimensionType,

    /// The values to apply the DimensionType with. To reference a calculated
    /// attribute or
    /// profile attribute as a dynamic value, use handlebar notation:
    /// `{{_profile.ProfileAttributeName}}` or
    /// `{{_calculated_attribute.CalculatedAttributeName}}`.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition_overrides = "ConditionOverrides",
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
