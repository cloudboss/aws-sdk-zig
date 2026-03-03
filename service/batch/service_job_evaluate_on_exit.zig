const ServiceJobRetryAction = @import("service_job_retry_action.zig").ServiceJobRetryAction;

/// Specifies conditions for when to exit or retry a service job based on the
/// exit status or status reason.
pub const ServiceJobEvaluateOnExit = struct {
    /// The action to take if the service job exits with the specified condition.
    /// Valid values are `RETRY` and `EXIT`.
    action: ?ServiceJobRetryAction = null,

    /// Contains a glob pattern to match against the StatusReason returned for a
    /// job. The pattern can contain up to 512 characters and can contain all
    /// printable characters. It can optionally end with an asterisk (*) so that
    /// only the start of the string needs to be an exact match.
    on_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .on_status_reason = "onStatusReason",
    };
};
