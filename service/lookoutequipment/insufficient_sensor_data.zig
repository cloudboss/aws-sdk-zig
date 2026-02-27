const MissingCompleteSensorData = @import("missing_complete_sensor_data.zig").MissingCompleteSensorData;
const SensorsWithShortDateRange = @import("sensors_with_short_date_range.zig").SensorsWithShortDateRange;

/// Entity that comprises aggregated information on sensors having insufficient
/// data.
pub const InsufficientSensorData = struct {
    /// Parameter that describes the total number of sensors that have data
    /// completely missing
    /// for it.
    missing_complete_sensor_data: MissingCompleteSensorData,

    /// Parameter that describes the total number of sensors that have a short date
    /// range of
    /// less than 14 days of data overall.
    sensors_with_short_date_range: SensorsWithShortDateRange,

    pub const json_field_names = .{
        .missing_complete_sensor_data = "MissingCompleteSensorData",
        .sensors_with_short_date_range = "SensorsWithShortDateRange",
    };
};
