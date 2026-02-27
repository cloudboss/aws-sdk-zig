const ReplayState = @import("replay_state.zig").ReplayState;

/// A `Replay` object that contains details about a replay.
pub const Replay = struct {
    /// A time stamp for the time to start replaying events. Any event with a
    /// creation time prior
    /// to the `EventEndTime` specified is replayed.
    event_end_time: ?i64,

    /// A time stamp for the time that the last event was replayed.
    event_last_replayed_time: ?i64,

    /// The ARN of the archive to replay event from.
    event_source_arn: ?[]const u8,

    /// A time stamp for the time to start replaying events. This is determined by
    /// the time in the
    /// event as described in
    /// [Time](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEventsRequestEntry.html#eventbridge-Type-PutEventsRequestEntry-Time).
    event_start_time: ?i64,

    /// A time stamp for the time that the replay completed.
    replay_end_time: ?i64,

    /// The name of the replay.
    replay_name: ?[]const u8,

    /// A time stamp for the time that the replay started.
    replay_start_time: ?i64,

    /// The current state of the replay.
    state: ?ReplayState,

    /// A description of why the replay is in the current state.
    state_reason: ?[]const u8,

    pub const json_field_names = .{
        .event_end_time = "EventEndTime",
        .event_last_replayed_time = "EventLastReplayedTime",
        .event_source_arn = "EventSourceArn",
        .event_start_time = "EventStartTime",
        .replay_end_time = "ReplayEndTime",
        .replay_name = "ReplayName",
        .replay_start_time = "ReplayStartTime",
        .state = "State",
        .state_reason = "StateReason",
    };
};
