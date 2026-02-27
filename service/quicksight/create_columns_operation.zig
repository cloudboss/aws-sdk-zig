const CalculatedColumn = @import("calculated_column.zig").CalculatedColumn;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that creates calculated columns. Columns created in
/// one such
/// operation form a lexical closure.
pub const CreateColumnsOperation = struct {
    /// Alias for this operation.
    alias: ?[]const u8,

    /// Calculated columns to create.
    columns: []const CalculatedColumn,

    /// The source transform operation that provides input data for creating new
    /// calculated columns.
    source: ?TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .columns = "Columns",
        .source = "Source",
    };
};
