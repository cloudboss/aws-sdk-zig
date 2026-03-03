/// An object containing data about a handled exception in the tested state.
pub const InspectionErrorDetails = struct {
    /// The array index of the Catch which handled the exception.
    catch_index: ?i32 = null,

    /// The duration in seconds of the backoff for a retry on a failed state
    /// invocation.
    retry_backoff_interval_seconds: ?i32 = null,

    /// The array index of the Retry which handled the exception.
    retry_index: ?i32 = null,

    pub const json_field_names = .{
        .catch_index = "catchIndex",
        .retry_backoff_interval_seconds = "retryBackoffIntervalSeconds",
        .retry_index = "retryIndex",
    };
};
