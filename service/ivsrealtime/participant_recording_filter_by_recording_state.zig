pub const ParticipantRecordingFilterByRecordingState = enum {
    starting,
    active,
    stopping,
    stopped,
    failed,

    pub const json_field_names = .{
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
    };
};
