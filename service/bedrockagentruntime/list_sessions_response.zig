const SessionSummary = @import("session_summary.zig").SessionSummary;

pub const ListSessionsResponse = struct {
    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// A list of summaries for each session in your Amazon Web Services account.
    session_summaries: []const SessionSummary,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .session_summaries = "sessionSummaries",
    };
};
