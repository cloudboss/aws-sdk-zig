const StringDimensionType = @import("string_dimension_type.zig").StringDimensionType;

/// Object that segments on various Customer profile's fields that are larger
/// than
/// normal.
pub const ExtraLengthValueProfileDimension = struct {
    /// The action to segment with.
    dimension_type: StringDimensionType,

    /// The values to apply the DimensionType on.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
