const DimensionType = @import("dimension_type.zig").DimensionType;

/// Specifies the dimension type and values for a segment dimension.
pub const SetDimension = struct {
    /// The type of segment dimension to use. Valid values are: INCLUSIVE, endpoints
    /// that match the criteria are included in the segment; and, EXCLUSIVE,
    /// endpoints that match the criteria are excluded from the segment.
    dimension_type: ?DimensionType = null,

    /// The criteria values to use for the segment dimension. Depending on the value
    /// of the DimensionType property, endpoints are included or excluded from the
    /// segment if their values match the criteria values.
    values: []const []const u8,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
