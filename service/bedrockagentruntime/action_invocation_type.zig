pub const ActionInvocationType = enum {
    result,
    user_confirmation,
    user_confirmation_and_result,

    pub const json_field_names = .{
        .result = "RESULT",
        .user_confirmation = "USER_CONFIRMATION",
        .user_confirmation_and_result = "USER_CONFIRMATION_AND_RESULT",
    };
};
