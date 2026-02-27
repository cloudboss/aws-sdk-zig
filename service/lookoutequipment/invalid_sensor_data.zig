/// Entity that comprises aggregated information on sensors having insufficient
/// data.
pub const InvalidSensorData = struct {
    /// Indicates the number of sensors that have at least some invalid values.
    affected_sensor_count: i32,

    /// Indicates the total number of invalid values across all the sensors.
    total_number_of_invalid_values: i32,

    pub const json_field_names = .{
        .affected_sensor_count = "AffectedSensorCount",
        .total_number_of_invalid_values = "TotalNumberOfInvalidValues",
    };
};
