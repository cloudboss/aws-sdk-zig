pub const QueryErrorCode = enum {
    internal_failure,
    access_denied,

    pub const json_field_names = .{
        .internal_failure = "INTERNAL_FAILURE",
        .access_denied = "ACCESS_DENIED",
    };
};
