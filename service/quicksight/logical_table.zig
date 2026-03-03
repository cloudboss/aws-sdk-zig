const TransformOperation = @import("transform_operation.zig").TransformOperation;
const LogicalTableSource = @import("logical_table_source.zig").LogicalTableSource;

/// A *logical table* is a unit that joins and that data
/// transformations operate on. A logical table has a source, which can be
/// either a physical
/// table or result of a join. When a logical table points to a physical table,
/// the logical
/// table acts as a mutable copy of that physical table through transform
/// operations.
pub const LogicalTable = struct {
    /// A display name for the logical table.
    alias: []const u8,

    /// Transform operations that act on this logical table. For this structure to
    /// be valid, only one of the attributes can be non-null.
    data_transforms: ?[]const TransformOperation = null,

    /// Source of this logical table.
    source: LogicalTableSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .data_transforms = "DataTransforms",
        .source = "Source",
    };
};
