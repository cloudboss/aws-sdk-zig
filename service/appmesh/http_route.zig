const HttpRouteAction = @import("http_route_action.zig").HttpRouteAction;
const HttpRouteMatch = @import("http_route_match.zig").HttpRouteMatch;
const HttpRetryPolicy = @import("http_retry_policy.zig").HttpRetryPolicy;
const HttpTimeout = @import("http_timeout.zig").HttpTimeout;

/// An object that represents an HTTP or HTTP/2 route type.
pub const HttpRoute = struct {
    /// An object that represents the action to take if a match is determined.
    action: HttpRouteAction,

    /// An object that represents the criteria for determining a request match.
    match: HttpRouteMatch,

    /// An object that represents a retry policy.
    retry_policy: ?HttpRetryPolicy,

    /// An object that represents types of timeouts.
    timeout: ?HttpTimeout,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .retry_policy = "retryPolicy",
        .timeout = "timeout",
    };
};
