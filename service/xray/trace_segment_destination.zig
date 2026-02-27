pub const TraceSegmentDestination = enum {
    x_ray,
    cloud_watch_logs,

    pub const json_field_names = .{
        .x_ray = "XRay",
        .cloud_watch_logs = "CloudWatchLogs",
    };
};
