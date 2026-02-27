pub const EventName = enum {
    joined,
    left,
    publish_started,
    publish_stopped,
    subscribe_started,
    subscribe_stopped,
    publish_error,
    subscribe_error,
    join_error,
    replication_started,
    replication_stopped,
    token_exchanged,

    pub const json_field_names = .{
        .joined = "JOINED",
        .left = "LEFT",
        .publish_started = "PUBLISH_STARTED",
        .publish_stopped = "PUBLISH_STOPPED",
        .subscribe_started = "SUBSCRIBE_STARTED",
        .subscribe_stopped = "SUBSCRIBE_STOPPED",
        .publish_error = "PUBLISH_ERROR",
        .subscribe_error = "SUBSCRIBE_ERROR",
        .join_error = "JOIN_ERROR",
        .replication_started = "REPLICATION_STARTED",
        .replication_stopped = "REPLICATION_STOPPED",
        .token_exchanged = "TOKEN_EXCHANGED",
    };
};
