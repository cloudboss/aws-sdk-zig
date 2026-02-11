pub const ThrottleReason = enum {
    concurrent_invocation_limit_exceeded,
    function_invocation_rate_limit_exceeded,
    reserved_function_concurrent_invocation_limit_exceeded,
    reserved_function_invocation_rate_limit_exceeded,
    caller_rate_limit_exceeded,
    concurrent_snapshot_create_limit_exceeded,

    pub const json_field_names = .{
        .concurrent_invocation_limit_exceeded = "ConcurrentInvocationLimitExceeded",
        .function_invocation_rate_limit_exceeded = "FunctionInvocationRateLimitExceeded",
        .reserved_function_concurrent_invocation_limit_exceeded = "ReservedFunctionConcurrentInvocationLimitExceeded",
        .reserved_function_invocation_rate_limit_exceeded = "ReservedFunctionInvocationRateLimitExceeded",
        .caller_rate_limit_exceeded = "CallerRateLimitExceeded",
        .concurrent_snapshot_create_limit_exceeded = "ConcurrentSnapshotCreateLimitExceeded",
    };
};
