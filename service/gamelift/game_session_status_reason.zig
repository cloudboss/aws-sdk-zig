pub const GameSessionStatusReason = enum {
    interrupted,
    triggered_on_process_terminate,
    force_terminated,

    pub const json_field_names = .{
        .interrupted = "INTERRUPTED",
        .triggered_on_process_terminate = "TRIGGERED_ON_PROCESS_TERMINATE",
        .force_terminated = "FORCE_TERMINATED",
    };
};
