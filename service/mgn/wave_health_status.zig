pub const WaveHealthStatus = enum {
    healthy,
    lagging,
    @"error",

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .lagging = "LAGGING",
        .@"error" = "ERROR",
    };
};
