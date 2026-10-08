const Dimension = @import("dimension.zig").Dimension;

/// Represents a dimension and its corresponding value.
pub const DimensionEntry = struct {
    /// The dimension type that categorizes this entry.
    dimension: Dimension,

    /// The value for the specified dimension. Valid values vary based on the
    /// dimension type (e.g., `us-east-1` for the `REGION` dimension, `AmazonEC2`
    /// for the `SERVICE` dimension).
    value: []const u8,

    pub const json_field_names = .{
        .dimension = "Dimension",
        .value = "Value",
    };
};
