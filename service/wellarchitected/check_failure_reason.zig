pub const CheckFailureReason = enum {
    assume_role_error,
    access_denied,
    unknown_error,
    premium_support_required,

    pub const json_field_names = .{
        .assume_role_error = "ASSUME_ROLE_ERROR",
        .access_denied = "ACCESS_DENIED",
        .unknown_error = "UNKNOWN_ERROR",
        .premium_support_required = "PREMIUM_SUPPORT_REQUIRED",
    };
};
