const aws = @import("aws");
const std = @import("std");

const get_preferences = @import("get_preferences.zig");
const get_recommendation = @import("get_recommendation.zig");
const list_efficiency_metrics = @import("list_efficiency_metrics.zig");
const list_enrollment_statuses = @import("list_enrollment_statuses.zig");
const list_recommendation_summaries = @import("list_recommendation_summaries.zig");
const list_recommendations = @import("list_recommendations.zig");
const update_enrollment_status = @import("update_enrollment_status.zig");
const update_preferences = @import("update_preferences.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cost Optimization Hub";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Returns a set of preferences for an account in order to add account-specific
    /// preferences into the service. These preferences impact how the savings
    /// associated with recommendations are presented—estimated savings after
    /// discounts or estimated savings before discounts, for example.
    pub fn getPreferences(self: *Self, allocator: std.mem.Allocator, input: get_preferences.GetPreferencesInput, options: get_preferences.Options) !get_preferences.GetPreferencesOutput {
        return get_preferences.execute(self, allocator, input, options);
    }

    /// Returns both the current and recommended resource configuration and the
    /// estimated cost impact for a recommendation.
    ///
    /// The `recommendationId` is only valid for up to a maximum of 24 hours as
    /// recommendations are refreshed daily. To retrieve the `recommendationId`, use
    /// the `ListRecommendations` API.
    pub fn getRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_recommendation.GetRecommendationInput, options: get_recommendation.Options) !get_recommendation.GetRecommendationOutput {
        return get_recommendation.execute(self, allocator, input, options);
    }

    /// Returns cost efficiency metrics aggregated over time and optionally grouped
    /// by a specified dimension. The metrics provide insights into your cost
    /// optimization progress by tracking estimated savings, spending, and measures
    /// how effectively you're optimizing your Cloud resources.
    ///
    /// The operation supports both daily and monthly time granularities and allows
    /// grouping results by account ID, Amazon Web Services Region. Results are
    /// returned as time-series data, enabling you to analyze trends in your cost
    /// optimization performance over the specified time period.
    pub fn listEfficiencyMetrics(self: *Self, allocator: std.mem.Allocator, input: list_efficiency_metrics.ListEfficiencyMetricsInput, options: list_efficiency_metrics.Options) !list_efficiency_metrics.ListEfficiencyMetricsOutput {
        return list_efficiency_metrics.execute(self, allocator, input, options);
    }

    /// Retrieves the enrollment status for an account. It can also return the list
    /// of accounts that are enrolled under the organization.
    pub fn listEnrollmentStatuses(self: *Self, allocator: std.mem.Allocator, input: list_enrollment_statuses.ListEnrollmentStatusesInput, options: list_enrollment_statuses.Options) !list_enrollment_statuses.ListEnrollmentStatusesOutput {
        return list_enrollment_statuses.execute(self, allocator, input, options);
    }

    /// Returns a concise representation of savings estimates for resources. Also
    /// returns de-duped savings across different types of recommendations.
    ///
    /// The following filters are not supported for this API: `recommendationIds`,
    /// `resourceArns`, and `resourceIds`.
    pub fn listRecommendationSummaries(self: *Self, allocator: std.mem.Allocator, input: list_recommendation_summaries.ListRecommendationSummariesInput, options: list_recommendation_summaries.Options) !list_recommendation_summaries.ListRecommendationSummariesOutput {
        return list_recommendation_summaries.execute(self, allocator, input, options);
    }

    /// Returns a list of recommendations.
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: list_recommendations.Options) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// Updates the enrollment (opt in and opt out) status of an account to the Cost
    /// Optimization Hub service.
    ///
    /// If the account is a management account of an organization, this action can
    /// also be used to enroll member accounts of the organization.
    ///
    /// You must have the appropriate permissions to opt in to Cost Optimization Hub
    /// and to view its recommendations. When you opt in, Cost Optimization Hub
    /// automatically creates a service-linked role in your account to access its
    /// data.
    pub fn updateEnrollmentStatus(self: *Self, allocator: std.mem.Allocator, input: update_enrollment_status.UpdateEnrollmentStatusInput, options: update_enrollment_status.Options) !update_enrollment_status.UpdateEnrollmentStatusOutput {
        return update_enrollment_status.execute(self, allocator, input, options);
    }

    /// Updates a set of preferences for an account in order to add account-specific
    /// preferences into the service. These preferences impact how the savings
    /// associated with recommendations are presented.
    pub fn updatePreferences(self: *Self, allocator: std.mem.Allocator, input: update_preferences.UpdatePreferencesInput, options: update_preferences.Options) !update_preferences.UpdatePreferencesOutput {
        return update_preferences.execute(self, allocator, input, options);
    }

    pub fn listEfficiencyMetricsPaginator(self: *Self, params: list_efficiency_metrics.ListEfficiencyMetricsInput) paginator.ListEfficiencyMetricsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnrollmentStatusesPaginator(self: *Self, params: list_enrollment_statuses.ListEnrollmentStatusesInput) paginator.ListEnrollmentStatusesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecommendationSummariesPaginator(self: *Self, params: list_recommendation_summaries.ListRecommendationSummariesInput) paginator.ListRecommendationSummariesPaginator {
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
