const GrpcRouteAction = @import("grpc_route_action.zig").GrpcRouteAction;
const GrpcRouteMatch = @import("grpc_route_match.zig").GrpcRouteMatch;
const GrpcRetryPolicy = @import("grpc_retry_policy.zig").GrpcRetryPolicy;
const GrpcTimeout = @import("grpc_timeout.zig").GrpcTimeout;

/// An object that represents a gRPC route type.
pub const GrpcRoute = struct {
    /// An object that represents the action to take if a match is determined.
    action: GrpcRouteAction,

    /// An object that represents the criteria for determining a request match.
    match: GrpcRouteMatch,

    /// An object that represents a retry policy.
    retry_policy: ?GrpcRetryPolicy,

    /// An object that represents types of timeouts.
    timeout: ?GrpcTimeout,

    pub const json_field_names = .{
        .action = "action",
        .match = "match",
        .retry_policy = "retryPolicy",
        .timeout = "timeout",
    };
};
