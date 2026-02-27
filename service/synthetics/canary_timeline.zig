/// This structure contains information about when the canary was created and
/// modified.
pub const CanaryTimeline = struct {
    /// The date and time the canary was created.
    created: ?i64,

    /// The date and time the canary was most recently modified.
    last_modified: ?i64,

    /// The date and time that the canary's most recent run started.
    last_started: ?i64,

    /// The date and time that the canary's most recent run ended.
    last_stopped: ?i64,

    pub const json_field_names = .{
        .created = "Created",
        .last_modified = "LastModified",
        .last_started = "LastStarted",
        .last_stopped = "LastStopped",
    };
};
