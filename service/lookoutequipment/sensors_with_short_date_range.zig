/// Entity that comprises information on sensors that have shorter date range.
pub const SensorsWithShortDateRange = struct {
    /// Indicates the number of sensors that have less than 14 days of data.
    affected_sensor_count: i32,

    pub const json_field_names = .{
        .affected_sensor_count = "AffectedSensorCount",
    };
};
