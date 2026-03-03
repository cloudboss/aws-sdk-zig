const RetryAction = @import("retry_action.zig").RetryAction;

/// Specifies an array of up to 5 conditions to be met, and an action to take
/// (`RETRY` or `EXIT`) if all conditions are met. If none of the
/// `EvaluateOnExit` conditions in a `RetryStrategy` match, then the job is
/// retried.
pub const EvaluateOnExit = struct {
    /// Specifies the action to take if all of the specified conditions
    /// (`onStatusReason`, `onReason`, and `onExitCode`) are met. The
    /// values aren't case sensitive.
    action: RetryAction,

    /// Contains a glob pattern to match against the decimal representation of the
    /// `ExitCode` returned for a job. The pattern can be up to 512 characters long.
    /// It can
    /// contain only numbers, and can end with an asterisk (*) so that only the
    /// start of the string needs
    /// to be an exact match.
    ///
    /// The string can contain up to 512 characters.
    on_exit_code: ?[]const u8 = null,

    /// Contains a glob pattern to match against the `Reason` returned for a job.
    /// The
    /// pattern can contain up to 512 characters. It can contain letters, numbers,
    /// periods (.), colons
    /// (:), and white space (including spaces and tabs). It can optionally end with
    /// an asterisk (*) so
    /// that only the start of the string needs to be an exact match.
    on_reason: ?[]const u8 = null,

    /// Contains a glob pattern to match against the `StatusReason` returned for a
    /// job.
    /// The pattern can contain up to 512 characters. It can contain letters,
    /// numbers, periods (.),
    /// colons (:), and white spaces (including spaces or tabs). It can optionally
    /// end with an asterisk (*)
    /// so that only the start of the string needs to be an exact match.
    on_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .on_exit_code = "onExitCode",
        .on_reason = "onReason",
        .on_status_reason = "onStatusReason",
    };
};
