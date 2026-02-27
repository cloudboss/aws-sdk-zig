pub const UnauthorizedCacheControlHeaderStrategy = enum {
    fail_with_403,
    succeed_with_response_header,
    succeed_without_response_header,

    pub const json_field_names = .{
        .fail_with_403 = "FAIL_WITH_403",
        .succeed_with_response_header = "SUCCEED_WITH_RESPONSE_HEADER",
        .succeed_without_response_header = "SUCCEED_WITHOUT_RESPONSE_HEADER",
    };
};
