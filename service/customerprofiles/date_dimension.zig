const DateDimensionType = @import("date_dimension_type.zig").DateDimensionType;

/// Object that segments on various Customer Profile's date fields.
pub const DateDimension = struct {
    /// The action to segment with.
    dimension_type: DateDimensionType,

    /// The values to apply the DimensionType on.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
