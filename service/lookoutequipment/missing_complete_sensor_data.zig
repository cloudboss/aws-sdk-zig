/// Entity that comprises information on sensors that have sensor data
/// completely missing.
pub const MissingCompleteSensorData = struct {
    /// Indicates the number of sensors that have data missing completely.
    affected_sensor_count: i32,

    pub const json_field_names = .{
        .affected_sensor_count = "AffectedSensorCount",
    };
};
