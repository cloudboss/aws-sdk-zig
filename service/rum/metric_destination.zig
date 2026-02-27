pub const MetricDestination = enum {
    cloud_watch,
    evidently,

    pub const json_field_names = .{
        .cloud_watch = "CloudWatch",
        .evidently = "Evidently",
    };
};
