/// Information about the auto-retry configuration for the build.
pub const AutoRetryConfig = struct {
    /// The maximum number of additional automatic retries after a failed build. For
    /// example, if the
    /// auto-retry limit is set to 2, CodeBuild will call the `RetryBuild` API to
    /// automatically
    /// retry your build for up to 2 additional times.
    auto_retry_limit: ?i32 = null,

    /// The number of times that the build has been retried. The initial build will
    /// have an auto-retry number of 0.
    auto_retry_number: ?i32 = null,

    /// The build ARN of the auto-retried build triggered by the current build. The
    /// next auto-retry
    /// will be `null` for builds that don't trigger an auto-retry.
    next_auto_retry: ?[]const u8 = null,

    /// The build ARN of the build that triggered the current auto-retry build. The
    /// previous auto-retry will be
    /// `null` for the initial build.
    previous_auto_retry: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_retry_limit = "autoRetryLimit",
        .auto_retry_number = "autoRetryNumber",
        .next_auto_retry = "nextAutoRetry",
        .previous_auto_retry = "previousAutoRetry",
    };
};
