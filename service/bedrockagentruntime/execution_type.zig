pub const ExecutionType = enum {
    lambda,
    return_control,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
        .return_control = "RETURN_CONTROL",
    };
};
