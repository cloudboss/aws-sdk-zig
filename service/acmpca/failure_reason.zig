pub const FailureReason = enum {
    request_timed_out,
    unsupported_algorithm,
    other,

    pub const json_field_names = .{
        .request_timed_out = "REQUEST_TIMED_OUT",
        .unsupported_algorithm = "UNSUPPORTED_ALGORITHM",
        .other = "OTHER",
    };
};
