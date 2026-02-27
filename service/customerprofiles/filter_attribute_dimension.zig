const FilterDimensionType = @import("filter_dimension_type.zig").FilterDimensionType;

/// Object that defines how to filter the incoming objects for the calculated
/// attribute.
pub const FilterAttributeDimension = struct {
    /// The action to filter with.
    dimension_type: FilterDimensionType,

    /// The values to apply the DimensionType on.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
