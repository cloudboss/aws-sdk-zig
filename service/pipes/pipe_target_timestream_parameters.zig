const DimensionMapping = @import("dimension_mapping.zig").DimensionMapping;
const EpochTimeUnit = @import("epoch_time_unit.zig").EpochTimeUnit;
const MultiMeasureMapping = @import("multi_measure_mapping.zig").MultiMeasureMapping;
const SingleMeasureMapping = @import("single_measure_mapping.zig").SingleMeasureMapping;
const TimeFieldType = @import("time_field_type.zig").TimeFieldType;

/// The parameters for using a Timestream for LiveAnalytics table as a
/// target.
pub const PipeTargetTimestreamParameters = struct {
    /// Map source data to dimensions in the target Timestream for LiveAnalytics
    /// table.
    ///
    /// For more information, see [Amazon Timestream for LiveAnalytics
    /// concepts](https://docs.aws.amazon.com/timestream/latest/developerguide/concepts.html)
    dimension_mappings: []const DimensionMapping,

    /// The granularity of the time units used. Default is `MILLISECONDS`.
    ///
    /// Required if `TimeFieldType` is specified as `EPOCH`.
    epoch_time_unit: ?EpochTimeUnit,

    /// Maps multiple measures from the source event to the same record in the
    /// specified Timestream for LiveAnalytics table.
    multi_measure_mappings: ?[]const MultiMeasureMapping,

    /// Mappings of single source data fields to individual records in the specified
    /// Timestream for LiveAnalytics table.
    single_measure_mappings: ?[]const SingleMeasureMapping,

    /// The type of time value used.
    ///
    /// The default is `EPOCH`.
    time_field_type: ?TimeFieldType,

    /// How to format the timestamps. For example,
    /// `yyyy-MM-dd'T'HH:mm:ss'Z'`.
    ///
    /// Required if `TimeFieldType` is specified as
    /// `TIMESTAMP_FORMAT`.
    timestamp_format: ?[]const u8,

    /// Dynamic path to the source data field that represents the time value for
    /// your data.
    time_value: []const u8,

    /// 64 bit version value or source data field that represents the version value
    /// for your data.
    ///
    /// Write requests with a higher version number will update the existing measure
    /// values of the record and version.
    /// In cases where the measure value is the same, the version will still be
    /// updated.
    ///
    /// Default value is 1.
    ///
    /// Timestream for LiveAnalytics does not support updating partial measure
    /// values in a record.
    ///
    /// Write requests for duplicate data with a
    /// higher version number will update the existing measure value and version. In
    /// cases where
    /// the measure value is the same, `Version` will still be updated. Default
    /// value is
    /// `1`.
    ///
    /// `Version` must be `1` or greater, or you will receive a
    /// `ValidationException` error.
    version_value: []const u8,

    pub const json_field_names = .{
        .dimension_mappings = "DimensionMappings",
        .epoch_time_unit = "EpochTimeUnit",
        .multi_measure_mappings = "MultiMeasureMappings",
        .single_measure_mappings = "SingleMeasureMappings",
        .time_field_type = "TimeFieldType",
        .timestamp_format = "TimestampFormat",
        .time_value = "TimeValue",
        .version_value = "VersionValue",
    };
};
