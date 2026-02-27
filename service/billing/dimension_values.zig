const Dimension = @import("dimension.zig").Dimension;

/// The metadata that you can use to filter and group your results.
pub const DimensionValues = struct {
    /// The names of the metadata types that you can use to filter and group your
    /// results.
    key: Dimension,

    /// The metadata values that you can use to filter and group your results.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
