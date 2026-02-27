pub const RequestThrottledExceptionReason = enum {
    account_throttled,
    dependency_request_throttled,
    resource_level_throttle,

    pub const json_field_names = .{
        .account_throttled = "ACCOUNT_THROTTLED",
        .dependency_request_throttled = "DEPENDENCY_REQUEST_THROTTLED",
        .resource_level_throttle = "RESOURCE_LEVEL_THROTTLE",
    };
};
