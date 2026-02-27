pub const JobStateTimeLimitActionsAction = enum {
    cancel,
    terminate,

    pub const json_field_names = .{
        .cancel = "CANCEL",
        .terminate = "TERMINATE",
    };
};
