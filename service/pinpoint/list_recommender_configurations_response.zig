const RecommenderConfigurationResponse = @import("recommender_configuration_response.zig").RecommenderConfigurationResponse;

/// Provides information about all the recommender model configurations that are
/// associated with your Amazon Pinpoint account.
pub const ListRecommenderConfigurationsResponse = struct {
    /// An array of responses, one for each recommender model configuration that's
    /// associated with your Amazon Pinpoint account.
    item: []const RecommenderConfigurationResponse,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .item = "Item",
        .next_token = "NextToken",
    };
};
