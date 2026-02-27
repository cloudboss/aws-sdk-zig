pub const FreeTrialInfoErrorCode = enum {
    access_denied,
    internal_error,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .internal_error = "INTERNAL_ERROR",
    };
};
