pub const ChannelStatus = enum {
    in_progress,
    created,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .created = "CREATED",
        .failed = "FAILED",
    };
};
