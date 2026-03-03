const aws = @import("aws");
const std = @import("std");

const list_recommended_actions = @import("list_recommended_actions.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "BCM Recommended Actions";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns a list of recommended actions that match the filter criteria.
    pub fn listRecommendedActions(self: *Self, allocator: std.mem.Allocator, input: list_recommended_actions.ListRecommendedActionsInput, options: list_recommended_actions.Options) !list_recommended_actions.ListRecommendedActionsOutput {
        return list_recommended_actions.execute(self, allocator, input, options);
    }

    pub fn listRecommendedActionsPaginator(self: *Self, params: list_recommended_actions.ListRecommendedActionsInput) paginator.ListRecommendedActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
