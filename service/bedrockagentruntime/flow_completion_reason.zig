pub const FlowCompletionReason = enum {
    success,
    input_required,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .input_required = "INPUT_REQUIRED",
    };
};
