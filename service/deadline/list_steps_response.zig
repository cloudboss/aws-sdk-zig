const StepSummary = @import("step_summary.zig").StepSummary;

/// Shared pagination field for List operation outputs (nextToken).
pub const ListStepsResponse = struct {
    /// If Deadline Cloud returns `nextToken`, then there are more results
    /// available. The value of `nextToken` is a unique pagination token for each
    /// page. To retrieve the next page, call the operation again using the returned
    /// token. Keep all other arguments unchanged. If no results remain, then
    /// `nextToken` is set to `null`. Each pagination token expires after 24 hours.
    /// If you provide a token that isn't valid, then you receive an HTTP 400
    /// `ValidationException` error.
    next_token: ?[]const u8 = null,

    /// The steps on the list.
    steps: []const StepSummary,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .steps = "steps",
    };
};
