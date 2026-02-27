pub const RecoveryInstanceDataReplicationState = enum {
    stopped,
    initiating,
    initial_sync,
    backlog,
    creating_snapshot,
    continuous,
    paused,
    rescan,
    stalled,
    disconnected,
    replication_state_not_available,
    not_started,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .initiating = "INITIATING",
        .initial_sync = "INITIAL_SYNC",
        .backlog = "BACKLOG",
        .creating_snapshot = "CREATING_SNAPSHOT",
        .continuous = "CONTINUOUS",
        .paused = "PAUSED",
        .rescan = "RESCAN",
        .stalled = "STALLED",
        .disconnected = "DISCONNECTED",
        .replication_state_not_available = "REPLICATION_STATE_NOT_AVAILABLE",
        .not_started = "NOT_STARTED",
    };
};
