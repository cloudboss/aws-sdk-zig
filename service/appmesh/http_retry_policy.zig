const Duration = @import("duration.zig").Duration;
const TcpRetryPolicyEvent = @import("tcp_retry_policy_event.zig").TcpRetryPolicyEvent;

/// An object that represents a retry policy. Specify at least one value for at
/// least one of the types of `RetryEvents`, a value for `maxRetries`, and a
/// value for `perRetryTimeout`.
/// Both `server-error` and `gateway-error` under `httpRetryEvents` include the
/// Envoy `reset` policy. For more information on the
/// `reset` policy, see the [Envoy
/// documentation](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/router_filter#x-envoy-retry-on).
pub const HttpRetryPolicy = struct {
    /// Specify at least one of the following values.
    ///
    /// * **server-error** – HTTP status codes 500, 501,
    /// 502, 503, 504, 505, 506, 507, 508, 510, and 511
    ///
    /// * **gateway-error** – HTTP status codes 502,
    /// 503, and 504
    ///
    /// * **client-error** – HTTP status code 409
    ///
    /// * **stream-error** – Retry on refused
    /// stream
    http_retry_events: ?[]const []const u8 = null,

    /// The maximum number of retry attempts.
    max_retries: i64,

    /// The timeout for each retry attempt.
    per_retry_timeout: Duration,

    /// Specify a valid value. The event occurs before any processing of a request
    /// has started and is encountered when the upstream is temporarily or
    /// permanently unavailable.
    tcp_retry_events: ?[]const TcpRetryPolicyEvent = null,

    pub const json_field_names = .{
        .http_retry_events = "httpRetryEvents",
        .max_retries = "maxRetries",
        .per_retry_timeout = "perRetryTimeout",
        .tcp_retry_events = "tcpRetryEvents",
    };
};
