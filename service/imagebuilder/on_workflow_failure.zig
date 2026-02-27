pub const OnWorkflowFailure = enum {
    @"continue",
    abort,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .abort = "ABORT",
    };
};
