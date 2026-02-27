pub const StreamHealth = enum {
    stream_healthy,
    starving,
    unknown,

    pub const json_field_names = .{
        .stream_healthy = "StreamHealthy",
        .starving = "Starving",
        .unknown = "Unknown",
    };
};
