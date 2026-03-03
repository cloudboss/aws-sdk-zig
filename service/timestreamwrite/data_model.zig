const DimensionMapping = @import("dimension_mapping.zig").DimensionMapping;
const MixedMeasureMapping = @import("mixed_measure_mapping.zig").MixedMeasureMapping;
const MultiMeasureMappings = @import("multi_measure_mappings.zig").MultiMeasureMappings;
const TimeUnit = @import("time_unit.zig").TimeUnit;

/// Data model for a batch load task.
pub const DataModel = struct {
    /// Source to target mappings for dimensions.
    dimension_mappings: []const DimensionMapping,

    measure_name_column: ?[]const u8 = null,

    /// Source to target mappings for measures.
    mixed_measure_mappings: ?[]const MixedMeasureMapping = null,

    /// Source to target mappings for multi-measure records.
    multi_measure_mappings: ?MultiMeasureMappings = null,

    /// Source column to be mapped to time.
    time_column: ?[]const u8 = null,

    /// The granularity of the timestamp unit. It indicates if the time value is in
    /// seconds,
    /// milliseconds, nanoseconds, or other supported values. Default is
    /// `MILLISECONDS`.
    time_unit: ?TimeUnit = null,

    pub const json_field_names = .{
        .dimension_mappings = "DimensionMappings",
        .measure_name_column = "MeasureNameColumn",
        .mixed_measure_mappings = "MixedMeasureMappings",
        .multi_measure_mappings = "MultiMeasureMappings",
        .time_column = "TimeColumn",
        .time_unit = "TimeUnit",
    };
};
