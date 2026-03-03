const aws = @import("aws");
const std = @import("std");

const get_action_recommendations = @import("get_action_recommendations.zig");
const get_personalized_ranking = @import("get_personalized_ranking.zig");
const get_recommendations = @import("get_recommendations.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Personalize Runtime";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns a list of recommended actions in sorted in descending order by
    /// prediction score.
    /// Use the `GetActionRecommendations` API if you have a custom
    /// campaign that deploys a solution version trained with a PERSONALIZED_ACTIONS
    /// recipe.
    ///
    /// For more information about PERSONALIZED_ACTIONS recipes, see
    /// [PERSONALIZED_ACTIONS
    /// recipes](https://docs.aws.amazon.com/personalize/latest/dg/nexts-best-action-recipes.html).
    /// For more information about getting action recommendations, see [Getting
    /// action
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/get-action-recommendations.html).
    pub fn getActionRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_action_recommendations.GetActionRecommendationsInput, options: get_action_recommendations.Options) !get_action_recommendations.GetActionRecommendationsOutput {
        return get_action_recommendations.execute(self, allocator, input, options);
    }

    /// Re-ranks a list of recommended items for the given user. The first item in
    /// the list is
    /// deemed the most likely item to be of interest to the user.
    ///
    /// The solution backing the campaign must have been created using a recipe of
    /// type
    /// PERSONALIZED_RANKING.
    pub fn getPersonalizedRanking(self: *Self, allocator: std.mem.Allocator, input: get_personalized_ranking.GetPersonalizedRankingInput, options: get_personalized_ranking.Options) !get_personalized_ranking.GetPersonalizedRankingOutput {
        return get_personalized_ranking.execute(self, allocator, input, options);
    }

    /// Returns a list of recommended items. For campaigns, the campaign's Amazon
    /// Resource Name (ARN) is required and the required user and item input depends
    /// on the recipe type used to
    /// create the solution backing the campaign as follows:
    ///
    /// * USER_PERSONALIZATION - `userId` required, `itemId` not used
    ///
    /// * RELATED_ITEMS - `itemId` required, `userId` not used
    ///
    /// Campaigns that are backed by a solution created using a recipe of type
    /// PERSONALIZED_RANKING use the API.
    ///
    /// For recommenders, the recommender's ARN is required and the required item
    /// and user input depends on the use case (domain-based recipe) backing the
    /// recommender.
    /// For information on use case requirements see [Choosing recommender use
    /// cases](https://docs.aws.amazon.com/personalize/latest/dg/domain-use-cases.html).
    pub fn getRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_recommendations.GetRecommendationsInput, options: get_recommendations.Options) !get_recommendations.GetRecommendationsOutput {
        return get_recommendations.execute(self, allocator, input, options);
    }
};
