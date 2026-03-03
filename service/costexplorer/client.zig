const aws = @import("aws");
const std = @import("std");

const create_anomaly_monitor = @import("create_anomaly_monitor.zig");
const create_anomaly_subscription = @import("create_anomaly_subscription.zig");
const create_cost_category_definition = @import("create_cost_category_definition.zig");
const delete_anomaly_monitor = @import("delete_anomaly_monitor.zig");
const delete_anomaly_subscription = @import("delete_anomaly_subscription.zig");
const delete_cost_category_definition = @import("delete_cost_category_definition.zig");
const describe_cost_category_definition = @import("describe_cost_category_definition.zig");
const get_anomalies = @import("get_anomalies.zig");
const get_anomaly_monitors = @import("get_anomaly_monitors.zig");
const get_anomaly_subscriptions = @import("get_anomaly_subscriptions.zig");
const get_approximate_usage_records = @import("get_approximate_usage_records.zig");
const get_commitment_purchase_analysis = @import("get_commitment_purchase_analysis.zig");
const get_cost_and_usage = @import("get_cost_and_usage.zig");
const get_cost_and_usage_comparisons = @import("get_cost_and_usage_comparisons.zig");
const get_cost_and_usage_with_resources = @import("get_cost_and_usage_with_resources.zig");
const get_cost_categories = @import("get_cost_categories.zig");
const get_cost_comparison_drivers = @import("get_cost_comparison_drivers.zig");
const get_cost_forecast = @import("get_cost_forecast.zig");
const get_dimension_values = @import("get_dimension_values.zig");
const get_reservation_coverage = @import("get_reservation_coverage.zig");
const get_reservation_purchase_recommendation = @import("get_reservation_purchase_recommendation.zig");
const get_reservation_utilization = @import("get_reservation_utilization.zig");
const get_rightsizing_recommendation = @import("get_rightsizing_recommendation.zig");
const get_savings_plan_purchase_recommendation_details = @import("get_savings_plan_purchase_recommendation_details.zig");
const get_savings_plans_coverage = @import("get_savings_plans_coverage.zig");
const get_savings_plans_purchase_recommendation = @import("get_savings_plans_purchase_recommendation.zig");
const get_savings_plans_utilization = @import("get_savings_plans_utilization.zig");
const get_savings_plans_utilization_details = @import("get_savings_plans_utilization_details.zig");
const get_tags = @import("get_tags.zig");
const get_usage_forecast = @import("get_usage_forecast.zig");
const list_commitment_purchase_analyses = @import("list_commitment_purchase_analyses.zig");
const list_cost_allocation_tag_backfill_history = @import("list_cost_allocation_tag_backfill_history.zig");
const list_cost_allocation_tags = @import("list_cost_allocation_tags.zig");
const list_cost_category_definitions = @import("list_cost_category_definitions.zig");
const list_cost_category_resource_associations = @import("list_cost_category_resource_associations.zig");
const list_savings_plans_purchase_recommendation_generation = @import("list_savings_plans_purchase_recommendation_generation.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const provide_anomaly_feedback = @import("provide_anomaly_feedback.zig");
const start_commitment_purchase_analysis = @import("start_commitment_purchase_analysis.zig");
const start_cost_allocation_tag_backfill = @import("start_cost_allocation_tag_backfill.zig");
const start_savings_plans_purchase_recommendation_generation = @import("start_savings_plans_purchase_recommendation_generation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_anomaly_monitor = @import("update_anomaly_monitor.zig");
const update_anomaly_subscription = @import("update_anomaly_subscription.zig");
const update_cost_allocation_tags_status = @import("update_cost_allocation_tags_status.zig");
const update_cost_category_definition = @import("update_cost_category_definition.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Cost Explorer";

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

    /// Creates a new cost anomaly detection monitor with the requested type and
    /// monitor
    /// specification.
    pub fn createAnomalyMonitor(self: *Self, allocator: std.mem.Allocator, input: create_anomaly_monitor.CreateAnomalyMonitorInput, options: create_anomaly_monitor.Options) !create_anomaly_monitor.CreateAnomalyMonitorOutput {
        return create_anomaly_monitor.execute(self, allocator, input, options);
    }

    /// Adds an alert subscription to a cost anomaly detection monitor. You can use
    /// each
    /// subscription to define subscribers with email or SNS notifications. Email
    /// subscribers can set
    /// an absolute or percentage threshold and a time frequency for receiving
    /// notifications.
    pub fn createAnomalySubscription(self: *Self, allocator: std.mem.Allocator, input: create_anomaly_subscription.CreateAnomalySubscriptionInput, options: create_anomaly_subscription.Options) !create_anomaly_subscription.CreateAnomalySubscriptionOutput {
        return create_anomaly_subscription.execute(self, allocator, input, options);
    }

    /// Creates a new cost category with the requested name and rules.
    pub fn createCostCategoryDefinition(self: *Self, allocator: std.mem.Allocator, input: create_cost_category_definition.CreateCostCategoryDefinitionInput, options: create_cost_category_definition.Options) !create_cost_category_definition.CreateCostCategoryDefinitionOutput {
        return create_cost_category_definition.execute(self, allocator, input, options);
    }

    /// Deletes a cost anomaly monitor.
    pub fn deleteAnomalyMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_anomaly_monitor.DeleteAnomalyMonitorInput, options: delete_anomaly_monitor.Options) !delete_anomaly_monitor.DeleteAnomalyMonitorOutput {
        return delete_anomaly_monitor.execute(self, allocator, input, options);
    }

    /// Deletes a cost anomaly subscription.
    pub fn deleteAnomalySubscription(self: *Self, allocator: std.mem.Allocator, input: delete_anomaly_subscription.DeleteAnomalySubscriptionInput, options: delete_anomaly_subscription.Options) !delete_anomaly_subscription.DeleteAnomalySubscriptionOutput {
        return delete_anomaly_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a cost category. Expenses from this month going forward will no
    /// longer be
    /// categorized with this cost category.
    pub fn deleteCostCategoryDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_cost_category_definition.DeleteCostCategoryDefinitionInput, options: delete_cost_category_definition.Options) !delete_cost_category_definition.DeleteCostCategoryDefinitionOutput {
        return delete_cost_category_definition.execute(self, allocator, input, options);
    }

    /// Returns the name, Amazon Resource Name (ARN), rules, definition, and
    /// effective dates of a
    /// cost category that's defined in the account.
    ///
    /// You have the option to use `EffectiveOn` to return a cost category that's
    /// active on a specific date. If there's no `EffectiveOn` specified, you see a
    /// Cost
    /// Category that's effective on the current date. If cost category is still
    /// effective,
    /// `EffectiveEnd` is omitted in the response.
    pub fn describeCostCategoryDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_cost_category_definition.DescribeCostCategoryDefinitionInput, options: describe_cost_category_definition.Options) !describe_cost_category_definition.DescribeCostCategoryDefinitionOutput {
        return describe_cost_category_definition.execute(self, allocator, input, options);
    }

    /// Retrieves all of the cost anomalies detected on your account during the time
    /// period that's
    /// specified by the `DateInterval` object. Anomalies are available for up to 90
    /// days.
    pub fn getAnomalies(self: *Self, allocator: std.mem.Allocator, input: get_anomalies.GetAnomaliesInput, options: get_anomalies.Options) !get_anomalies.GetAnomaliesOutput {
        return get_anomalies.execute(self, allocator, input, options);
    }

    /// Retrieves the cost anomaly monitor definitions for your account. You can
    /// filter using a
    /// list of cost anomaly monitor Amazon Resource Names (ARNs).
    pub fn getAnomalyMonitors(self: *Self, allocator: std.mem.Allocator, input: get_anomaly_monitors.GetAnomalyMonitorsInput, options: get_anomaly_monitors.Options) !get_anomaly_monitors.GetAnomalyMonitorsOutput {
        return get_anomaly_monitors.execute(self, allocator, input, options);
    }

    /// Retrieves the cost anomaly subscription objects for your account. You can
    /// filter using a
    /// list of cost anomaly monitor Amazon Resource Names (ARNs).
    pub fn getAnomalySubscriptions(self: *Self, allocator: std.mem.Allocator, input: get_anomaly_subscriptions.GetAnomalySubscriptionsInput, options: get_anomaly_subscriptions.Options) !get_anomaly_subscriptions.GetAnomalySubscriptionsOutput {
        return get_anomaly_subscriptions.execute(self, allocator, input, options);
    }

    /// Retrieves estimated usage records for hourly granularity or resource-level
    /// data at daily
    /// granularity.
    pub fn getApproximateUsageRecords(self: *Self, allocator: std.mem.Allocator, input: get_approximate_usage_records.GetApproximateUsageRecordsInput, options: get_approximate_usage_records.Options) !get_approximate_usage_records.GetApproximateUsageRecordsOutput {
        return get_approximate_usage_records.execute(self, allocator, input, options);
    }

    /// Retrieves a commitment purchase analysis result based on the
    /// `AnalysisId`.
    pub fn getCommitmentPurchaseAnalysis(self: *Self, allocator: std.mem.Allocator, input: get_commitment_purchase_analysis.GetCommitmentPurchaseAnalysisInput, options: get_commitment_purchase_analysis.Options) !get_commitment_purchase_analysis.GetCommitmentPurchaseAnalysisOutput {
        return get_commitment_purchase_analysis.execute(self, allocator, input, options);
    }

    /// Retrieves cost and usage metrics for your account. You can specify which
    /// cost and
    /// usage-related metric that you want the request to return. For example, you
    /// can specify
    /// `BlendedCosts` or `UsageQuantity`. You can also filter and group your
    /// data by various dimensions, such as `SERVICE` or `AZ`, in a specific
    /// time range. For a complete list of valid dimensions, see the
    /// [GetDimensionValues](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_GetDimensionValues.html) operation. Management account in an organization in Organizations have access to all member accounts.
    ///
    /// For information about filter limitations, see [Quotas and
    /// restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-limits.html)
    /// in the *Billing and Cost Management User Guide*.
    pub fn getCostAndUsage(self: *Self, allocator: std.mem.Allocator, input: get_cost_and_usage.GetCostAndUsageInput, options: get_cost_and_usage.Options) !get_cost_and_usage.GetCostAndUsageOutput {
        return get_cost_and_usage.execute(self, allocator, input, options);
    }

    /// Retrieves cost and usage comparisons for your account between two periods
    /// within the last
    /// 13 months. If you have enabled multi-year data at monthly granularity, you
    /// can go back up to
    /// 38 months.
    pub fn getCostAndUsageComparisons(self: *Self, allocator: std.mem.Allocator, input: get_cost_and_usage_comparisons.GetCostAndUsageComparisonsInput, options: get_cost_and_usage_comparisons.Options) !get_cost_and_usage_comparisons.GetCostAndUsageComparisonsOutput {
        return get_cost_and_usage_comparisons.execute(self, allocator, input, options);
    }

    /// Retrieves cost and usage metrics with resources for your account. You can
    /// specify which
    /// cost and usage-related metric, such as `BlendedCosts` or
    /// `UsageQuantity`, that you want the request to return. You can also filter
    /// and group
    /// your data by various dimensions, such as `SERVICE` or `AZ`, in a
    /// specific time range. For a complete list of valid dimensions, see the
    /// [GetDimensionValues](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_GetDimensionValues.html) operation. Management account in an organization in Organizations have access to all member accounts.
    ///
    /// Hourly granularity is only available for EC2-Instances (Elastic Compute
    /// Cloud)
    /// resource-level data. All other resource-level data is available at daily
    /// granularity.
    ///
    /// This is an opt-in only feature. You can enable this feature from the Cost
    /// Explorer
    /// Settings page. For information about how to access the Settings page, see
    /// [Controlling
    /// Access for Cost
    /// Explorer](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/ce-access.html) in the *Billing and Cost Management User
    /// Guide*.
    pub fn getCostAndUsageWithResources(self: *Self, allocator: std.mem.Allocator, input: get_cost_and_usage_with_resources.GetCostAndUsageWithResourcesInput, options: get_cost_and_usage_with_resources.Options) !get_cost_and_usage_with_resources.GetCostAndUsageWithResourcesOutput {
        return get_cost_and_usage_with_resources.execute(self, allocator, input, options);
    }

    /// Retrieves an array of cost category names and values incurred cost.
    ///
    /// If some cost category names and values are not associated with any cost,
    /// they will not
    /// be returned by this API.
    pub fn getCostCategories(self: *Self, allocator: std.mem.Allocator, input: get_cost_categories.GetCostCategoriesInput, options: get_cost_categories.Options) !get_cost_categories.GetCostCategoriesOutput {
        return get_cost_categories.execute(self, allocator, input, options);
    }

    /// Retrieves key factors driving cost changes between two time periods within
    /// the last 13
    /// months, such as usage changes, discount changes, and commitment-based
    /// savings. If you have
    /// enabled multi-year data at monthly granularity, you can go back up to 38
    /// months.
    pub fn getCostComparisonDrivers(self: *Self, allocator: std.mem.Allocator, input: get_cost_comparison_drivers.GetCostComparisonDriversInput, options: get_cost_comparison_drivers.Options) !get_cost_comparison_drivers.GetCostComparisonDriversOutput {
        return get_cost_comparison_drivers.execute(self, allocator, input, options);
    }

    /// Retrieves a forecast for how much Amazon Web Services predicts that you will
    /// spend over
    /// the forecast time period that you select, based on your past costs.
    pub fn getCostForecast(self: *Self, allocator: std.mem.Allocator, input: get_cost_forecast.GetCostForecastInput, options: get_cost_forecast.Options) !get_cost_forecast.GetCostForecastOutput {
        return get_cost_forecast.execute(self, allocator, input, options);
    }

    /// Retrieves all available filter values for a specified filter over a period
    /// of time. You
    /// can search the dimension values for an arbitrary string.
    pub fn getDimensionValues(self: *Self, allocator: std.mem.Allocator, input: get_dimension_values.GetDimensionValuesInput, options: get_dimension_values.Options) !get_dimension_values.GetDimensionValuesOutput {
        return get_dimension_values.execute(self, allocator, input, options);
    }

    /// Retrieves the reservation coverage for your account, which you can use to
    /// see how much
    /// of your Amazon Elastic Compute Cloud, Amazon ElastiCache, Amazon Relational
    /// Database Service,
    /// or Amazon Redshift usage is covered by a reservation. An organization's
    /// management account can
    /// see the coverage of the associated member accounts. This supports
    /// dimensions, cost categories,
    /// and nested expressions. For any time period, you can filter data about
    /// reservation usage by
    /// the following dimensions:
    ///
    /// * AZ
    ///
    /// * CACHE_ENGINE
    ///
    /// * DATABASE_ENGINE
    ///
    /// * DEPLOYMENT_OPTION
    ///
    /// * INSTANCE_TYPE
    ///
    /// * LINKED_ACCOUNT
    ///
    /// * OPERATING_SYSTEM
    ///
    /// * PLATFORM
    ///
    /// * REGION
    ///
    /// * SERVICE
    ///
    /// * TAG
    ///
    /// * TENANCY
    ///
    /// To determine valid values for a dimension, use the `GetDimensionValues`
    /// operation.
    pub fn getReservationCoverage(self: *Self, allocator: std.mem.Allocator, input: get_reservation_coverage.GetReservationCoverageInput, options: get_reservation_coverage.Options) !get_reservation_coverage.GetReservationCoverageOutput {
        return get_reservation_coverage.execute(self, allocator, input, options);
    }

    /// Gets recommendations for reservation purchases. These recommendations might
    /// help you to
    /// reduce your costs. Reservations provide a discounted hourly rate (up to 75%)
    /// compared to
    /// On-Demand pricing.
    ///
    /// Amazon Web Services generates your recommendations by identifying your
    /// On-Demand usage
    /// during a specific time period and collecting your usage into categories that
    /// are eligible for
    /// a reservation. After Amazon Web Services has these categories, it simulates
    /// every combination
    /// of reservations in each category of usage to identify the best number of
    /// each type of Reserved
    /// Instance (RI) to purchase to maximize your estimated savings.
    ///
    /// For example, Amazon Web Services automatically aggregates your Amazon EC2
    /// Linux, shared
    /// tenancy, and c4 family usage in the US West (Oregon) Region and recommends
    /// that you buy
    /// size-flexible regional reservations to apply to the c4 family usage. Amazon
    /// Web Services
    /// recommends the smallest size instance in an instance family. This makes it
    /// easier to purchase
    /// a size-flexible Reserved Instance (RI). Amazon Web Services also shows the
    /// equal number of
    /// normalized units. This way, you can purchase any instance size that you
    /// want. For this
    /// example, your RI recommendation is for `c4.large` because that is the
    /// smallest size
    /// instance in the c4 instance family.
    pub fn getReservationPurchaseRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_reservation_purchase_recommendation.GetReservationPurchaseRecommendationInput, options: get_reservation_purchase_recommendation.Options) !get_reservation_purchase_recommendation.GetReservationPurchaseRecommendationOutput {
        return get_reservation_purchase_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves the reservation utilization for your account. Management account
    /// in an
    /// organization have access to member accounts. You can filter data by
    /// dimensions in a time
    /// period. You can use `GetDimensionValues` to determine the possible dimension
    /// values. Currently, you can group only by `SUBSCRIPTION_ID`.
    pub fn getReservationUtilization(self: *Self, allocator: std.mem.Allocator, input: get_reservation_utilization.GetReservationUtilizationInput, options: get_reservation_utilization.Options) !get_reservation_utilization.GetReservationUtilizationOutput {
        return get_reservation_utilization.execute(self, allocator, input, options);
    }

    /// Creates recommendations that help you save cost by identifying idle and
    /// underutilized
    /// Amazon EC2 instances.
    ///
    /// Recommendations are generated to either downsize or terminate instances,
    /// along with
    /// providing savings detail and metrics. For more information about calculation
    /// and function, see
    /// [Optimizing Your Cost with Rightsizing
    /// Recommendations](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/ce-rightsizing.html) in the *Billing and Cost Management User Guide*.
    pub fn getRightsizingRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_rightsizing_recommendation.GetRightsizingRecommendationInput, options: get_rightsizing_recommendation.Options) !get_rightsizing_recommendation.GetRightsizingRecommendationOutput {
        return get_rightsizing_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves the details for a Savings Plan recommendation. These details
    /// include the hourly
    /// data-points that construct the cost, coverage, and utilization charts.
    pub fn getSavingsPlanPurchaseRecommendationDetails(self: *Self, allocator: std.mem.Allocator, input: get_savings_plan_purchase_recommendation_details.GetSavingsPlanPurchaseRecommendationDetailsInput, options: get_savings_plan_purchase_recommendation_details.Options) !get_savings_plan_purchase_recommendation_details.GetSavingsPlanPurchaseRecommendationDetailsOutput {
        return get_savings_plan_purchase_recommendation_details.execute(self, allocator, input, options);
    }

    /// Retrieves the Savings Plans covered for your account. This enables you to
    /// see how much of
    /// your cost is covered by a Savings Plan. An organization’s management account
    /// can see the
    /// coverage of the associated member accounts. This supports dimensions, cost
    /// categories, and
    /// nested expressions. For any time period, you can filter data for Savings
    /// Plans usage with the
    /// following dimensions:
    ///
    /// * `LINKED_ACCOUNT`
    ///
    /// * `REGION`
    ///
    /// * `SERVICE`
    ///
    /// * `INSTANCE_FAMILY`
    ///
    /// To determine valid values for a dimension, use the `GetDimensionValues`
    /// operation.
    pub fn getSavingsPlansCoverage(self: *Self, allocator: std.mem.Allocator, input: get_savings_plans_coverage.GetSavingsPlansCoverageInput, options: get_savings_plans_coverage.Options) !get_savings_plans_coverage.GetSavingsPlansCoverageOutput {
        return get_savings_plans_coverage.execute(self, allocator, input, options);
    }

    /// Retrieves the Savings Plans recommendations for your account. First use
    /// `StartSavingsPlansPurchaseRecommendationGeneration` to generate a new set of
    /// recommendations, and then use `GetSavingsPlansPurchaseRecommendation` to
    /// retrieve
    /// them.
    pub fn getSavingsPlansPurchaseRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_savings_plans_purchase_recommendation.GetSavingsPlansPurchaseRecommendationInput, options: get_savings_plans_purchase_recommendation.Options) !get_savings_plans_purchase_recommendation.GetSavingsPlansPurchaseRecommendationOutput {
        return get_savings_plans_purchase_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves the Savings Plans utilization for your account across date ranges
    /// with daily or
    /// monthly granularity. Management account in an organization have access to
    /// member accounts. You
    /// can use `GetDimensionValues` in `SAVINGS_PLANS` to determine the
    /// possible dimension values.
    ///
    /// You can't group by any dimension values for
    /// `GetSavingsPlansUtilization`.
    pub fn getSavingsPlansUtilization(self: *Self, allocator: std.mem.Allocator, input: get_savings_plans_utilization.GetSavingsPlansUtilizationInput, options: get_savings_plans_utilization.Options) !get_savings_plans_utilization.GetSavingsPlansUtilizationOutput {
        return get_savings_plans_utilization.execute(self, allocator, input, options);
    }

    /// Retrieves attribute data along with aggregate utilization and savings data
    /// for a given
    /// time period. This doesn't support granular or grouped data (daily/monthly)
    /// in response. You
    /// can't retrieve data by dates in a single response similar to
    /// `GetSavingsPlanUtilization`, but you have the option to make multiple calls
    /// to
    /// `GetSavingsPlanUtilizationDetails` by providing individual dates. You can
    /// use
    /// `GetDimensionValues` in `SAVINGS_PLANS` to determine the possible
    /// dimension values.
    ///
    /// `GetSavingsPlanUtilizationDetails` internally groups data by
    /// `SavingsPlansArn`.
    pub fn getSavingsPlansUtilizationDetails(self: *Self, allocator: std.mem.Allocator, input: get_savings_plans_utilization_details.GetSavingsPlansUtilizationDetailsInput, options: get_savings_plans_utilization_details.Options) !get_savings_plans_utilization_details.GetSavingsPlansUtilizationDetailsOutput {
        return get_savings_plans_utilization_details.execute(self, allocator, input, options);
    }

    /// Queries for available tag keys and tag values for a specified period. You
    /// can search
    /// the tag values for an arbitrary string.
    pub fn getTags(self: *Self, allocator: std.mem.Allocator, input: get_tags.GetTagsInput, options: get_tags.Options) !get_tags.GetTagsOutput {
        return get_tags.execute(self, allocator, input, options);
    }

    /// Retrieves a forecast for how much Amazon Web Services predicts that you will
    /// use
    /// over the forecast time period that you select, based on your past usage.
    pub fn getUsageForecast(self: *Self, allocator: std.mem.Allocator, input: get_usage_forecast.GetUsageForecastInput, options: get_usage_forecast.Options) !get_usage_forecast.GetUsageForecastOutput {
        return get_usage_forecast.execute(self, allocator, input, options);
    }

    /// Lists the commitment purchase analyses for your account.
    pub fn listCommitmentPurchaseAnalyses(self: *Self, allocator: std.mem.Allocator, input: list_commitment_purchase_analyses.ListCommitmentPurchaseAnalysesInput, options: list_commitment_purchase_analyses.Options) !list_commitment_purchase_analyses.ListCommitmentPurchaseAnalysesOutput {
        return list_commitment_purchase_analyses.execute(self, allocator, input, options);
    }

    /// Retrieves a list of your historical cost allocation tag backfill requests.
    pub fn listCostAllocationTagBackfillHistory(self: *Self, allocator: std.mem.Allocator, input: list_cost_allocation_tag_backfill_history.ListCostAllocationTagBackfillHistoryInput, options: list_cost_allocation_tag_backfill_history.Options) !list_cost_allocation_tag_backfill_history.ListCostAllocationTagBackfillHistoryOutput {
        return list_cost_allocation_tag_backfill_history.execute(self, allocator, input, options);
    }

    /// Get a list of cost allocation tags. All inputs in the API are optional and
    /// serve as
    /// filters. By default, all cost allocation tags are returned.
    pub fn listCostAllocationTags(self: *Self, allocator: std.mem.Allocator, input: list_cost_allocation_tags.ListCostAllocationTagsInput, options: list_cost_allocation_tags.Options) !list_cost_allocation_tags.ListCostAllocationTagsOutput {
        return list_cost_allocation_tags.execute(self, allocator, input, options);
    }

    /// Returns the name, Amazon Resource Name (ARN), `NumberOfRules` and effective
    /// dates of all cost categories defined in the account. You have the option to
    /// use
    /// `EffectiveOn` and `SupportedResourceTypes` to return a list of cost
    /// categories that were active on a specific
    /// date. If there is no `EffectiveOn` specified, you’ll see cost categories
    /// that are
    /// effective on the current date. If cost category is still effective,
    /// `EffectiveEnd`
    /// is omitted in the response. `ListCostCategoryDefinitions` supports
    /// pagination. The
    /// request can have a `MaxResults` range up to 100.
    pub fn listCostCategoryDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_cost_category_definitions.ListCostCategoryDefinitionsInput, options: list_cost_category_definitions.Options) !list_cost_category_definitions.ListCostCategoryDefinitionsOutput {
        return list_cost_category_definitions.execute(self, allocator, input, options);
    }

    /// Returns resource associations of all cost categories defined in the account.
    /// You have the option to use `CostCategoryArn` to get the association for a
    /// specific cost category. `ListCostCategoryResourceAssociations` supports
    /// pagination. The request can have a `MaxResults` range up to 100.
    pub fn listCostCategoryResourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_cost_category_resource_associations.ListCostCategoryResourceAssociationsInput, options: list_cost_category_resource_associations.Options) !list_cost_category_resource_associations.ListCostCategoryResourceAssociationsOutput {
        return list_cost_category_resource_associations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of your historical recommendation generations within the
    /// past 30
    /// days.
    pub fn listSavingsPlansPurchaseRecommendationGeneration(self: *Self, allocator: std.mem.Allocator, input: list_savings_plans_purchase_recommendation_generation.ListSavingsPlansPurchaseRecommendationGenerationInput, options: list_savings_plans_purchase_recommendation_generation.Options) !list_savings_plans_purchase_recommendation_generation.ListSavingsPlansPurchaseRecommendationGenerationOutput {
        return list_savings_plans_purchase_recommendation_generation.execute(self, allocator, input, options);
    }

    /// Returns a list of resource tags associated with the resource specified by
    /// the Amazon
    /// Resource Name (ARN).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Modifies the feedback property of a given cost anomaly.
    pub fn provideAnomalyFeedback(self: *Self, allocator: std.mem.Allocator, input: provide_anomaly_feedback.ProvideAnomalyFeedbackInput, options: provide_anomaly_feedback.Options) !provide_anomaly_feedback.ProvideAnomalyFeedbackOutput {
        return provide_anomaly_feedback.execute(self, allocator, input, options);
    }

    /// Specifies the parameters of a planned commitment purchase and starts the
    /// generation of the
    /// analysis. This enables you to estimate the cost, coverage, and utilization
    /// impact of your
    /// planned commitment purchases.
    pub fn startCommitmentPurchaseAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_commitment_purchase_analysis.StartCommitmentPurchaseAnalysisInput, options: start_commitment_purchase_analysis.Options) !start_commitment_purchase_analysis.StartCommitmentPurchaseAnalysisOutput {
        return start_commitment_purchase_analysis.execute(self, allocator, input, options);
    }

    /// Request a cost allocation tag backfill. This will backfill the activation
    /// status (either `active` or `inactive`) for all tag keys from
    /// `para:BackfillFrom` up to the time this request is made.
    ///
    /// You can request a backfill once every 24 hours.
    pub fn startCostAllocationTagBackfill(self: *Self, allocator: std.mem.Allocator, input: start_cost_allocation_tag_backfill.StartCostAllocationTagBackfillInput, options: start_cost_allocation_tag_backfill.Options) !start_cost_allocation_tag_backfill.StartCostAllocationTagBackfillOutput {
        return start_cost_allocation_tag_backfill.execute(self, allocator, input, options);
    }

    /// Requests a Savings Plans recommendation generation. This enables you to
    /// calculate a fresh
    /// set of Savings Plans recommendations that takes your latest usage data and
    /// current Savings
    /// Plans inventory into account. You can refresh Savings Plans recommendations
    /// up to three times
    /// daily for a consolidated billing family.
    ///
    /// `StartSavingsPlansPurchaseRecommendationGeneration` has no request syntax
    /// because no input parameters are needed to support this operation.
    pub fn startSavingsPlansPurchaseRecommendationGeneration(self: *Self, allocator: std.mem.Allocator, input: start_savings_plans_purchase_recommendation_generation.StartSavingsPlansPurchaseRecommendationGenerationInput, options: start_savings_plans_purchase_recommendation_generation.Options) !start_savings_plans_purchase_recommendation_generation.StartSavingsPlansPurchaseRecommendationGenerationOutput {
        return start_savings_plans_purchase_recommendation_generation.execute(self, allocator, input, options);
    }

    /// An API operation for adding one or more tags (key-value pairs) to a
    /// resource.
    ///
    /// You can use the `TagResource` operation with a resource that already has
    /// tags.
    /// If you specify a new tag key for the resource, this tag is appended to the
    /// list of tags
    /// associated with the resource. If you specify a tag key that is already
    /// associated with the
    /// resource, the new tag value you specify replaces the previous value for that
    /// tag.
    ///
    /// Although the maximum number of array members is 200, user-tag maximum is 50.
    /// The remaining
    /// are reserved for Amazon Web Services use.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource. Specify only tag keys in your
    /// request. Don't
    /// specify the value.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing cost anomaly monitor. The changes made are applied going
    /// forward, and
    /// doesn't change anomalies detected in the past.
    pub fn updateAnomalyMonitor(self: *Self, allocator: std.mem.Allocator, input: update_anomaly_monitor.UpdateAnomalyMonitorInput, options: update_anomaly_monitor.Options) !update_anomaly_monitor.UpdateAnomalyMonitorOutput {
        return update_anomaly_monitor.execute(self, allocator, input, options);
    }

    /// Updates an existing cost anomaly subscription. Specify the fields that you
    /// want to update.
    /// Omitted fields are unchanged.
    ///
    /// The JSON below describes the generic construct for each type. See [Request
    /// Parameters](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_UpdateAnomalySubscription.html#API_UpdateAnomalySubscription_RequestParameters) for possible values as they apply to
    /// `AnomalySubscription`.
    pub fn updateAnomalySubscription(self: *Self, allocator: std.mem.Allocator, input: update_anomaly_subscription.UpdateAnomalySubscriptionInput, options: update_anomaly_subscription.Options) !update_anomaly_subscription.UpdateAnomalySubscriptionOutput {
        return update_anomaly_subscription.execute(self, allocator, input, options);
    }

    /// Updates status for cost allocation tags in bulk, with maximum batch size of
    /// 20. If the tag
    /// status that's updated is the same as the existing tag status, the request
    /// doesn't fail.
    /// Instead, it doesn't have any effect on the tag status (for example,
    /// activating the active
    /// tag).
    pub fn updateCostAllocationTagsStatus(self: *Self, allocator: std.mem.Allocator, input: update_cost_allocation_tags_status.UpdateCostAllocationTagsStatusInput, options: update_cost_allocation_tags_status.Options) !update_cost_allocation_tags_status.UpdateCostAllocationTagsStatusOutput {
        return update_cost_allocation_tags_status.execute(self, allocator, input, options);
    }

    /// Updates an existing cost category. Changes made to the cost category rules
    /// will be used to
    /// categorize the current month’s expenses and future expenses. This won’t
    /// change categorization
    /// for the previous months.
    pub fn updateCostCategoryDefinition(self: *Self, allocator: std.mem.Allocator, input: update_cost_category_definition.UpdateCostCategoryDefinitionInput, options: update_cost_category_definition.Options) !update_cost_category_definition.UpdateCostCategoryDefinitionOutput {
        return update_cost_category_definition.execute(self, allocator, input, options);
    }

    pub fn getAnomaliesPaginator(self: *Self, params: get_anomalies.GetAnomaliesInput) paginator.GetAnomaliesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAnomalyMonitorsPaginator(self: *Self, params: get_anomaly_monitors.GetAnomalyMonitorsInput) paginator.GetAnomalyMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAnomalySubscriptionsPaginator(self: *Self, params: get_anomaly_subscriptions.GetAnomalySubscriptionsInput) paginator.GetAnomalySubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCostAndUsageComparisonsPaginator(self: *Self, params: get_cost_and_usage_comparisons.GetCostAndUsageComparisonsInput) paginator.GetCostAndUsageComparisonsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCostComparisonDriversPaginator(self: *Self, params: get_cost_comparison_drivers.GetCostComparisonDriversInput) paginator.GetCostComparisonDriversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getReservationPurchaseRecommendationPaginator(self: *Self, params: get_reservation_purchase_recommendation.GetReservationPurchaseRecommendationInput) paginator.GetReservationPurchaseRecommendationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRightsizingRecommendationPaginator(self: *Self, params: get_rightsizing_recommendation.GetRightsizingRecommendationInput) paginator.GetRightsizingRecommendationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSavingsPlansCoveragePaginator(self: *Self, params: get_savings_plans_coverage.GetSavingsPlansCoverageInput) paginator.GetSavingsPlansCoveragePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSavingsPlansUtilizationDetailsPaginator(self: *Self, params: get_savings_plans_utilization_details.GetSavingsPlansUtilizationDetailsInput) paginator.GetSavingsPlansUtilizationDetailsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommitmentPurchaseAnalysesPaginator(self: *Self, params: list_commitment_purchase_analyses.ListCommitmentPurchaseAnalysesInput) paginator.ListCommitmentPurchaseAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCostAllocationTagBackfillHistoryPaginator(self: *Self, params: list_cost_allocation_tag_backfill_history.ListCostAllocationTagBackfillHistoryInput) paginator.ListCostAllocationTagBackfillHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCostAllocationTagsPaginator(self: *Self, params: list_cost_allocation_tags.ListCostAllocationTagsInput) paginator.ListCostAllocationTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCostCategoryDefinitionsPaginator(self: *Self, params: list_cost_category_definitions.ListCostCategoryDefinitionsInput) paginator.ListCostCategoryDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCostCategoryResourceAssociationsPaginator(self: *Self, params: list_cost_category_resource_associations.ListCostCategoryResourceAssociationsInput) paginator.ListCostCategoryResourceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSavingsPlansPurchaseRecommendationGenerationPaginator(self: *Self, params: list_savings_plans_purchase_recommendation_generation.ListSavingsPlansPurchaseRecommendationGenerationInput) paginator.ListSavingsPlansPurchaseRecommendationGenerationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
