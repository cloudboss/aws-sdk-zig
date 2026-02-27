const DuplicateTimestamps = @import("duplicate_timestamps.zig").DuplicateTimestamps;
const InsufficientSensorData = @import("insufficient_sensor_data.zig").InsufficientSensorData;
const InvalidSensorData = @import("invalid_sensor_data.zig").InvalidSensorData;
const MissingSensorData = @import("missing_sensor_data.zig").MissingSensorData;
const UnsupportedTimestamps = @import("unsupported_timestamps.zig").UnsupportedTimestamps;

/// DataQualitySummary gives aggregated statistics over all the sensors about a
/// completed
/// ingestion job. It primarily gives more information about statistics over
/// different
/// incorrect data like MissingCompleteSensorData, MissingSensorData,
/// UnsupportedDateFormats,
/// InsufficientSensorData, DuplicateTimeStamps.
pub const DataQualitySummary = struct {
    /// Parameter that gives information about duplicate timestamps in the input
    /// data.
    duplicate_timestamps: DuplicateTimestamps,

    /// Parameter that gives information about insufficient data for sensors in the
    /// dataset.
    /// This includes information about those sensors that have complete data
    /// missing and those
    /// with a short date range.
    insufficient_sensor_data: InsufficientSensorData,

    /// Parameter that gives information about data that is invalid over all the
    /// sensors in the
    /// input data.
    invalid_sensor_data: InvalidSensorData,

    /// Parameter that gives information about data that is missing over all the
    /// sensors in the
    /// input data.
    missing_sensor_data: MissingSensorData,

    /// Parameter that gives information about unsupported timestamps in the input
    /// data.
    unsupported_timestamps: UnsupportedTimestamps,

    pub const json_field_names = .{
        .duplicate_timestamps = "DuplicateTimestamps",
        .insufficient_sensor_data = "InsufficientSensorData",
        .invalid_sensor_data = "InvalidSensorData",
        .missing_sensor_data = "MissingSensorData",
        .unsupported_timestamps = "UnsupportedTimestamps",
    };
};
