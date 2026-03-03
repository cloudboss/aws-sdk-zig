const aws = @import("aws");
const std = @import("std");

const create_monitor = @import("create_monitor.zig");
const create_scope = @import("create_scope.zig");
const delete_monitor = @import("delete_monitor.zig");
const delete_scope = @import("delete_scope.zig");
const get_monitor = @import("get_monitor.zig");
const get_query_results_monitor_top_contributors = @import("get_query_results_monitor_top_contributors.zig");
const get_query_results_workload_insights_top_contributors = @import("get_query_results_workload_insights_top_contributors.zig");
const get_query_results_workload_insights_top_contributors_data = @import("get_query_results_workload_insights_top_contributors_data.zig");
const get_query_status_monitor_top_contributors = @import("get_query_status_monitor_top_contributors.zig");
const get_query_status_workload_insights_top_contributors = @import("get_query_status_workload_insights_top_contributors.zig");
const get_query_status_workload_insights_top_contributors_data = @import("get_query_status_workload_insights_top_contributors_data.zig");
const get_scope = @import("get_scope.zig");
const list_monitors = @import("list_monitors.zig");
const list_scopes = @import("list_scopes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_query_monitor_top_contributors = @import("start_query_monitor_top_contributors.zig");
const start_query_workload_insights_top_contributors = @import("start_query_workload_insights_top_contributors.zig");
const start_query_workload_insights_top_contributors_data = @import("start_query_workload_insights_top_contributors_data.zig");
const stop_query_monitor_top_contributors = @import("stop_query_monitor_top_contributors.zig");
const stop_query_workload_insights_top_contributors = @import("stop_query_workload_insights_top_contributors.zig");
const stop_query_workload_insights_top_contributors_data = @import("stop_query_workload_insights_top_contributors_data.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_monitor = @import("update_monitor.zig");
const update_scope = @import("update_scope.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "NetworkFlowMonitor";

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

    /// Create a monitor for specific network flows between local and remote
    /// resources, so that you can monitor network performance for one or several of
    /// your workloads. For each monitor, Network Flow Monitor publishes detailed
    /// end-to-end performance metrics and a network health indicator (NHI) that
    /// informs you whether there were Amazon Web Services network issues for one or
    /// more of the network flows tracked by a monitor, during a time period that
    /// you choose.
    pub fn createMonitor(self: *Self, allocator: std.mem.Allocator, input: create_monitor.CreateMonitorInput, options: CallOptions) !create_monitor.CreateMonitorOutput {
        return create_monitor.execute(self, allocator, input, options);
    }

    /// In Network Flow Monitor, you specify a scope for the service to generate
    /// metrics for. By using the scope, Network Flow Monitor can generate a
    /// topology of all the resources to measure performance metrics for. When you
    /// create a scope, you enable permissions for Network Flow Monitor.
    ///
    /// A scope is a Region-account pair or multiple Region-account pairs. Network
    /// Flow Monitor uses your scope to determine all the resources (the topology)
    /// where Network Flow Monitor will gather network flow performance metrics for
    /// you. To provide performance metrics, Network Flow Monitor uses the data that
    /// is sent by the Network Flow Monitor agents you install on the resources.
    ///
    /// To define the Region-account pairs for your scope, the Network Flow Monitor
    /// API uses the following constucts, which allow for future flexibility in
    /// defining scopes:
    ///
    /// * *Targets*, which are arrays of targetResources.
    /// * *Target resources*, which are Region-targetIdentifier pairs.
    /// * *Target identifiers*, made up of a targetID (currently always an account
    ///   ID) and a targetType (currently always an account).
    pub fn createScope(self: *Self, allocator: std.mem.Allocator, input: create_scope.CreateScopeInput, options: CallOptions) !create_scope.CreateScopeOutput {
        return create_scope.execute(self, allocator, input, options);
    }

    /// Deletes a monitor in Network Flow Monitor.
    pub fn deleteMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_monitor.DeleteMonitorInput, options: CallOptions) !delete_monitor.DeleteMonitorOutput {
        return delete_monitor.execute(self, allocator, input, options);
    }

    /// Deletes a scope that has been defined.
    pub fn deleteScope(self: *Self, allocator: std.mem.Allocator, input: delete_scope.DeleteScopeInput, options: CallOptions) !delete_scope.DeleteScopeOutput {
        return delete_scope.execute(self, allocator, input, options);
    }

    /// Gets information about a monitor in Network Flow Monitor based on a monitor
    /// name. The information returned includes the Amazon Resource Name (ARN),
    /// create time, modified time, resources included in the monitor, and status
    /// information.
    pub fn getMonitor(self: *Self, allocator: std.mem.Allocator, input: get_monitor.GetMonitorInput, options: CallOptions) !get_monitor.GetMonitorOutput {
        return get_monitor.execute(self, allocator, input, options);
    }

    /// Return the data for a query with the Network Flow Monitor query interface.
    /// You specify the query that you want to return results for by providing a
    /// query ID and a monitor name. This query returns the top contributors for a
    /// specific monitor.
    ///
    /// Create a query ID for this call by calling the corresponding API call to
    /// start the query, `StartQueryMonitorTopContributors`. Use the scope ID that
    /// was returned for your account by `CreateScope`.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn getQueryResultsMonitorTopContributors(self: *Self, allocator: std.mem.Allocator, input: get_query_results_monitor_top_contributors.GetQueryResultsMonitorTopContributorsInput, options: CallOptions) !get_query_results_monitor_top_contributors.GetQueryResultsMonitorTopContributorsOutput {
        return get_query_results_monitor_top_contributors.execute(self, allocator, input, options);
    }

    /// Return the data for a query with the Network Flow Monitor query interface.
    /// You specify the query that you want to return results for by providing a
    /// query ID and a monitor name.
    ///
    /// This query returns the top contributors for a scope for workload insights.
    /// Workload insights provide a high level view of network flow performance data
    /// collected by agents. To return the data for the top contributors, see
    /// `GetQueryResultsWorkloadInsightsTopContributorsData`.
    ///
    /// Create a query ID for this call by calling the corresponding API call to
    /// start the query, `StartQueryWorkloadInsightsTopContributors`. Use the scope
    /// ID that was returned for your account by `CreateScope`.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn getQueryResultsWorkloadInsightsTopContributors(self: *Self, allocator: std.mem.Allocator, input: get_query_results_workload_insights_top_contributors.GetQueryResultsWorkloadInsightsTopContributorsInput, options: CallOptions) !get_query_results_workload_insights_top_contributors.GetQueryResultsWorkloadInsightsTopContributorsOutput {
        return get_query_results_workload_insights_top_contributors.execute(self, allocator, input, options);
    }

    /// Return the data for a query with the Network Flow Monitor query interface.
    /// Specify the query that you want to return results for by providing a query
    /// ID and a scope ID.
    ///
    /// This query returns the data for top contributors for workload insights for a
    /// specific scope. Workload insights provide a high level view of network flow
    /// performance data collected by agents for a scope. To return just the top
    /// contributors, see `GetQueryResultsWorkloadInsightsTopContributors`.
    ///
    /// Create a query ID for this call by calling the corresponding API call to
    /// start the query, `StartQueryWorkloadInsightsTopContributorsData`. Use the
    /// scope ID that was returned for your account by `CreateScope`.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    ///
    /// The top contributor network flows overall are for a specific metric type,
    /// for example, the number of retransmissions.
    pub fn getQueryResultsWorkloadInsightsTopContributorsData(self: *Self, allocator: std.mem.Allocator, input: get_query_results_workload_insights_top_contributors_data.GetQueryResultsWorkloadInsightsTopContributorsDataInput, options: CallOptions) !get_query_results_workload_insights_top_contributors_data.GetQueryResultsWorkloadInsightsTopContributorsDataOutput {
        return get_query_results_workload_insights_top_contributors_data.execute(self, allocator, input, options);
    }

    /// Returns the current status of a query for the Network Flow Monitor query
    /// interface, for a specified query ID and monitor. This call returns the query
    /// status for the top contributors for a monitor.
    ///
    /// When you create a query, use this call to check the status of the query to
    /// make sure that it has has `SUCCEEDED` before you review the results. Use the
    /// same query ID that you used for the corresponding API call to start (create)
    /// the query, `StartQueryMonitorTopContributors`.
    ///
    /// When you run a query, use this call to check the status of the query to make
    /// sure that the query has `SUCCEEDED` before you review the results.
    pub fn getQueryStatusMonitorTopContributors(self: *Self, allocator: std.mem.Allocator, input: get_query_status_monitor_top_contributors.GetQueryStatusMonitorTopContributorsInput, options: CallOptions) !get_query_status_monitor_top_contributors.GetQueryStatusMonitorTopContributorsOutput {
        return get_query_status_monitor_top_contributors.execute(self, allocator, input, options);
    }

    /// Return the data for a query with the Network Flow Monitor query interface.
    /// Specify the query that you want to return results for by providing a query
    /// ID and a monitor name. This query returns the top contributors for workload
    /// insights.
    ///
    /// When you start a query, use this call to check the status of the query to
    /// make sure that it has has `SUCCEEDED` before you review the results. Use the
    /// same query ID that you used for the corresponding API call to start the
    /// query, `StartQueryWorkloadInsightsTopContributors`.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn getQueryStatusWorkloadInsightsTopContributors(self: *Self, allocator: std.mem.Allocator, input: get_query_status_workload_insights_top_contributors.GetQueryStatusWorkloadInsightsTopContributorsInput, options: CallOptions) !get_query_status_workload_insights_top_contributors.GetQueryStatusWorkloadInsightsTopContributorsOutput {
        return get_query_status_workload_insights_top_contributors.execute(self, allocator, input, options);
    }

    /// Returns the current status of a query for the Network Flow Monitor query
    /// interface, for a specified query ID and monitor. This call returns the query
    /// status for the top contributors data for workload insights.
    ///
    /// When you start a query, use this call to check the status of the query to
    /// make sure that it has has `SUCCEEDED` before you review the results. Use the
    /// same query ID that you used for the corresponding API call to start the
    /// query, `StartQueryWorkloadInsightsTopContributorsData`.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    ///
    /// The top contributor network flows overall are for a specific metric type,
    /// for example, the number of retransmissions.
    pub fn getQueryStatusWorkloadInsightsTopContributorsData(self: *Self, allocator: std.mem.Allocator, input: get_query_status_workload_insights_top_contributors_data.GetQueryStatusWorkloadInsightsTopContributorsDataInput, options: CallOptions) !get_query_status_workload_insights_top_contributors_data.GetQueryStatusWorkloadInsightsTopContributorsDataOutput {
        return get_query_status_workload_insights_top_contributors_data.execute(self, allocator, input, options);
    }

    /// Gets information about a scope, including the name, status, tags, and target
    /// details. The scope in Network Flow Monitor is an account.
    pub fn getScope(self: *Self, allocator: std.mem.Allocator, input: get_scope.GetScopeInput, options: CallOptions) !get_scope.GetScopeOutput {
        return get_scope.execute(self, allocator, input, options);
    }

    /// List all monitors in an account. Optionally, you can list only monitors that
    /// have a specific status, by using the `STATUS` parameter.
    pub fn listMonitors(self: *Self, allocator: std.mem.Allocator, input: list_monitors.ListMonitorsInput, options: CallOptions) !list_monitors.ListMonitorsOutput {
        return list_monitors.execute(self, allocator, input, options);
    }

    /// List all the scopes for an account.
    pub fn listScopes(self: *Self, allocator: std.mem.Allocator, input: list_scopes.ListScopesInput, options: CallOptions) !list_scopes.ListScopesOutput {
        return list_scopes.execute(self, allocator, input, options);
    }

    /// Returns all the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Create a query that you can use with the Network Flow Monitor query
    /// interface to return the top contributors for a monitor. Specify the monitor
    /// that you want to create the query for.
    ///
    /// The call returns a query ID that you can use with [
    /// GetQueryResultsMonitorTopContributors](https://docs.aws.amazon.com/networkflowmonitor/2.0/APIReference/API_GetQueryResultsMonitorTopContributors.html) to run the query and return the top contributors for a specific monitor.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable APIs for the top contributors that you want to be returned.
    pub fn startQueryMonitorTopContributors(self: *Self, allocator: std.mem.Allocator, input: start_query_monitor_top_contributors.StartQueryMonitorTopContributorsInput, options: CallOptions) !start_query_monitor_top_contributors.StartQueryMonitorTopContributorsOutput {
        return start_query_monitor_top_contributors.execute(self, allocator, input, options);
    }

    /// Create a query with the Network Flow Monitor query interface that you can
    /// run to return workload insights top contributors. Specify the scope that you
    /// want to create a query for.
    ///
    /// The call returns a query ID that you can use with [
    /// GetQueryResultsWorkloadInsightsTopContributors](https://docs.aws.amazon.com/networkflowmonitor/2.0/APIReference/API_GetQueryResultsWorkloadInsightsTopContributors.html) to run the query and return the top contributors for the workload insights for a scope.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable APIs for the top contributors that you want to be returned.
    pub fn startQueryWorkloadInsightsTopContributors(self: *Self, allocator: std.mem.Allocator, input: start_query_workload_insights_top_contributors.StartQueryWorkloadInsightsTopContributorsInput, options: CallOptions) !start_query_workload_insights_top_contributors.StartQueryWorkloadInsightsTopContributorsOutput {
        return start_query_workload_insights_top_contributors.execute(self, allocator, input, options);
    }

    /// Create a query with the Network Flow Monitor query interface that you can
    /// run to return data for workload insights top contributors. Specify the scope
    /// that you want to create a query for.
    ///
    /// The call returns a query ID that you can use with [
    /// GetQueryResultsWorkloadInsightsTopContributorsData](https://docs.aws.amazon.com/networkflowmonitor/2.0/APIReference/API_GetQueryResultsWorkloadInsightsTopContributorsData.html) to run the query and return the data for the top contributors for the workload insights for a scope.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn startQueryWorkloadInsightsTopContributorsData(self: *Self, allocator: std.mem.Allocator, input: start_query_workload_insights_top_contributors_data.StartQueryWorkloadInsightsTopContributorsDataInput, options: CallOptions) !start_query_workload_insights_top_contributors_data.StartQueryWorkloadInsightsTopContributorsDataOutput {
        return start_query_workload_insights_top_contributors_data.execute(self, allocator, input, options);
    }

    /// Stop a top contributors query for a monitor. Specify the query that you want
    /// to stop by providing a query ID and a monitor name.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn stopQueryMonitorTopContributors(self: *Self, allocator: std.mem.Allocator, input: stop_query_monitor_top_contributors.StopQueryMonitorTopContributorsInput, options: CallOptions) !stop_query_monitor_top_contributors.StopQueryMonitorTopContributorsOutput {
        return stop_query_monitor_top_contributors.execute(self, allocator, input, options);
    }

    /// Stop a top contributors query for workload insights. Specify the query that
    /// you want to stop by providing a query ID and a scope ID.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn stopQueryWorkloadInsightsTopContributors(self: *Self, allocator: std.mem.Allocator, input: stop_query_workload_insights_top_contributors.StopQueryWorkloadInsightsTopContributorsInput, options: CallOptions) !stop_query_workload_insights_top_contributors.StopQueryWorkloadInsightsTopContributorsOutput {
        return stop_query_workload_insights_top_contributors.execute(self, allocator, input, options);
    }

    /// Stop a top contributors data query for workload insights. Specify the query
    /// that you want to stop by providing a query ID and a scope ID.
    ///
    /// Top contributors in Network Flow Monitor are network flows with the highest
    /// values for a specific metric type. Top contributors can be across all
    /// workload insights, for a given scope, or for a specific monitor. Use the
    /// applicable call for the top contributors that you want to be returned.
    pub fn stopQueryWorkloadInsightsTopContributorsData(self: *Self, allocator: std.mem.Allocator, input: stop_query_workload_insights_top_contributors_data.StopQueryWorkloadInsightsTopContributorsDataInput, options: CallOptions) !stop_query_workload_insights_top_contributors_data.StopQueryWorkloadInsightsTopContributorsDataOutput {
        return stop_query_workload_insights_top_contributors_data.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update a monitor to add or remove local or remote resources.
    pub fn updateMonitor(self: *Self, allocator: std.mem.Allocator, input: update_monitor.UpdateMonitorInput, options: CallOptions) !update_monitor.UpdateMonitorOutput {
        return update_monitor.execute(self, allocator, input, options);
    }

    /// Update a scope to add or remove resources that you want to be available for
    /// Network Flow Monitor to generate metrics for, when you have active agents on
    /// those resources sending metrics reports to the Network Flow Monitor backend.
    pub fn updateScope(self: *Self, allocator: std.mem.Allocator, input: update_scope.UpdateScopeInput, options: CallOptions) !update_scope.UpdateScopeOutput {
        return update_scope.execute(self, allocator, input, options);
    }

    pub fn getQueryResultsMonitorTopContributorsPaginator(self: *Self, params: get_query_results_monitor_top_contributors.GetQueryResultsMonitorTopContributorsInput) paginator.GetQueryResultsMonitorTopContributorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getQueryResultsWorkloadInsightsTopContributorsPaginator(self: *Self, params: get_query_results_workload_insights_top_contributors.GetQueryResultsWorkloadInsightsTopContributorsInput) paginator.GetQueryResultsWorkloadInsightsTopContributorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getQueryResultsWorkloadInsightsTopContributorsDataPaginator(self: *Self, params: get_query_results_workload_insights_top_contributors_data.GetQueryResultsWorkloadInsightsTopContributorsDataInput) paginator.GetQueryResultsWorkloadInsightsTopContributorsDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitorsPaginator(self: *Self, params: list_monitors.ListMonitorsInput) paginator.ListMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScopesPaginator(self: *Self, params: list_scopes.ListScopesInput) paginator.ListScopesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
