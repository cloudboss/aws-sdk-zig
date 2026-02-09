pub const ThrottleReason = enum {
    concurrent_invocation_limit_exceeded,
    function_invocation_rate_limit_exceeded,
    reserved_function_concurrent_invocation_limit_exceeded,
    reserved_function_invocation_rate_limit_exceeded,
    caller_rate_limit_exceeded,
    concurrent_snapshot_create_limit_exceeded,
};
