pub const JobEndBehavior = enum {
    stop_rollout,
    cancel,
    force_cancel,

    pub const json_field_names = .{
        .stop_rollout = "STOP_ROLLOUT",
        .cancel = "CANCEL",
        .force_cancel = "FORCE_CANCEL",
    };
};
