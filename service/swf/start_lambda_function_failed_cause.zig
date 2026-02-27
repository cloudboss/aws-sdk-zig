pub const StartLambdaFunctionFailedCause = enum {
    assume_role_failed,

    pub const json_field_names = .{
        .assume_role_failed = "ASSUME_ROLE_FAILED",
    };
};
