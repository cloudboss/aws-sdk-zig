pub const TerminationMode = enum {
    trigger_on_process_terminate,
    force_terminate,

    pub const json_field_names = .{
        .trigger_on_process_terminate = "TRIGGER_ON_PROCESS_TERMINATE",
        .force_terminate = "FORCE_TERMINATE",
    };
};
