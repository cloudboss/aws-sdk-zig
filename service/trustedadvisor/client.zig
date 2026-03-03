const aws = @import("aws");
const std = @import("std");

const batch_update_recommendation_resource_exclusion = @import("batch_update_recommendation_resource_exclusion.zig");
const get_organization_recommendation = @import("get_organization_recommendation.zig");
const get_recommendation = @import("get_recommendation.zig");
const list_checks = @import("list_checks.zig");
const list_organization_recommendation_accounts = @import("list_organization_recommendation_accounts.zig");
const list_organization_recommendation_resources = @import("list_organization_recommendation_resources.zig");
const list_organization_recommendations = @import("list_organization_recommendations.zig");
const list_recommendation_resources = @import("list_recommendation_resources.zig");
const list_recommendations = @import("list_recommendations.zig");
const update_organization_recommendation_lifecycle = @import("update_organization_recommendation_lifecycle.zig");
const update_recommendation_lifecycle = @import("update_recommendation_lifecycle.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "TrustedAdvisor";

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

    /// Update one or more exclusion status for a list of recommendation resources
    pub fn batchUpdateRecommendationResourceExclusion(self: *Self, allocator: std.mem.Allocator, input: batch_update_recommendation_resource_exclusion.BatchUpdateRecommendationResourceExclusionInput, options: CallOptions) !batch_update_recommendation_resource_exclusion.BatchUpdateRecommendationResourceExclusionOutput {
        return batch_update_recommendation_resource_exclusion.execute(self, allocator, input, options);
    }

    /// Get a specific recommendation within an AWS Organizations organization. This
    /// API supports only prioritized
    /// recommendations.
    pub fn getOrganizationRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_organization_recommendation.GetOrganizationRecommendationInput, options: CallOptions) !get_organization_recommendation.GetOrganizationRecommendationOutput {
        return get_organization_recommendation.execute(self, allocator, input, options);
    }

    /// Get a specific Recommendation
    pub fn getRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_recommendation.GetRecommendationInput, options: CallOptions) !get_recommendation.GetRecommendationOutput {
        return get_recommendation.execute(self, allocator, input, options);
    }

    /// List a filterable set of Checks
    pub fn listChecks(self: *Self, allocator: std.mem.Allocator, input: list_checks.ListChecksInput, options: CallOptions) !list_checks.ListChecksOutput {
        return list_checks.execute(self, allocator, input, options);
    }

    /// Lists the accounts that own the resources for an organization aggregate
    /// recommendation. This API only
    /// supports prioritized recommendations.
    pub fn listOrganizationRecommendationAccounts(self: *Self, allocator: std.mem.Allocator, input: list_organization_recommendation_accounts.ListOrganizationRecommendationAccountsInput, options: CallOptions) !list_organization_recommendation_accounts.ListOrganizationRecommendationAccountsOutput {
        return list_organization_recommendation_accounts.execute(self, allocator, input, options);
    }

    /// List Resources of a Recommendation within an Organization. This API only
    /// supports prioritized
    /// recommendations.
    pub fn listOrganizationRecommendationResources(self: *Self, allocator: std.mem.Allocator, input: list_organization_recommendation_resources.ListOrganizationRecommendationResourcesInput, options: CallOptions) !list_organization_recommendation_resources.ListOrganizationRecommendationResourcesOutput {
        return list_organization_recommendation_resources.execute(self, allocator, input, options);
    }

    /// List a filterable set of Recommendations within an Organization. This API
    /// only supports prioritized
    /// recommendations.
    pub fn listOrganizationRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_organization_recommendations.ListOrganizationRecommendationsInput, options: CallOptions) !list_organization_recommendations.ListOrganizationRecommendationsOutput {
        return list_organization_recommendations.execute(self, allocator, input, options);
    }

    /// List Resources of a Recommendation
    pub fn listRecommendationResources(self: *Self, allocator: std.mem.Allocator, input: list_recommendation_resources.ListRecommendationResourcesInput, options: CallOptions) !list_recommendation_resources.ListRecommendationResourcesOutput {
        return list_recommendation_resources.execute(self, allocator, input, options);
    }

    /// List a filterable set of Recommendations
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: CallOptions) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// Update the lifecycle of a Recommendation within an Organization. This API
    /// only supports prioritized
    /// recommendations.
    pub fn updateOrganizationRecommendationLifecycle(self: *Self, allocator: std.mem.Allocator, input: update_organization_recommendation_lifecycle.UpdateOrganizationRecommendationLifecycleInput, options: CallOptions) !update_organization_recommendation_lifecycle.UpdateOrganizationRecommendationLifecycleOutput {
        return update_organization_recommendation_lifecycle.execute(self, allocator, input, options);
    }

    /// Update the lifecyle of a Recommendation. This API only supports prioritized
    /// recommendations.
    pub fn updateRecommendationLifecycle(self: *Self, allocator: std.mem.Allocator, input: update_recommendation_lifecycle.UpdateRecommendationLifecycleInput, options: CallOptions) !update_recommendation_lifecycle.UpdateRecommendationLifecycleOutput {
        return update_recommendation_lifecycle.execute(self, allocator, input, options);
    }

    pub fn listChecksPaginator(self: *Self, params: list_checks.ListChecksInput) paginator.ListChecksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationRecommendationAccountsPaginator(self: *Self, params: list_organization_recommendation_accounts.ListOrganizationRecommendationAccountsInput) paginator.ListOrganizationRecommendationAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationRecommendationResourcesPaginator(self: *Self, params: list_organization_recommendation_resources.ListOrganizationRecommendationResourcesInput) paginator.ListOrganizationRecommendationResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationRecommendationsPaginator(self: *Self, params: list_organization_recommendations.ListOrganizationRecommendationsInput) paginator.ListOrganizationRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationResourcesPaginator(self: *Self, params: list_recommendation_resources.ListRecommendationResourcesInput) paginator.ListRecommendationResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationsPaginator(self: *Self, params: list_recommendations.ListRecommendationsInput) paginator.ListRecommendationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
