const SessionState = @import("session_state.zig").SessionState;

/// Contains information about the status of a session.
pub const SessionStatus = struct {
    /// The date and time that the session ended.
    end_date_time: ?i64 = null,

    /// The date and time starting at which the session became idle. Can be empty if
    /// the
    /// session is not currently idle.
    idle_since_date_time: ?i64 = null,

    /// The most recent date and time that the session was modified.
    last_modified_date_time: ?i64 = null,

    /// The date and time that the session started.
    start_date_time: ?i64 = null,

    /// The state of the session. A description of each state follows.
    ///
    /// `CREATING` - The session is being started, including acquiring
    /// resources.
    ///
    /// `CREATED` - The session has been started.
    ///
    /// `IDLE` - The session is able to accept a calculation.
    ///
    /// `BUSY` - The session is processing another task and is unable to accept a
    /// calculation.
    ///
    /// `TERMINATING` - The session is in the process of shutting down.
    ///
    /// `TERMINATED` - The session and its resources are no longer running.
    ///
    /// `DEGRADED` - The session has no healthy coordinators.
    ///
    /// `FAILED` - Due to a failure, the session and its resources are no longer
    /// running.
    state: ?SessionState = null,

    /// The reason for the session state change (for example, canceled because the
    /// session was
    /// terminated).
    state_change_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date_time = "EndDateTime",
        .idle_since_date_time = "IdleSinceDateTime",
        .last_modified_date_time = "LastModifiedDateTime",
        .start_date_time = "StartDateTime",
        .state = "State",
        .state_change_reason = "StateChangeReason",
    };
};
