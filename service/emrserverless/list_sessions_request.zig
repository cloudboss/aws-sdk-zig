const SessionState = @import("session_state.zig").SessionState;

pub const ListSessionsRequest = struct {
    /// The ID of the application to list sessions for.
    application_id: []const u8,

    /// The lower bound of the option to filter by creation date and time.
    created_at_after: ?i64 = null,

    /// The upper bound of the option to filter by creation date and time.
    created_at_before: ?i64 = null,

    /// The maximum number of sessions to return in each page of results.
    max_results: ?i32 = null,

    /// The token for the next set of session results.
    next_token: ?[]const u8 = null,

    /// An optional filter for session states. Note that if this filter contains
    /// multiple states, the resulting list will be grouped by the state.
    states: ?[]const SessionState = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .created_at_after = "createdAtAfter",
        .created_at_before = "createdAtBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .states = "states",
    };
};
