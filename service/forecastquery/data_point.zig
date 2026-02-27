/// The forecast value for a specific date. Part of the Forecast
/// object.
pub const DataPoint = struct {
    /// The timestamp of the specific forecast.
    timestamp: ?[]const u8,

    /// The forecast value.
    value: ?f64,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
