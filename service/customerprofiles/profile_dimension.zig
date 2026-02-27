const StringDimensionType = @import("string_dimension_type.zig").StringDimensionType;

/// Object to hold the dimensions of a profile's fields to segment on.
pub const ProfileDimension = struct {
    /// The action to segment on.
    dimension_type: StringDimensionType,

    /// The values to apply the DimensionType on.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
