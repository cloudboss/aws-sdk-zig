/// The schedule's ad break properties.
pub const ScheduleAdBreak = struct {
    /// The approximate duration of the ad break, in seconds.
    approximate_duration_seconds: ?i64,

    /// The approximate time that the ad will start playing.
    approximate_start_time: ?i64,

    /// The name of the source location containing the VOD source used for the ad
    /// break.
    source_location_name: ?[]const u8,

    /// The name of the VOD source used for the ad break.
    vod_source_name: ?[]const u8,

    pub const json_field_names = .{
        .approximate_duration_seconds = "ApproximateDurationSeconds",
        .approximate_start_time = "ApproximateStartTime",
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};
