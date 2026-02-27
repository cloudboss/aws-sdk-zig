const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that projects columns. Operations that come after a
/// projection
/// can only refer to projected columns.
pub const ProjectOperation = struct {
    /// Alias for this operation.
    alias: ?[]const u8,

    /// Projected columns.
    projected_columns: []const []const u8,

    /// The source transform operation that provides input data for column
    /// projection.
    source: ?TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .projected_columns = "ProjectedColumns",
        .source = "Source",
    };
};
