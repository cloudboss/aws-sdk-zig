pub const CustomStepStatus = enum {
    success,
    failure,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failure = "FAILURE",
    };
};
