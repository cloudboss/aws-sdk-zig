const CategoricalValues = @import("categorical_values.zig").CategoricalValues;
const CountPercent = @import("count_percent.zig").CountPercent;
const LargeTimestampGaps = @import("large_timestamp_gaps.zig").LargeTimestampGaps;
const MonotonicValues = @import("monotonic_values.zig").MonotonicValues;
const MultipleOperatingModes = @import("multiple_operating_modes.zig").MultipleOperatingModes;

/// Summary of ingestion statistics like whether data exists, number of missing
/// values,
/// number of invalid values and so on related to the particular sensor.
pub const SensorStatisticsSummary = struct {
    /// Parameter that describes potential risk about whether data associated with
    /// the sensor
    /// is categorical.
    categorical_values: ?CategoricalValues,

    /// Name of the component to which the particular sensor belongs for which the
    /// statistics
    /// belong to.
    component_name: ?[]const u8,

    /// Indicates the time reference to indicate the end of valid data associated
    /// with the
    /// sensor that the statistics belong to.
    data_end_time: ?i64,

    /// Parameter that indicates whether data exists for the sensor that the
    /// statistics belong
    /// to.
    data_exists: bool = false,

    /// Indicates the time reference to indicate the beginning of valid data
    /// associated with
    /// the sensor that the statistics belong to.
    data_start_time: ?i64,

    /// Parameter that describes the total number of duplicate timestamp records
    /// associated
    /// with the sensor that the statistics belong to.
    duplicate_timestamps: ?CountPercent,

    /// Parameter that describes the total number of invalid date entries associated
    /// with the
    /// sensor that the statistics belong to.
    invalid_date_entries: ?CountPercent,

    /// Parameter that describes the total number of, and percentage of, values that
    /// are
    /// invalid for the sensor that the statistics belong to.
    invalid_values: ?CountPercent,

    /// Parameter that describes potential risk about whether data associated with
    /// the sensor
    /// contains one or more large gaps between consecutive timestamps.
    large_timestamp_gaps: ?LargeTimestampGaps,

    /// Parameter that describes the total number of, and percentage of, values that
    /// are
    /// missing for the sensor that the statistics belong to.
    missing_values: ?CountPercent,

    /// Parameter that describes potential risk about whether data associated with
    /// the sensor
    /// is mostly monotonic.
    monotonic_values: ?MonotonicValues,

    /// Parameter that describes potential risk about whether data associated with
    /// the sensor
    /// has more than one operating mode.
    multiple_operating_modes: ?MultipleOperatingModes,

    /// Name of the sensor that the statistics belong to.
    sensor_name: ?[]const u8,

    pub const json_field_names = .{
        .categorical_values = "CategoricalValues",
        .component_name = "ComponentName",
        .data_end_time = "DataEndTime",
        .data_exists = "DataExists",
        .data_start_time = "DataStartTime",
        .duplicate_timestamps = "DuplicateTimestamps",
        .invalid_date_entries = "InvalidDateEntries",
        .invalid_values = "InvalidValues",
        .large_timestamp_gaps = "LargeTimestampGaps",
        .missing_values = "MissingValues",
        .monotonic_values = "MonotonicValues",
        .multiple_operating_modes = "MultipleOperatingModes",
        .sensor_name = "SensorName",
    };
};
