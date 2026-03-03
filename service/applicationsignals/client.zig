const aws = @import("aws");
const std = @import("std");

const batch_get_service_level_objective_budget_report = @import("batch_get_service_level_objective_budget_report.zig");
const batch_update_exclusion_windows = @import("batch_update_exclusion_windows.zig");
const create_service_level_objective = @import("create_service_level_objective.zig");
const delete_grouping_configuration = @import("delete_grouping_configuration.zig");
const delete_service_level_objective = @import("delete_service_level_objective.zig");
const get_service = @import("get_service.zig");
const get_service_level_objective = @import("get_service_level_objective.zig");
const list_audit_findings = @import("list_audit_findings.zig");
const list_entity_events = @import("list_entity_events.zig");
const list_grouping_attribute_definitions = @import("list_grouping_attribute_definitions.zig");
const list_service_dependencies = @import("list_service_dependencies.zig");
const list_service_dependents = @import("list_service_dependents.zig");
const list_service_level_objective_exclusion_windows = @import("list_service_level_objective_exclusion_windows.zig");
const list_service_level_objectives = @import("list_service_level_objectives.zig");
const list_service_operations = @import("list_service_operations.zig");
const list_service_states = @import("list_service_states.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_grouping_configuration = @import("put_grouping_configuration.zig");
const start_discovery = @import("start_discovery.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_service_level_objective = @import("update_service_level_objective.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Application Signals";

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

    /// Use this operation to retrieve one or more *service level objective (SLO)
    /// budget reports*.
    ///
    /// An *error budget* is the amount of time or requests in an unhealthy state
    /// that your service can accumulate during an interval before your overall SLO
    /// budget health is breached and the SLO is considered to be unmet. For
    /// example, an SLO with a threshold of 99.95% and a monthly interval translates
    /// to an error budget of 21.9 minutes of downtime in a 30-day month.
    ///
    /// Budget reports include a health indicator, the attainment value, and
    /// remaining budget.
    ///
    /// For more information about SLO error budgets, see [ SLO
    /// concepts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-ServiceLevelObjectives.html#CloudWatch-ServiceLevelObjectives-concepts).
    pub fn batchGetServiceLevelObjectiveBudgetReport(self: *Self, allocator: std.mem.Allocator, input: batch_get_service_level_objective_budget_report.BatchGetServiceLevelObjectiveBudgetReportInput, options: CallOptions) !batch_get_service_level_objective_budget_report.BatchGetServiceLevelObjectiveBudgetReportOutput {
        return batch_get_service_level_objective_budget_report.execute(self, allocator, input, options);
    }

    /// Add or remove time window exclusions for one or more Service Level
    /// Objectives (SLOs).
    pub fn batchUpdateExclusionWindows(self: *Self, allocator: std.mem.Allocator, input: batch_update_exclusion_windows.BatchUpdateExclusionWindowsInput, options: CallOptions) !batch_update_exclusion_windows.BatchUpdateExclusionWindowsOutput {
        return batch_update_exclusion_windows.execute(self, allocator, input, options);
    }

    /// Creates a service level objective (SLO), which can help you ensure that your
    /// critical business operations are meeting customer expectations. Use SLOs to
    /// set and track specific target levels for the reliability and availability of
    /// your applications and services. SLOs use service level indicators (SLIs) to
    /// calculate whether the application is performing at the level that you want.
    ///
    /// Create an SLO to set a target for a service or operation’s availability or
    /// latency. CloudWatch measures this target frequently you can find whether it
    /// has been breached.
    ///
    /// The target performance quality that is defined for an SLO is the *attainment
    /// goal*.
    ///
    /// You can set SLO targets for your applications that are discovered by
    /// Application Signals, using critical metrics such as latency and
    /// availability. You can also set SLOs against any CloudWatch metric or math
    /// expression that produces a time series.
    ///
    /// You can't create an SLO for a service operation that was discovered by
    /// Application Signals until after that operation has reported standard metrics
    /// to Application Signals.
    ///
    /// When you create an SLO, you specify whether it is a *period-based SLO* or a
    /// *request-based SLO*. Each type of SLO has a different way of evaluating your
    /// application's performance against its attainment goal.
    ///
    /// * A *period-based SLO* uses defined *periods* of time within a specified
    ///   total time interval. For each period of time, Application Signals
    ///   determines whether the application met its goal. The attainment rate is
    ///   calculated as the `number of good periods/number of total periods`.
    ///
    /// For example, for a period-based SLO, meeting an attainment goal of 99.9%
    /// means that within your interval, your application must meet its performance
    /// goal during at least 99.9% of the time periods.
    /// * A *request-based SLO* doesn't use pre-defined periods of time. Instead,
    ///   the SLO measures `number of good requests/number of total requests` during
    ///   the interval. At any time, you can find the ratio of good requests to
    ///   total requests for the interval up to the time stamp that you specify, and
    ///   measure that ratio against the goal set in your SLO.
    ///
    /// After you have created an SLO, you can retrieve error budget reports for it.
    /// An *error budget* is the amount of time or amount of requests that your
    /// application can be non-compliant with the SLO's goal, and still have your
    /// application meet the goal.
    ///
    /// * For a period-based SLO, the error budget starts at a number defined by the
    ///   highest number of periods that can fail to meet the threshold, while still
    ///   meeting the overall goal. The *remaining error budget* decreases with
    ///   every failed period that is recorded. The error budget within one interval
    ///   can never increase.
    ///
    /// For example, an SLO with a threshold that 99.95% of requests must be
    /// completed under 2000ms every month translates to an error budget of 21.9
    /// minutes of downtime per month.
    /// * For a request-based SLO, the remaining error budget is dynamic and can
    ///   increase or decrease, depending on the ratio of good requests to total
    ///   requests.
    ///
    /// For more information about SLOs, see [ Service level objectives
    /// (SLOs)](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-ServiceLevelObjectives.html).
    ///
    /// When you perform a `CreateServiceLevelObjective` operation, Application
    /// Signals creates the *AWSServiceRoleForCloudWatchApplicationSignals*
    /// service-linked role, if it doesn't already exist in your account. This
    /// service- linked role has the following permissions:
    ///
    /// * `xray:GetServiceGraph`
    /// * `logs:StartQuery`
    /// * `logs:GetQueryResults`
    /// * `cloudwatch:GetMetricData`
    /// * `cloudwatch:ListMetrics`
    /// * `tag:GetResources`
    /// * `autoscaling:DescribeAutoScalingGroups`
    pub fn createServiceLevelObjective(self: *Self, allocator: std.mem.Allocator, input: create_service_level_objective.CreateServiceLevelObjectiveInput, options: CallOptions) !create_service_level_objective.CreateServiceLevelObjectiveOutput {
        return create_service_level_objective.execute(self, allocator, input, options);
    }

    /// Deletes the grouping configuration for this account. This removes all custom
    /// grouping attribute definitions that were previously configured.
    pub fn deleteGroupingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_grouping_configuration.DeleteGroupingConfigurationInput, options: CallOptions) !delete_grouping_configuration.DeleteGroupingConfigurationOutput {
        return delete_grouping_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified service level objective.
    pub fn deleteServiceLevelObjective(self: *Self, allocator: std.mem.Allocator, input: delete_service_level_objective.DeleteServiceLevelObjectiveInput, options: CallOptions) !delete_service_level_objective.DeleteServiceLevelObjectiveOutput {
        return delete_service_level_objective.execute(self, allocator, input, options);
    }

    /// Returns information about a service discovered by Application Signals.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: CallOptions) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Returns information about one SLO created in the account.
    pub fn getServiceLevelObjective(self: *Self, allocator: std.mem.Allocator, input: get_service_level_objective.GetServiceLevelObjectiveInput, options: CallOptions) !get_service_level_objective.GetServiceLevelObjectiveOutput {
        return get_service_level_objective.execute(self, allocator, input, options);
    }

    /// Returns a list of audit findings that provide automated analysis of service
    /// behavior and root cause analysis. These findings help identify the most
    /// significant observations about your services, including performance issues,
    /// anomalies, and potential problems. The findings are generated using
    /// heuristic algorithms based on established troubleshooting patterns.
    pub fn listAuditFindings(self: *Self, allocator: std.mem.Allocator, input: list_audit_findings.ListAuditFindingsInput, options: CallOptions) !list_audit_findings.ListAuditFindingsOutput {
        return list_audit_findings.execute(self, allocator, input, options);
    }

    /// Returns a list of change events for a specific entity, such as deployments,
    /// configuration changes, or other state-changing activities. This operation
    /// helps track the history of changes that may have affected service
    /// performance.
    pub fn listEntityEvents(self: *Self, allocator: std.mem.Allocator, input: list_entity_events.ListEntityEventsInput, options: CallOptions) !list_entity_events.ListEntityEventsOutput {
        return list_entity_events.execute(self, allocator, input, options);
    }

    /// Returns the current grouping configuration for this account, including all
    /// custom grouping attribute definitions that have been configured. These
    /// definitions determine how services are logically grouped based on telemetry
    /// attributes, Amazon Web Services tags, or predefined mappings.
    pub fn listGroupingAttributeDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_grouping_attribute_definitions.ListGroupingAttributeDefinitionsInput, options: CallOptions) !list_grouping_attribute_definitions.ListGroupingAttributeDefinitionsOutput {
        return list_grouping_attribute_definitions.execute(self, allocator, input, options);
    }

    /// Returns a list of service dependencies of the service that you specify. A
    /// dependency is an infrastructure component that an operation of this service
    /// connects with. Dependencies can include Amazon Web Services services, Amazon
    /// Web Services resources, and third-party services.
    pub fn listServiceDependencies(self: *Self, allocator: std.mem.Allocator, input: list_service_dependencies.ListServiceDependenciesInput, options: CallOptions) !list_service_dependencies.ListServiceDependenciesOutput {
        return list_service_dependencies.execute(self, allocator, input, options);
    }

    /// Returns the list of dependents that invoked the specified service during the
    /// provided time range. Dependents include other services, CloudWatch
    /// Synthetics canaries, and clients that are instrumented with CloudWatch RUM
    /// app monitors.
    pub fn listServiceDependents(self: *Self, allocator: std.mem.Allocator, input: list_service_dependents.ListServiceDependentsInput, options: CallOptions) !list_service_dependents.ListServiceDependentsOutput {
        return list_service_dependents.execute(self, allocator, input, options);
    }

    /// Retrieves all exclusion windows configured for a specific SLO.
    pub fn listServiceLevelObjectiveExclusionWindows(self: *Self, allocator: std.mem.Allocator, input: list_service_level_objective_exclusion_windows.ListServiceLevelObjectiveExclusionWindowsInput, options: CallOptions) !list_service_level_objective_exclusion_windows.ListServiceLevelObjectiveExclusionWindowsOutput {
        return list_service_level_objective_exclusion_windows.execute(self, allocator, input, options);
    }

    /// Returns a list of SLOs created in this account.
    pub fn listServiceLevelObjectives(self: *Self, allocator: std.mem.Allocator, input: list_service_level_objectives.ListServiceLevelObjectivesInput, options: CallOptions) !list_service_level_objectives.ListServiceLevelObjectivesOutput {
        return list_service_level_objectives.execute(self, allocator, input, options);
    }

    /// Returns a list of the *operations* of this service that have been discovered
    /// by Application Signals. Only the operations that were invoked during the
    /// specified time range are returned.
    pub fn listServiceOperations(self: *Self, allocator: std.mem.Allocator, input: list_service_operations.ListServiceOperationsInput, options: CallOptions) !list_service_operations.ListServiceOperationsOutput {
        return list_service_operations.execute(self, allocator, input, options);
    }

    /// Returns information about the last deployment and other change states of
    /// services. This API provides visibility into recent changes that may have
    /// affected service performance, helping with troubleshooting and change
    /// correlation.
    pub fn listServiceStates(self: *Self, allocator: std.mem.Allocator, input: list_service_states.ListServiceStatesInput, options: CallOptions) !list_service_states.ListServiceStatesOutput {
        return list_service_states.execute(self, allocator, input, options);
    }

    /// Returns a list of services that have been discovered by Application Signals.
    /// A service represents a minimum logical and transactional unit that completes
    /// a business function. Services are discovered through Application Signals
    /// instrumentation.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with a CloudWatch resource. Tags can be
    /// assigned to service level objectives.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates the grouping configuration for this account. This
    /// operation allows you to define custom grouping attributes that determine how
    /// services are logically grouped based on telemetry attributes, Amazon Web
    /// Services tags, or predefined mappings. These grouping attributes can then be
    /// used to organize and filter services in the Application Signals console and
    /// APIs.
    pub fn putGroupingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_grouping_configuration.PutGroupingConfigurationInput, options: CallOptions) !put_grouping_configuration.PutGroupingConfigurationOutput {
        return put_grouping_configuration.execute(self, allocator, input, options);
    }

    /// Enables this Amazon Web Services account to be able to use CloudWatch
    /// Application Signals by creating the
    /// *AWSServiceRoleForCloudWatchApplicationSignals* service-linked role. This
    /// service- linked role has the following permissions:
    ///
    /// * `xray:GetServiceGraph`
    /// * `logs:StartQuery`
    /// * `logs:GetQueryResults`
    /// * `cloudwatch:GetMetricData`
    /// * `cloudwatch:ListMetrics`
    /// * `tag:GetResources`
    /// * `autoscaling:DescribeAutoScalingGroups`
    ///
    /// A service-linked CloudTrail event channel is created to process CloudTrail
    /// events and return change event information. This includes last deployment
    /// time, userName, eventName, and other event metadata.
    ///
    /// After completing this step, you still need to instrument your Java and
    /// Python applications to send data to Application Signals. For more
    /// information, see [ Enabling Application
    /// Signals](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Application-Signals-Enable.html).
    pub fn startDiscovery(self: *Self, allocator: std.mem.Allocator, input: start_discovery.StartDiscoveryInput, options: CallOptions) !start_discovery.StartDiscoveryOutput {
        return start_discovery.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified CloudWatch
    /// resource, such as a service level objective.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// Tags don't have any semantic meaning to Amazon Web Services and are
    /// interpreted strictly as strings of characters.
    ///
    /// You can use the `TagResource` action with an alarm that already has tags. If
    /// you specify a new tag key for the alarm, this tag is appended to the list of
    /// tags associated with the alarm. If you specify a tag key that is already
    /// associated with the alarm, the new tag value that you specify replaces the
    /// previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a CloudWatch resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing service level objective (SLO). If you omit parameters,
    /// the previous values of those parameters are retained.
    ///
    /// You cannot change from a period-based SLO to a request-based SLO, or change
    /// from a request-based SLO to a period-based SLO.
    pub fn updateServiceLevelObjective(self: *Self, allocator: std.mem.Allocator, input: update_service_level_objective.UpdateServiceLevelObjectiveInput, options: CallOptions) !update_service_level_objective.UpdateServiceLevelObjectiveOutput {
        return update_service_level_objective.execute(self, allocator, input, options);
    }

    pub fn listEntityEventsPaginator(self: *Self, params: list_entity_events.ListEntityEventsInput) paginator.ListEntityEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceDependenciesPaginator(self: *Self, params: list_service_dependencies.ListServiceDependenciesInput) paginator.ListServiceDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceDependentsPaginator(self: *Self, params: list_service_dependents.ListServiceDependentsInput) paginator.ListServiceDependentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceLevelObjectiveExclusionWindowsPaginator(self: *Self, params: list_service_level_objective_exclusion_windows.ListServiceLevelObjectiveExclusionWindowsInput) paginator.ListServiceLevelObjectiveExclusionWindowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceLevelObjectivesPaginator(self: *Self, params: list_service_level_objectives.ListServiceLevelObjectivesInput) paginator.ListServiceLevelObjectivesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceOperationsPaginator(self: *Self, params: list_service_operations.ListServiceOperationsInput) paginator.ListServiceOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceStatesPaginator(self: *Self, params: list_service_states.ListServiceStatesInput) paginator.ListServiceStatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
