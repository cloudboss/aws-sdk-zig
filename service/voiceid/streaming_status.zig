pub const StreamingStatus = enum {
    pending_configuration,
    ongoing,
    ended,

    pub const json_field_names = .{
        .pending_configuration = "PENDING_CONFIGURATION",
        .ongoing = "ONGOING",
        .ended = "ENDED",
    };
};
