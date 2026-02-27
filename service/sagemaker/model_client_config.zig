/// Configures the timeout and maximum number of retries for processing a
/// transform job invocation.
pub const ModelClientConfig = struct {
    /// The maximum number of retries when invocation requests are failing. The
    /// default value is 3.
    invocations_max_retries: ?i32,

    /// The timeout value in seconds for an invocation request. The default value is
    /// 600.
    invocations_timeout_in_seconds: ?i32,

    pub const json_field_names = .{
        .invocations_max_retries = "InvocationsMaxRetries",
        .invocations_timeout_in_seconds = "InvocationsTimeoutInSeconds",
    };
};
