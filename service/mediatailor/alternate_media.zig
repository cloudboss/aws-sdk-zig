const AdBreak = @import("ad_break.zig").AdBreak;
const ClipRange = @import("clip_range.zig").ClipRange;

/// A playlist of media (VOD and/or live) to be played instead of the default
/// media on a particular program.
pub const AlternateMedia = struct {
    /// Ad break configuration parameters defined in AlternateMedia.
    ad_breaks: ?[]const AdBreak,

    clip_range: ?ClipRange,

    /// The duration of the alternateMedia in milliseconds.
    duration_millis: ?i64,

    /// The name of the live source for alternateMedia.
    live_source_name: ?[]const u8,

    /// The date and time that the alternateMedia is scheduled to start, in epoch
    /// milliseconds.
    scheduled_start_time_millis: ?i64,

    /// The name of the source location for alternateMedia.
    source_location_name: ?[]const u8,

    /// The name of the VOD source for alternateMedia.
    vod_source_name: ?[]const u8,

    pub const json_field_names = .{
        .ad_breaks = "AdBreaks",
        .clip_range = "ClipRange",
        .duration_millis = "DurationMillis",
        .live_source_name = "LiveSourceName",
        .scheduled_start_time_millis = "ScheduledStartTimeMillis",
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};
