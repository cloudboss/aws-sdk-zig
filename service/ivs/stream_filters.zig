const StreamHealth = @import("stream_health.zig").StreamHealth;

/// Object specifying the stream attribute on which to filter.
pub const StreamFilters = struct {
    /// The stream’s health.
    health: ?StreamHealth,

    pub const json_field_names = .{
        .health = "health",
    };
};
