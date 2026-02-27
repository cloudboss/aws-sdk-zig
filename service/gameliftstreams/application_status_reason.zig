pub const ApplicationStatusReason = enum {
    internal_error,
    access_denied,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
    };
};
