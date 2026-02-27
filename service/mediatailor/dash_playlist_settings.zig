/// Dash manifest configuration parameters.
pub const DashPlaylistSettings = struct {
    /// The total duration (in seconds) of each manifest. Minimum value: `30`
    /// seconds. Maximum value: `3600` seconds.
    manifest_window_seconds: ?i32,

    /// Minimum amount of content (measured in seconds) that a player must keep
    /// available in the buffer. Minimum value: `2` seconds. Maximum value: `60`
    /// seconds.
    min_buffer_time_seconds: ?i32,

    /// Minimum amount of time (in seconds) that the player should wait before
    /// requesting updates to the manifest. Minimum value: `2` seconds. Maximum
    /// value: `60` seconds.
    min_update_period_seconds: ?i32,

    /// Amount of time (in seconds) that the player should be from the live point at
    /// the end of the manifest. Minimum value: `2` seconds. Maximum value: `60`
    /// seconds.
    suggested_presentation_delay_seconds: ?i32,

    pub const json_field_names = .{
        .manifest_window_seconds = "ManifestWindowSeconds",
        .min_buffer_time_seconds = "MinBufferTimeSeconds",
        .min_update_period_seconds = "MinUpdatePeriodSeconds",
        .suggested_presentation_delay_seconds = "SuggestedPresentationDelaySeconds",
    };
};
