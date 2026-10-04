const SpaceSummary = @import("space_summary.zig").SpaceSummary;

pub const ListSpacesResponse = struct {
    /// The token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The ARN of the space.
    space_arn: ?[]const u8 = null,

    /// The ID of the space.
    space_id: []const u8,

    /// A list of space summaries.
    space_summaries: []const SpaceSummary,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .request_id = "RequestId",
        .space_arn = "spaceArn",
        .space_id = "spaceId",
        .space_summaries = "SpaceSummaries",
    };
};
