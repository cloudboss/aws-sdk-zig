/// The forecast value for a specific date. Part of the Forecast
/// object.
pub const DataPoint = struct {
    /// The timestamp of the specific forecast.
    timestamp: ?[]const u8 = null,

    /// The forecast value.
    value: ?f64 = null,

    pub const json_field_names = .{
        .timestamp = "Timestamp",
        .value = "Value",
    };
};
