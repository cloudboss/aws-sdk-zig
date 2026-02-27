pub const ParticipantRecordingState = enum {
    starting,
    active,
    stopping,
    stopped,
    failed,
    disabled,

    pub const json_field_names = .{
        .starting = "STARTING",
        .active = "ACTIVE",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .disabled = "DISABLED",
    };
};
