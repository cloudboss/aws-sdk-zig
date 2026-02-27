pub const MeasurementSystem = enum {
    metric,
    imperial,

    pub const json_field_names = .{
        .metric = "METRIC",
        .imperial = "IMPERIAL",
    };
};
