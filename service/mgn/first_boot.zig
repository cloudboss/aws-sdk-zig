pub const FirstBoot = enum {
    waiting,
    succeeded,
    unknown,
    stopped,

    pub const json_field_names = .{
        .waiting = "WAITING",
        .succeeded = "SUCCEEDED",
        .unknown = "UNKNOWN",
        .stopped = "STOPPED",
    };
};
