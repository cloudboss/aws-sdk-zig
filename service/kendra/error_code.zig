pub const ErrorCode = enum {
    internal_error,
    invalid_request,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_request = "INVALID_REQUEST",
    };
};
