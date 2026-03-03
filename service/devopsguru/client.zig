const aws = @import("aws");
const std = @import("std");

const add_notification_channel = @import("add_notification_channel.zig");
const delete_insight = @import("delete_insight.zig");
const describe_account_health = @import("describe_account_health.zig");
const describe_account_overview = @import("describe_account_overview.zig");
const describe_anomaly = @import("describe_anomaly.zig");
const describe_event_sources_config = @import("describe_event_sources_config.zig");
const describe_feedback = @import("describe_feedback.zig");
const describe_insight = @import("describe_insight.zig");
const describe_organization_health = @import("describe_organization_health.zig");
const describe_organization_overview = @import("describe_organization_overview.zig");
const describe_organization_resource_collection_health = @import("describe_organization_resource_collection_health.zig");
const describe_resource_collection_health = @import("describe_resource_collection_health.zig");
const describe_service_integration = @import("describe_service_integration.zig");
const get_cost_estimation = @import("get_cost_estimation.zig");
const get_resource_collection = @import("get_resource_collection.zig");
const list_anomalies_for_insight = @import("list_anomalies_for_insight.zig");
const list_anomalous_log_groups = @import("list_anomalous_log_groups.zig");
const list_events = @import("list_events.zig");
const list_insights = @import("list_insights.zig");
const list_monitored_resources = @import("list_monitored_resources.zig");
const list_notification_channels = @import("list_notification_channels.zig");
const list_organization_insights = @import("list_organization_insights.zig");
const list_recommendations = @import("list_recommendations.zig");
const put_feedback = @import("put_feedback.zig");
const remove_notification_channel = @import("remove_notification_channel.zig");
const search_insights = @import("search_insights.zig");
const search_organization_insights = @import("search_organization_insights.zig");
const start_cost_estimation = @import("start_cost_estimation.zig");
const update_event_sources_config = @import("update_event_sources_config.zig");
const update_resource_collection = @import("update_resource_collection.zig");
const update_service_integration = @import("update_service_integration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DevOps Guru";

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

    /// Adds a notification channel to DevOps Guru. A notification channel is used
    /// to notify you
    /// about important DevOps Guru events, such as when an insight is generated.
    ///
    /// If you use an Amazon SNS topic in another account, you must attach a policy
    /// to it that grants DevOps Guru permission
    /// to send it notifications. DevOps Guru adds the required policy on your
    /// behalf to send notifications using Amazon SNS in your account. DevOps Guru
    /// only supports standard SNS topics.
    /// For more information, see [Permissions
    /// for Amazon SNS
    /// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-required-permissions.html).
    ///
    /// If you use an Amazon SNS topic that is encrypted by an Amazon Web Services
    /// Key Management Service customer-managed key (CMK), then you must add
    /// permissions
    /// to the CMK. For more information, see [Permissions for
    /// Amazon Web Services KMS–encrypted Amazon SNS
    /// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-kms-permissions.html).
    pub fn addNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: add_notification_channel.AddNotificationChannelInput, options: CallOptions) !add_notification_channel.AddNotificationChannelOutput {
        return add_notification_channel.execute(self, allocator, input, options);
    }

    /// Deletes the insight along with the associated anomalies, events and
    /// recommendations.
    pub fn deleteInsight(self: *Self, allocator: std.mem.Allocator, input: delete_insight.DeleteInsightInput, options: CallOptions) !delete_insight.DeleteInsightOutput {
        return delete_insight.execute(self, allocator, input, options);
    }

    /// Returns the number of open reactive insights, the number of open proactive
    /// insights,
    /// and the number of metrics analyzed in your Amazon Web Services account. Use
    /// these numbers to gauge the
    /// health of operations in your Amazon Web Services account.
    pub fn describeAccountHealth(self: *Self, allocator: std.mem.Allocator, input: describe_account_health.DescribeAccountHealthInput, options: CallOptions) !describe_account_health.DescribeAccountHealthOutput {
        return describe_account_health.execute(self, allocator, input, options);
    }

    /// For the time range passed in, returns the number of open reactive insight
    /// that were
    /// created, the number of open proactive insights that were created, and the
    /// Mean Time to Recover (MTTR) for all
    /// closed reactive insights.
    pub fn describeAccountOverview(self: *Self, allocator: std.mem.Allocator, input: describe_account_overview.DescribeAccountOverviewInput, options: CallOptions) !describe_account_overview.DescribeAccountOverviewOutput {
        return describe_account_overview.execute(self, allocator, input, options);
    }

    /// Returns details about an anomaly that you specify using its ID.
    pub fn describeAnomaly(self: *Self, allocator: std.mem.Allocator, input: describe_anomaly.DescribeAnomalyInput, options: CallOptions) !describe_anomaly.DescribeAnomalyOutput {
        return describe_anomaly.execute(self, allocator, input, options);
    }

    /// Returns the integration status of services that are integrated with DevOps
    /// Guru as Consumer
    /// via EventBridge. The one service that can be integrated with DevOps Guru is
    /// Amazon CodeGuru
    /// Profiler, which can produce proactive recommendations which can be stored
    /// and viewed in
    /// DevOps Guru.
    pub fn describeEventSourcesConfig(self: *Self, allocator: std.mem.Allocator, input: describe_event_sources_config.DescribeEventSourcesConfigInput, options: CallOptions) !describe_event_sources_config.DescribeEventSourcesConfigOutput {
        return describe_event_sources_config.execute(self, allocator, input, options);
    }

    /// Returns the most recent feedback submitted in the current Amazon Web
    /// Services account and Region.
    pub fn describeFeedback(self: *Self, allocator: std.mem.Allocator, input: describe_feedback.DescribeFeedbackInput, options: CallOptions) !describe_feedback.DescribeFeedbackOutput {
        return describe_feedback.execute(self, allocator, input, options);
    }

    /// Returns details about an insight that you specify using its ID.
    pub fn describeInsight(self: *Self, allocator: std.mem.Allocator, input: describe_insight.DescribeInsightInput, options: CallOptions) !describe_insight.DescribeInsightOutput {
        return describe_insight.execute(self, allocator, input, options);
    }

    /// Returns active insights, predictive insights, and resource hours analyzed in
    /// last
    /// hour.
    pub fn describeOrganizationHealth(self: *Self, allocator: std.mem.Allocator, input: describe_organization_health.DescribeOrganizationHealthInput, options: CallOptions) !describe_organization_health.DescribeOrganizationHealthOutput {
        return describe_organization_health.execute(self, allocator, input, options);
    }

    /// Returns an overview of your organization's history based on the specified
    /// time range.
    /// The overview includes the total reactive and proactive insights.
    pub fn describeOrganizationOverview(self: *Self, allocator: std.mem.Allocator, input: describe_organization_overview.DescribeOrganizationOverviewInput, options: CallOptions) !describe_organization_overview.DescribeOrganizationOverviewOutput {
        return describe_organization_overview.execute(self, allocator, input, options);
    }

    /// Provides an overview of your system's health. If additional member accounts
    /// are part
    /// of your organization, you can filter those accounts using the `AccountIds`
    /// field.
    pub fn describeOrganizationResourceCollectionHealth(self: *Self, allocator: std.mem.Allocator, input: describe_organization_resource_collection_health.DescribeOrganizationResourceCollectionHealthInput, options: CallOptions) !describe_organization_resource_collection_health.DescribeOrganizationResourceCollectionHealthOutput {
        return describe_organization_resource_collection_health.execute(self, allocator, input, options);
    }

    /// Returns the number of open proactive insights, open reactive insights, and
    /// the Mean Time to Recover (MTTR)
    /// for all closed insights in resource collections in your account. You specify
    /// the type of
    /// Amazon Web Services resources collection. The two types of Amazon Web
    /// Services resource collections supported are Amazon Web Services
    /// CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks.
    pub fn describeResourceCollectionHealth(self: *Self, allocator: std.mem.Allocator, input: describe_resource_collection_health.DescribeResourceCollectionHealthInput, options: CallOptions) !describe_resource_collection_health.DescribeResourceCollectionHealthOutput {
        return describe_resource_collection_health.execute(self, allocator, input, options);
    }

    /// Returns the integration status of services that are integrated with DevOps
    /// Guru.
    /// The one service that can be integrated with DevOps Guru
    /// is Amazon Web Services Systems Manager, which can be used to create an
    /// OpsItem for each generated insight.
    pub fn describeServiceIntegration(self: *Self, allocator: std.mem.Allocator, input: describe_service_integration.DescribeServiceIntegrationInput, options: CallOptions) !describe_service_integration.DescribeServiceIntegrationOutput {
        return describe_service_integration.execute(self, allocator, input, options);
    }

    /// Returns an estimate of the monthly cost for DevOps Guru to analyze your
    /// Amazon Web Services resources.
    /// For more information,
    /// see [Estimate your
    /// Amazon DevOps Guru
    /// costs](https://docs.aws.amazon.com/devops-guru/latest/userguide/cost-estimate.html) and
    /// [Amazon DevOps Guru pricing](http://aws.amazon.com/devops-guru/pricing/).
    pub fn getCostEstimation(self: *Self, allocator: std.mem.Allocator, input: get_cost_estimation.GetCostEstimationInput, options: CallOptions) !get_cost_estimation.GetCostEstimationOutput {
        return get_cost_estimation.execute(self, allocator, input, options);
    }

    /// Returns lists Amazon Web Services resources that are of the specified
    /// resource collection type.
    /// The two types of Amazon Web Services resource collections supported are
    /// Amazon Web Services CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks.
    pub fn getResourceCollection(self: *Self, allocator: std.mem.Allocator, input: get_resource_collection.GetResourceCollectionInput, options: CallOptions) !get_resource_collection.GetResourceCollectionOutput {
        return get_resource_collection.execute(self, allocator, input, options);
    }

    /// Returns a list of the anomalies that belong to an insight that you specify
    /// using its
    /// ID.
    pub fn listAnomaliesForInsight(self: *Self, allocator: std.mem.Allocator, input: list_anomalies_for_insight.ListAnomaliesForInsightInput, options: CallOptions) !list_anomalies_for_insight.ListAnomaliesForInsightOutput {
        return list_anomalies_for_insight.execute(self, allocator, input, options);
    }

    /// Returns the list of log groups that contain log anomalies.
    pub fn listAnomalousLogGroups(self: *Self, allocator: std.mem.Allocator, input: list_anomalous_log_groups.ListAnomalousLogGroupsInput, options: CallOptions) !list_anomalous_log_groups.ListAnomalousLogGroupsOutput {
        return list_anomalous_log_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of the events emitted by the resources that are evaluated by
    /// DevOps Guru.
    /// You can use filters to specify which events are returned.
    pub fn listEvents(self: *Self, allocator: std.mem.Allocator, input: list_events.ListEventsInput, options: CallOptions) !list_events.ListEventsOutput {
        return list_events.execute(self, allocator, input, options);
    }

    /// Returns a list of insights in your Amazon Web Services account. You can
    /// specify which insights are
    /// returned by their start time and status (`ONGOING`, `CLOSED`, or
    /// `ANY`).
    pub fn listInsights(self: *Self, allocator: std.mem.Allocator, input: list_insights.ListInsightsInput, options: CallOptions) !list_insights.ListInsightsOutput {
        return list_insights.execute(self, allocator, input, options);
    }

    /// Returns the list of all log groups that are being monitored and tagged by
    /// DevOps Guru.
    pub fn listMonitoredResources(self: *Self, allocator: std.mem.Allocator, input: list_monitored_resources.ListMonitoredResourcesInput, options: CallOptions) !list_monitored_resources.ListMonitoredResourcesOutput {
        return list_monitored_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of notification channels configured for DevOps Guru. Each
    /// notification
    /// channel is used to notify you when DevOps Guru generates an insight that
    /// contains information
    /// about how to improve your operations. The one
    /// supported notification channel is Amazon Simple Notification Service (Amazon
    /// SNS).
    pub fn listNotificationChannels(self: *Self, allocator: std.mem.Allocator, input: list_notification_channels.ListNotificationChannelsInput, options: CallOptions) !list_notification_channels.ListNotificationChannelsOutput {
        return list_notification_channels.execute(self, allocator, input, options);
    }

    /// Returns a list of insights associated with the account or OU Id.
    pub fn listOrganizationInsights(self: *Self, allocator: std.mem.Allocator, input: list_organization_insights.ListOrganizationInsightsInput, options: CallOptions) !list_organization_insights.ListOrganizationInsightsOutput {
        return list_organization_insights.execute(self, allocator, input, options);
    }

    /// Returns a list of a specified insight's recommendations. Each recommendation
    /// includes
    /// a list of related metrics and a list of related events.
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: CallOptions) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// Collects customer feedback about the specified insight.
    pub fn putFeedback(self: *Self, allocator: std.mem.Allocator, input: put_feedback.PutFeedbackInput, options: CallOptions) !put_feedback.PutFeedbackOutput {
        return put_feedback.execute(self, allocator, input, options);
    }

    /// Removes a notification channel from DevOps Guru. A notification channel is
    /// used to notify
    /// you when DevOps Guru generates an insight that contains information about
    /// how to improve your
    /// operations.
    pub fn removeNotificationChannel(self: *Self, allocator: std.mem.Allocator, input: remove_notification_channel.RemoveNotificationChannelInput, options: CallOptions) !remove_notification_channel.RemoveNotificationChannelOutput {
        return remove_notification_channel.execute(self, allocator, input, options);
    }

    /// Returns a list of insights in your Amazon Web Services account. You can
    /// specify which insights are
    /// returned by their start time, one or more statuses (`ONGOING` or `CLOSED`),
    /// one or more severities
    /// (`LOW`, `MEDIUM`, and `HIGH`), and type
    /// (`REACTIVE` or `PROACTIVE`).
    ///
    /// Use the `Filters` parameter to specify status and severity search
    /// parameters. Use the `Type` parameter to specify `REACTIVE` or
    /// `PROACTIVE` in your search.
    pub fn searchInsights(self: *Self, allocator: std.mem.Allocator, input: search_insights.SearchInsightsInput, options: CallOptions) !search_insights.SearchInsightsOutput {
        return search_insights.execute(self, allocator, input, options);
    }

    /// Returns a list of insights in your organization. You can specify which
    /// insights are
    /// returned by their start time, one or more statuses (`ONGOING`,
    /// `CLOSED`, and `CLOSED`), one or more severities
    /// (`LOW`, `MEDIUM`, and `HIGH`), and type
    /// (`REACTIVE` or `PROACTIVE`).
    ///
    /// Use the `Filters` parameter to specify status and severity search
    /// parameters. Use the `Type` parameter to specify `REACTIVE` or
    /// `PROACTIVE` in your search.
    pub fn searchOrganizationInsights(self: *Self, allocator: std.mem.Allocator, input: search_organization_insights.SearchOrganizationInsightsInput, options: CallOptions) !search_organization_insights.SearchOrganizationInsightsOutput {
        return search_organization_insights.execute(self, allocator, input, options);
    }

    /// Starts the creation of an estimate of the monthly cost to analyze your
    /// Amazon Web Services
    /// resources.
    pub fn startCostEstimation(self: *Self, allocator: std.mem.Allocator, input: start_cost_estimation.StartCostEstimationInput, options: CallOptions) !start_cost_estimation.StartCostEstimationOutput {
        return start_cost_estimation.execute(self, allocator, input, options);
    }

    /// Enables or disables integration with a service that can be integrated with
    /// DevOps Guru. The
    /// one service that can be integrated with DevOps Guru is Amazon CodeGuru
    /// Profiler, which
    /// can produce proactive recommendations which can be stored and viewed in
    /// DevOps Guru.
    pub fn updateEventSourcesConfig(self: *Self, allocator: std.mem.Allocator, input: update_event_sources_config.UpdateEventSourcesConfigInput, options: CallOptions) !update_event_sources_config.UpdateEventSourcesConfigOutput {
        return update_event_sources_config.execute(self, allocator, input, options);
    }

    /// Updates the collection of resources that DevOps Guru analyzes.
    /// The two types of Amazon Web Services resource collections supported are
    /// Amazon Web Services CloudFormation stacks and
    /// Amazon Web Services resources that contain the same Amazon Web Services tag.
    /// DevOps Guru can be configured to analyze
    /// the Amazon Web Services resources that are defined in the stacks or that are
    /// tagged using the same tag *key*. You can specify up to 500 Amazon Web
    /// Services CloudFormation stacks. This method also creates the IAM role
    /// required for
    /// you to use DevOps Guru.
    pub fn updateResourceCollection(self: *Self, allocator: std.mem.Allocator, input: update_resource_collection.UpdateResourceCollectionInput, options: CallOptions) !update_resource_collection.UpdateResourceCollectionOutput {
        return update_resource_collection.execute(self, allocator, input, options);
    }

    /// Enables or disables integration with a service that can be integrated with
    /// DevOps Guru. The
    /// one service that can be integrated with DevOps Guru is Amazon Web Services
    /// Systems Manager, which can be used to create
    /// an OpsItem for each generated insight.
    pub fn updateServiceIntegration(self: *Self, allocator: std.mem.Allocator, input: update_service_integration.UpdateServiceIntegrationInput, options: CallOptions) !update_service_integration.UpdateServiceIntegrationOutput {
        return update_service_integration.execute(self, allocator, input, options);
    }

    pub fn describeOrganizationResourceCollectionHealthPaginator(self: *Self, params: describe_organization_resource_collection_health.DescribeOrganizationResourceCollectionHealthInput) paginator.DescribeOrganizationResourceCollectionHealthPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeResourceCollectionHealthPaginator(self: *Self, params: describe_resource_collection_health.DescribeResourceCollectionHealthInput) paginator.DescribeResourceCollectionHealthPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCostEstimationPaginator(self: *Self, params: get_cost_estimation.GetCostEstimationInput) paginator.GetCostEstimationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourceCollectionPaginator(self: *Self, params: get_resource_collection.GetResourceCollectionInput) paginator.GetResourceCollectionPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnomaliesForInsightPaginator(self: *Self, params: list_anomalies_for_insight.ListAnomaliesForInsightInput) paginator.ListAnomaliesForInsightPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnomalousLogGroupsPaginator(self: *Self, params: list_anomalous_log_groups.ListAnomalousLogGroupsInput) paginator.ListAnomalousLogGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventsPaginator(self: *Self, params: list_events.ListEventsInput) paginator.ListEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInsightsPaginator(self: *Self, params: list_insights.ListInsightsInput) paginator.ListInsightsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitoredResourcesPaginator(self: *Self, params: list_monitored_resources.ListMonitoredResourcesInput) paginator.ListMonitoredResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationChannelsPaginator(self: *Self, params: list_notification_channels.ListNotificationChannelsInput) paginator.ListNotificationChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationInsightsPaginator(self: *Self, params: list_organization_insights.ListOrganizationInsightsInput) paginator.ListOrganizationInsightsPaginator {
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

    pub fn searchInsightsPaginator(self: *Self, params: search_insights.SearchInsightsInput) paginator.SearchInsightsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchOrganizationInsightsPaginator(self: *Self, params: search_organization_insights.SearchOrganizationInsightsInput) paginator.SearchOrganizationInsightsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
