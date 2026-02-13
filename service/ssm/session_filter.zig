const SessionFilterKey = @import("session_filter_key.zig").SessionFilterKey;

/// Describes a filter for Session Manager information.
pub const SessionFilter = struct {
    /// The name of the filter.
    key: SessionFilterKey,

    /// The filter value. Valid values for each filter key are as follows:
    ///
    /// * InvokedAfter: Specify a timestamp to limit your results. For example,
    ///   specify
    /// 2024-08-29T00:00:00Z to see sessions that started August 29, 2024, and
    /// later.
    ///
    /// * InvokedBefore: Specify a timestamp to limit your results. For example,
    ///   specify
    /// 2024-08-29T00:00:00Z to see sessions that started before August 29, 2024.
    ///
    /// * Target: Specify a managed node to which session connections have been
    ///   made.
    ///
    /// * Owner: Specify an Amazon Web Services user to see a list of sessions
    ///   started by that user.
    ///
    /// * Status: Specify a valid session status to see a list of all sessions with
    ///   that status.
    /// Status values you can specify include:
    ///
    /// * Connected
    ///
    /// * Connecting
    ///
    /// * Disconnected
    ///
    /// * Terminated
    ///
    /// * Terminating
    ///
    /// * Failed
    ///
    /// * SessionId: Specify a session ID to return details about the session.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
