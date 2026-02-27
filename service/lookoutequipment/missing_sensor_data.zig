/// Entity that comprises aggregated information on sensors having missing data.
pub const MissingSensorData = struct {
    /// Indicates the number of sensors that have atleast some data missing.
    affected_sensor_count: i32,

    /// Indicates the total number of missing values across all the sensors.
    total_number_of_missing_values: i32,

    pub const json_field_names = .{
        .affected_sensor_count = "AffectedSensorCount",
        .total_number_of_missing_values = "TotalNumberOfMissingValues",
    };
};
