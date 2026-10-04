/// Configuration for the post-roll ad break to use for this ad configuration.
pub const PostRollConfiguration = struct {
    /// Duration of the post-roll ad break, in seconds.
    duration_seconds: i32,

    /// Whether the post-roll ad configuration is enabled.
    enabled: bool = false,

    pub const json_field_names = .{
        .duration_seconds = "durationSeconds",
        .enabled = "enabled",
    };
};
