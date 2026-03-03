const DimensionMapping = @import("dimension_mapping.zig").DimensionMapping;
const MixedMeasureMapping = @import("mixed_measure_mapping.zig").MixedMeasureMapping;
const MultiMeasureMappings = @import("multi_measure_mappings.zig").MultiMeasureMappings;

/// Configuration to write data into Timestream database and table. This
/// configuration
/// allows the user to map the query result select columns into the destination
/// table
/// columns.
pub const TimestreamConfiguration = struct {
    /// Name of Timestream database to which the query result will be written.
    database_name: []const u8,

    /// This is to allow mapping column(s) from the query result to the dimension in
    /// the
    /// destination table.
    dimension_mappings: []const DimensionMapping,

    /// Name of the measure column.
    measure_name_column: ?[]const u8 = null,

    /// Specifies how to map measures to multi-measure records.
    mixed_measure_mappings: ?[]const MixedMeasureMapping = null,

    /// Multi-measure mappings.
    multi_measure_mappings: ?MultiMeasureMappings = null,

    /// Name of Timestream table that the query result will be written to. The table
    /// should be
    /// within the same database that is provided in Timestream configuration.
    table_name: []const u8,

    /// Column from query result that should be used as the time column in
    /// destination table.
    /// Column type for this should be TIMESTAMP.
    time_column: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .dimension_mappings = "DimensionMappings",
        .measure_name_column = "MeasureNameColumn",
        .mixed_measure_mappings = "MixedMeasureMappings",
        .multi_measure_mappings = "MultiMeasureMappings",
        .table_name = "TableName",
        .time_column = "TimeColumn",
    };
};
