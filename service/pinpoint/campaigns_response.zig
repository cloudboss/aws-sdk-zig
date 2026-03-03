const CampaignResponse = @import("campaign_response.zig").CampaignResponse;

/// Provides information about the configuration and other settings for all the
/// campaigns that are associated with an application.
pub const CampaignsResponse = struct {
    /// An array of responses, one for each campaign that's associated with the
    /// application.
    item: []const CampaignResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
