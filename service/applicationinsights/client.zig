const aws = @import("aws");
const std = @import("std");

const add_workload = @import("add_workload.zig");
const create_application = @import("create_application.zig");
const create_component = @import("create_component.zig");
const create_log_pattern = @import("create_log_pattern.zig");
const delete_application = @import("delete_application.zig");
const delete_component = @import("delete_component.zig");
const delete_log_pattern = @import("delete_log_pattern.zig");
const describe_application = @import("describe_application.zig");
const describe_component = @import("describe_component.zig");
const describe_component_configuration = @import("describe_component_configuration.zig");
const describe_component_configuration_recommendation = @import("describe_component_configuration_recommendation.zig");
const describe_log_pattern = @import("describe_log_pattern.zig");
const describe_observation = @import("describe_observation.zig");
const describe_problem = @import("describe_problem.zig");
const describe_problem_observations = @import("describe_problem_observations.zig");
const describe_workload = @import("describe_workload.zig");
const list_applications = @import("list_applications.zig");
const list_components = @import("list_components.zig");
const list_configuration_history = @import("list_configuration_history.zig");
const list_log_pattern_sets = @import("list_log_pattern_sets.zig");
const list_log_patterns = @import("list_log_patterns.zig");
const list_problems = @import("list_problems.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workloads = @import("list_workloads.zig");
const remove_workload = @import("remove_workload.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_component = @import("update_component.zig");
const update_component_configuration = @import("update_component_configuration.zig");
const update_log_pattern = @import("update_log_pattern.zig");
const update_problem = @import("update_problem.zig");
const update_workload = @import("update_workload.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Application Insights";

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

    /// Adds a workload to a component. Each component can have at most five
    /// workloads.
    pub fn addWorkload(self: *Self, allocator: std.mem.Allocator, input: add_workload.AddWorkloadInput, options: add_workload.Options) !add_workload.AddWorkloadOutput {
        return add_workload.execute(self, allocator, input, options);
    }

    /// Adds an application that is created from a resource group.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a custom component by grouping similar standalone instances to
    /// monitor.
    pub fn createComponent(self: *Self, allocator: std.mem.Allocator, input: create_component.CreateComponentInput, options: create_component.Options) !create_component.CreateComponentOutput {
        return create_component.execute(self, allocator, input, options);
    }

    /// Adds an log pattern to a `LogPatternSet`.
    pub fn createLogPattern(self: *Self, allocator: std.mem.Allocator, input: create_log_pattern.CreateLogPatternInput, options: create_log_pattern.Options) !create_log_pattern.CreateLogPatternOutput {
        return create_log_pattern.execute(self, allocator, input, options);
    }

    /// Removes the specified application from monitoring. Does not delete the
    /// application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Ungroups a custom component. When you ungroup custom components, all
    /// applicable monitors
    /// that are set up for the component are removed and the instances revert to
    /// their standalone
    /// status.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: delete_component.Options) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Removes the specified log pattern from a `LogPatternSet`.
    pub fn deleteLogPattern(self: *Self, allocator: std.mem.Allocator, input: delete_log_pattern.DeleteLogPatternInput, options: delete_log_pattern.Options) !delete_log_pattern.DeleteLogPatternOutput {
        return delete_log_pattern.execute(self, allocator, input, options);
    }

    /// Describes the application.
    pub fn describeApplication(self: *Self, allocator: std.mem.Allocator, input: describe_application.DescribeApplicationInput, options: describe_application.Options) !describe_application.DescribeApplicationOutput {
        return describe_application.execute(self, allocator, input, options);
    }

    /// Describes a component and lists the resources that are grouped together in a
    /// component.
    pub fn describeComponent(self: *Self, allocator: std.mem.Allocator, input: describe_component.DescribeComponentInput, options: describe_component.Options) !describe_component.DescribeComponentOutput {
        return describe_component.execute(self, allocator, input, options);
    }

    /// Describes the monitoring configuration of the component.
    pub fn describeComponentConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_component_configuration.DescribeComponentConfigurationInput, options: describe_component_configuration.Options) !describe_component_configuration.DescribeComponentConfigurationOutput {
        return describe_component_configuration.execute(self, allocator, input, options);
    }

    /// Describes the recommended monitoring configuration of the component.
    pub fn describeComponentConfigurationRecommendation(self: *Self, allocator: std.mem.Allocator, input: describe_component_configuration_recommendation.DescribeComponentConfigurationRecommendationInput, options: describe_component_configuration_recommendation.Options) !describe_component_configuration_recommendation.DescribeComponentConfigurationRecommendationOutput {
        return describe_component_configuration_recommendation.execute(self, allocator, input, options);
    }

    /// Describe a specific log pattern from a `LogPatternSet`.
    pub fn describeLogPattern(self: *Self, allocator: std.mem.Allocator, input: describe_log_pattern.DescribeLogPatternInput, options: describe_log_pattern.Options) !describe_log_pattern.DescribeLogPatternOutput {
        return describe_log_pattern.execute(self, allocator, input, options);
    }

    /// Describes an anomaly or error with the application.
    pub fn describeObservation(self: *Self, allocator: std.mem.Allocator, input: describe_observation.DescribeObservationInput, options: describe_observation.Options) !describe_observation.DescribeObservationOutput {
        return describe_observation.execute(self, allocator, input, options);
    }

    /// Describes an application problem.
    pub fn describeProblem(self: *Self, allocator: std.mem.Allocator, input: describe_problem.DescribeProblemInput, options: describe_problem.Options) !describe_problem.DescribeProblemOutput {
        return describe_problem.execute(self, allocator, input, options);
    }

    /// Describes the anomalies or errors associated with the problem.
    pub fn describeProblemObservations(self: *Self, allocator: std.mem.Allocator, input: describe_problem_observations.DescribeProblemObservationsInput, options: describe_problem_observations.Options) !describe_problem_observations.DescribeProblemObservationsOutput {
        return describe_problem_observations.execute(self, allocator, input, options);
    }

    /// Describes a workload and its configuration.
    pub fn describeWorkload(self: *Self, allocator: std.mem.Allocator, input: describe_workload.DescribeWorkloadInput, options: describe_workload.Options) !describe_workload.DescribeWorkloadOutput {
        return describe_workload.execute(self, allocator, input, options);
    }

    /// Lists the IDs of the applications that you are monitoring.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists the auto-grouped, standalone, and custom components of the
    /// application.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: list_components.Options) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Lists the INFO, WARN, and ERROR events for periodic configuration updates
    /// performed by
    /// Application Insights. Examples of events represented are:
    ///
    /// * INFO: creating a new alarm or updating an alarm threshold.
    ///
    /// * WARN: alarm not created due to insufficient data points used to predict
    /// thresholds.
    ///
    /// * ERROR: alarm not created due to permission errors or exceeding quotas.
    pub fn listConfigurationHistory(self: *Self, allocator: std.mem.Allocator, input: list_configuration_history.ListConfigurationHistoryInput, options: list_configuration_history.Options) !list_configuration_history.ListConfigurationHistoryOutput {
        return list_configuration_history.execute(self, allocator, input, options);
    }

    /// Lists the log pattern sets in the specific application.
    pub fn listLogPatternSets(self: *Self, allocator: std.mem.Allocator, input: list_log_pattern_sets.ListLogPatternSetsInput, options: list_log_pattern_sets.Options) !list_log_pattern_sets.ListLogPatternSetsOutput {
        return list_log_pattern_sets.execute(self, allocator, input, options);
    }

    /// Lists the log patterns in the specific log `LogPatternSet`.
    pub fn listLogPatterns(self: *Self, allocator: std.mem.Allocator, input: list_log_patterns.ListLogPatternsInput, options: list_log_patterns.Options) !list_log_patterns.ListLogPatternsOutput {
        return list_log_patterns.execute(self, allocator, input, options);
    }

    /// Lists the problems with your application.
    pub fn listProblems(self: *Self, allocator: std.mem.Allocator, input: list_problems.ListProblemsInput, options: list_problems.Options) !list_problems.ListProblemsOutput {
        return list_problems.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the tags (keys and values) that are associated with a
    /// specified
    /// application. A *tag* is a label that you optionally define and associate
    /// with an application. Each tag consists of a required *tag key* and an
    /// optional associated *tag value*. A tag key is a general label that acts
    /// as a category for more specific tag values. A tag value acts as a descriptor
    /// within a tag
    /// key.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the workloads that are configured on a given component.
    pub fn listWorkloads(self: *Self, allocator: std.mem.Allocator, input: list_workloads.ListWorkloadsInput, options: list_workloads.Options) !list_workloads.ListWorkloadsOutput {
        return list_workloads.execute(self, allocator, input, options);
    }

    /// Remove workload from a component.
    pub fn removeWorkload(self: *Self, allocator: std.mem.Allocator, input: remove_workload.RemoveWorkloadInput, options: remove_workload.Options) !remove_workload.RemoveWorkloadOutput {
        return remove_workload.execute(self, allocator, input, options);
    }

    /// Add one or more tags (keys and values) to a specified application. A
    /// *tag* is a label that you optionally define and associate with an
    /// application. Tags can help you categorize and manage application in
    /// different ways, such as
    /// by purpose, owner, environment, or other criteria.
    ///
    /// Each tag consists of a required *tag key* and an associated
    /// *tag value*, both of which you define. A tag key is a general label
    /// that acts as a category for more specific tag values. A tag value acts as a
    /// descriptor
    /// within a tag key.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove one or more tags (keys and values) from a specified application.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the custom component name and/or the list of resources that make up
    /// the
    /// component.
    pub fn updateComponent(self: *Self, allocator: std.mem.Allocator, input: update_component.UpdateComponentInput, options: update_component.Options) !update_component.UpdateComponentOutput {
        return update_component.execute(self, allocator, input, options);
    }

    /// Updates the monitoring configurations for the component. The configuration
    /// input
    /// parameter is an escaped JSON of the configuration and should match the
    /// schema of what is
    /// returned by `DescribeComponentConfigurationRecommendation`.
    pub fn updateComponentConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_component_configuration.UpdateComponentConfigurationInput, options: update_component_configuration.Options) !update_component_configuration.UpdateComponentConfigurationOutput {
        return update_component_configuration.execute(self, allocator, input, options);
    }

    /// Adds a log pattern to a `LogPatternSet`.
    pub fn updateLogPattern(self: *Self, allocator: std.mem.Allocator, input: update_log_pattern.UpdateLogPatternInput, options: update_log_pattern.Options) !update_log_pattern.UpdateLogPatternOutput {
        return update_log_pattern.execute(self, allocator, input, options);
    }

    /// Updates the visibility of the problem or specifies the problem as
    /// `RESOLVED`.
    pub fn updateProblem(self: *Self, allocator: std.mem.Allocator, input: update_problem.UpdateProblemInput, options: update_problem.Options) !update_problem.UpdateProblemOutput {
        return update_problem.execute(self, allocator, input, options);
    }

    /// Adds a workload to a component. Each component can have at most five
    /// workloads.
    pub fn updateWorkload(self: *Self, allocator: std.mem.Allocator, input: update_workload.UpdateWorkloadInput, options: update_workload.Options) !update_workload.UpdateWorkloadOutput {
        return update_workload.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationHistoryPaginator(self: *Self, params: list_configuration_history.ListConfigurationHistoryInput) paginator.ListConfigurationHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogPatternSetsPaginator(self: *Self, params: list_log_pattern_sets.ListLogPatternSetsInput) paginator.ListLogPatternSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLogPatternsPaginator(self: *Self, params: list_log_patterns.ListLogPatternsInput) paginator.ListLogPatternsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProblemsPaginator(self: *Self, params: list_problems.ListProblemsInput) paginator.ListProblemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkloadsPaginator(self: *Self, params: list_workloads.ListWorkloadsInput) paginator.ListWorkloadsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
