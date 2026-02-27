pub const StepCancellationOption = enum {
    send_interrupt,
    terminate_process,

    pub const json_field_names = .{
        .send_interrupt = "SEND_INTERRUPT",
        .terminate_process = "TERMINATE_PROCESS",
    };
};
