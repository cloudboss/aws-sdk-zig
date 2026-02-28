const RelativePosition = @import("relative_position.zig").RelativePosition;

/// Program transition configuration.
pub const Transition = struct {
    /// The duration of the live program in seconds.
    duration_millis: ?i64,

    /// The position where this program will be inserted relative to the
    /// `RelativePosition`.
    relative_position: RelativePosition,

    /// The name of the program that this program will be inserted next to, as
    /// defined by `RelativePosition`.
    relative_program: ?[]const u8,

    /// The date and time that the program is scheduled to start, in epoch
    /// milliseconds.
    scheduled_start_time_millis: ?i64,

    /// Defines when the program plays in the schedule. You can set the value to
    /// `ABSOLUTE` or `RELATIVE`.
    ///
    /// `ABSOLUTE` - The program plays at a specific wall clock time. This setting
    /// can only be used for channels using the `LINEAR` `PlaybackMode`.
    ///
    /// Note the following considerations when using `ABSOLUTE` transitions:
    ///
    /// If the preceding program in the schedule has a duration that extends past
    /// the wall clock time, MediaTailor truncates the preceding program on a common
    /// segment boundary.
    ///
    /// If there are gaps in playback, MediaTailor plays the `FillerSlate` you
    /// configured for your linear channel.
    ///
    /// `RELATIVE` - The program is inserted into the schedule either before or
    /// after a program that you specify via `RelativePosition`.
    @"type": []const u8,

    pub const json_field_names = .{
        .duration_millis = "DurationMillis",
        .relative_position = "RelativePosition",
        .relative_program = "RelativeProgram",
        .scheduled_start_time_millis = "ScheduledStartTimeMillis",
        .@"type" = "Type",
    };
};
