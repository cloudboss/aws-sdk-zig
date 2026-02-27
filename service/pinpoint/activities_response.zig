const ActivityResponse = @import("activity_response.zig").ActivityResponse;

/// Provides information about the activities that were performed by a campaign.
pub const ActivitiesResponse = struct {
    /// An array of responses, one for each activity that was performed by the
    /// campaign.
    item: []const ActivityResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
