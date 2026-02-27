const CastColumnTypeOperation = @import("cast_column_type_operation.zig").CastColumnTypeOperation;
const CreateColumnsOperation = @import("create_columns_operation.zig").CreateColumnsOperation;
const FilterOperation = @import("filter_operation.zig").FilterOperation;
const OverrideDatasetParameterOperation = @import("override_dataset_parameter_operation.zig").OverrideDatasetParameterOperation;
const ProjectOperation = @import("project_operation.zig").ProjectOperation;
const RenameColumnOperation = @import("rename_column_operation.zig").RenameColumnOperation;
const TagColumnOperation = @import("tag_column_operation.zig").TagColumnOperation;
const UntagColumnOperation = @import("untag_column_operation.zig").UntagColumnOperation;

/// A data transformation on a logical table. This is a variant type structure.
/// For this
/// structure to be valid, only one of the attributes can be non-null.
pub const TransformOperation = union(enum) {
    /// A transform operation that casts a column to a different type.
    cast_column_type_operation: ?CastColumnTypeOperation,
    /// An operation that creates calculated columns. Columns created in one such
    /// operation
    /// form a lexical closure.
    create_columns_operation: ?CreateColumnsOperation,
    /// An operation that filters rows based on some condition.
    filter_operation: ?FilterOperation,
    override_dataset_parameter_operation: ?OverrideDatasetParameterOperation,
    /// An operation that projects columns. Operations that come after a projection
    /// can only
    /// refer to projected columns.
    project_operation: ?ProjectOperation,
    /// An operation that renames a column.
    rename_column_operation: ?RenameColumnOperation,
    /// An operation that tags a column with additional information.
    tag_column_operation: ?TagColumnOperation,
    untag_column_operation: ?UntagColumnOperation,

    pub const json_field_names = .{
        .cast_column_type_operation = "CastColumnTypeOperation",
        .create_columns_operation = "CreateColumnsOperation",
        .filter_operation = "FilterOperation",
        .override_dataset_parameter_operation = "OverrideDatasetParameterOperation",
        .project_operation = "ProjectOperation",
        .rename_column_operation = "RenameColumnOperation",
        .tag_column_operation = "TagColumnOperation",
        .untag_column_operation = "UntagColumnOperation",
    };
};
