const JourneyRunResponse = @import("journey_run_response.zig").JourneyRunResponse;

/// Provides information from all runs of a journey.
pub const JourneyRunsResponse = struct {
    /// An array of responses, one for each run of the journey
    item: []const JourneyRunResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
