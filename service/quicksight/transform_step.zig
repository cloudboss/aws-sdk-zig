const AggregateOperation = @import("aggregate_operation.zig").AggregateOperation;
const AppendOperation = @import("append_operation.zig").AppendOperation;
const CastColumnTypesOperation = @import("cast_column_types_operation.zig").CastColumnTypesOperation;
const CreateColumnsOperation = @import("create_columns_operation.zig").CreateColumnsOperation;
const FiltersOperation = @import("filters_operation.zig").FiltersOperation;
const ImportTableOperation = @import("import_table_operation.zig").ImportTableOperation;
const JoinOperation = @import("join_operation.zig").JoinOperation;
const PivotOperation = @import("pivot_operation.zig").PivotOperation;
const ProjectOperation = @import("project_operation.zig").ProjectOperation;
const RenameColumnsOperation = @import("rename_columns_operation.zig").RenameColumnsOperation;
const UnpivotOperation = @import("unpivot_operation.zig").UnpivotOperation;

/// A step in data preparation that performs a specific operation on the data.
pub const TransformStep = struct {
    /// A transform step that groups data and applies aggregation functions to
    /// calculate summary values.
    aggregate_step: ?AggregateOperation,

    /// A transform step that combines rows from multiple sources by stacking them
    /// vertically.
    append_step: ?AppendOperation,

    /// A transform step that changes the data types of one or more columns.
    cast_column_types_step: ?CastColumnTypesOperation,

    create_columns_step: ?CreateColumnsOperation,

    /// A transform step that applies filter conditions.
    filters_step: ?FiltersOperation,

    /// A transform step that brings data from a source table.
    import_table_step: ?ImportTableOperation,

    /// A transform step that combines data from two sources based on specified join
    /// conditions.
    join_step: ?JoinOperation,

    /// A transform step that converts row values into columns to reshape the data
    /// structure.
    pivot_step: ?PivotOperation,

    project_step: ?ProjectOperation,

    /// A transform step that changes the names of one or more columns.
    rename_columns_step: ?RenameColumnsOperation,

    /// A transform step that converts columns into rows to normalize the data
    /// structure.
    unpivot_step: ?UnpivotOperation,

    pub const json_field_names = .{
        .aggregate_step = "AggregateStep",
        .append_step = "AppendStep",
        .cast_column_types_step = "CastColumnTypesStep",
        .create_columns_step = "CreateColumnsStep",
        .filters_step = "FiltersStep",
        .import_table_step = "ImportTableStep",
        .join_step = "JoinStep",
        .pivot_step = "PivotStep",
        .project_step = "ProjectStep",
        .rename_columns_step = "RenameColumnsStep",
        .unpivot_step = "UnpivotStep",
    };
};
