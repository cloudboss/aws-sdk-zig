/// Configuration settings for sharing the stream session's performance stats
/// with the client
pub const PerformanceStatsConfiguration = struct {
    /// Performance stats for the session are streamed to the client when set to
    /// `true`. Defaults to `false`.
    shared_with_client: ?bool = null,

    pub const json_field_names = .{
        .shared_with_client = "SharedWithClient",
    };
};
