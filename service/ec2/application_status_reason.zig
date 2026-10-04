/// Describes the reason for an application status check result.
pub const ApplicationStatusReason = struct {
    /// The reason code for the application status check result. Possible values:
    ///
    /// * `ResponseCodeMatched` – The HTTP status code returned by the health check
    ///   matched the configured `StatusCodeMatcher`.
    ///
    /// * `ResponseCodeMismatch` – The HTTP status code returned by the health check
    ///   did not match the configured `StatusCodeMatcher`.
    ///
    /// * `ConnectionTimeout` – The connection to the target timed out.
    ///
    /// * `ResponseTimeout` – The health check timed out while waiting for a
    ///   response from the target.
    ///
    /// * `ConnectionRefused` – The target refused the health check connection.
    ///
    /// * `ConnectionReset` – The target reset the health check connection before
    ///   returning a response.
    ///
    /// Current health check results use the values in the preceding list. Legacy
    /// results that do not contain structured reason metadata can instead contain a
    /// producer error type, such as `Http Status Code` or
    /// `HttpConnectTimeoutException`.
    ///
    /// For `ResponseCodeMatched` and `ResponseCodeMismatch`, the `statusCode` field
    /// contains the returned HTTP status code. The `protocol` field contains the
    /// protocol used for the health check.
    code: ?[]const u8 = null,

    /// The protocol used for the health check. Possible values: `HTTP` and `HTTPS`.
    protocol: ?[]const u8 = null,

    /// The HTTP status code returned by the health check.
    status_code: ?i32 = null,
};
