const ScheduleAdBreak = @import("schedule_ad_break.zig").ScheduleAdBreak;
const ScheduleEntryType = @import("schedule_entry_type.zig").ScheduleEntryType;

/// The properties for a schedule.
pub const ScheduleEntry = struct {
    /// The approximate duration of this program, in seconds.
    approximate_duration_seconds: ?i64 = null,

    /// The approximate time that the program will start playing.
    approximate_start_time: ?i64 = null,

    /// The ARN of the program.
    arn: []const u8,

    /// The list of audiences defined in ScheduleEntry.
    audiences: ?[]const []const u8 = null,

    /// The name of the channel that uses this schedule.
    channel_name: []const u8,

    /// The name of the live source used for the program.
    live_source_name: ?[]const u8 = null,

    /// The name of the program.
    program_name: []const u8,

    /// The schedule's ad break properties.
    schedule_ad_breaks: ?[]const ScheduleAdBreak = null,

    /// The type of schedule entry.
    schedule_entry_type: ?ScheduleEntryType = null,

    /// The name of the source location.
    source_location_name: []const u8,

    /// The name of the VOD source.
    vod_source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_duration_seconds = "ApproximateDurationSeconds",
        .approximate_start_time = "ApproximateStartTime",
        .arn = "Arn",
        .audiences = "Audiences",
        .channel_name = "ChannelName",
        .live_source_name = "LiveSourceName",
        .program_name = "ProgramName",
        .schedule_ad_breaks = "ScheduleAdBreaks",
        .schedule_entry_type = "ScheduleEntryType",
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};
