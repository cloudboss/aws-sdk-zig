const aws = @import("aws");

const DestinationTable = @import("destination_table.zig").DestinationTable;
const SourceTable = @import("source_table.zig").SourceTable;
const TransformStep = @import("transform_step.zig").TransformStep;

/// Configuration for data preparation operations, defining the complete
/// pipeline from source tables
/// through transformations to destination tables.
pub const DataPrepConfiguration = struct {
    /// A map of destination tables that receive the final prepared data.
    destination_table_map: []const aws.map.MapEntry(DestinationTable),

    /// A map of source tables that provide information about underlying sources.
    source_table_map: []const aws.map.MapEntry(SourceTable),

    /// A map of transformation steps that process the data.
    transform_step_map: []const aws.map.MapEntry(TransformStep),

    pub const json_field_names = .{
        .destination_table_map = "DestinationTableMap",
        .source_table_map = "SourceTableMap",
        .transform_step_map = "TransformStepMap",
    };
};
