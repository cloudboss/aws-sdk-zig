const aws = @import("aws");
const std = @import("std");

const cancel_export_task = @import("cancel_export_task.zig");
const cancel_import_task = @import("cancel_import_task.zig");
const cancel_query = @import("cancel_query.zig");
const create_graph = @import("create_graph.zig");
const create_graph_snapshot = @import("create_graph_snapshot.zig");
const create_graph_using_import_task = @import("create_graph_using_import_task.zig");
const create_private_graph_endpoint = @import("create_private_graph_endpoint.zig");
const delete_graph = @import("delete_graph.zig");
const delete_graph_snapshot = @import("delete_graph_snapshot.zig");
const delete_private_graph_endpoint = @import("delete_private_graph_endpoint.zig");
const execute_query = @import("execute_query.zig");
const get_export_task = @import("get_export_task.zig");
const get_graph = @import("get_graph.zig");
const get_graph_snapshot = @import("get_graph_snapshot.zig");
const get_graph_summary = @import("get_graph_summary.zig");
const get_import_task = @import("get_import_task.zig");
const get_private_graph_endpoint = @import("get_private_graph_endpoint.zig");
const get_query = @import("get_query.zig");
const list_export_tasks = @import("list_export_tasks.zig");
const list_graph_snapshots = @import("list_graph_snapshots.zig");
const list_graphs = @import("list_graphs.zig");
const list_import_tasks = @import("list_import_tasks.zig");
const list_private_graph_endpoints = @import("list_private_graph_endpoints.zig");
const list_queries = @import("list_queries.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reset_graph = @import("reset_graph.zig");
const restore_graph_from_snapshot = @import("restore_graph_from_snapshot.zig");
const start_export_task = @import("start_export_task.zig");
const start_graph = @import("start_graph.zig");
const start_import_task = @import("start_import_task.zig");
const stop_graph = @import("stop_graph.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_graph = @import("update_graph.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Neptune Graph";

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

    /// Cancel the specified export task.
    pub fn cancelExportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_export_task.CancelExportTaskInput, options: cancel_export_task.Options) !cancel_export_task.CancelExportTaskOutput {
        return cancel_export_task.execute(self, allocator, input, options);
    }

    /// Deletes the specified import task.
    pub fn cancelImportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_import_task.CancelImportTaskInput, options: cancel_import_task.Options) !cancel_import_task.CancelImportTaskOutput {
        return cancel_import_task.execute(self, allocator, input, options);
    }

    /// Cancels a specified query.
    pub fn cancelQuery(self: *Self, allocator: std.mem.Allocator, input: cancel_query.CancelQueryInput, options: cancel_query.Options) !cancel_query.CancelQueryOutput {
        return cancel_query.execute(self, allocator, input, options);
    }

    /// Creates a new Neptune Analytics graph.
    pub fn createGraph(self: *Self, allocator: std.mem.Allocator, input: create_graph.CreateGraphInput, options: create_graph.Options) !create_graph.CreateGraphOutput {
        return create_graph.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the specific graph.
    pub fn createGraphSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_graph_snapshot.CreateGraphSnapshotInput, options: create_graph_snapshot.Options) !create_graph_snapshot.CreateGraphSnapshotOutput {
        return create_graph_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a new Neptune Analytics graph and imports data into it, either from
    /// Amazon Simple Storage Service (S3) or from a Neptune database or a Neptune
    /// database snapshot.
    ///
    /// The data can be loaded from files in S3 that in either the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html) or the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html).
    pub fn createGraphUsingImportTask(self: *Self, allocator: std.mem.Allocator, input: create_graph_using_import_task.CreateGraphUsingImportTaskInput, options: create_graph_using_import_task.Options) !create_graph_using_import_task.CreateGraphUsingImportTaskOutput {
        return create_graph_using_import_task.execute(self, allocator, input, options);
    }

    /// Create a private graph endpoint to allow private access to the graph from
    /// within a VPC. You can attach security groups to the private graph endpoint.
    ///
    /// VPC endpoint charges apply.
    pub fn createPrivateGraphEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_private_graph_endpoint.CreatePrivateGraphEndpointInput, options: create_private_graph_endpoint.Options) !create_private_graph_endpoint.CreatePrivateGraphEndpointOutput {
        return create_private_graph_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the specified graph. Graphs cannot be deleted if delete-protection
    /// is enabled.
    pub fn deleteGraph(self: *Self, allocator: std.mem.Allocator, input: delete_graph.DeleteGraphInput, options: delete_graph.Options) !delete_graph.DeleteGraphOutput {
        return delete_graph.execute(self, allocator, input, options);
    }

    /// Deletes the specified graph snapshot.
    pub fn deleteGraphSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_graph_snapshot.DeleteGraphSnapshotInput, options: delete_graph_snapshot.Options) !delete_graph_snapshot.DeleteGraphSnapshotOutput {
        return delete_graph_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a private graph endpoint.
    pub fn deletePrivateGraphEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_private_graph_endpoint.DeletePrivateGraphEndpointInput, options: delete_private_graph_endpoint.Options) !delete_private_graph_endpoint.DeletePrivateGraphEndpointOutput {
        return delete_private_graph_endpoint.execute(self, allocator, input, options);
    }

    /// Execute an openCypher query.
    ///
    /// When invoking this operation in a Neptune Analytics cluster, the IAM user or
    /// role making the request must have a policy attached that allows one of the
    /// following IAM actions in that cluster, depending on the query:
    ///
    /// * neptune-graph:ReadDataViaQuery
    /// * neptune-graph:WriteDataViaQuery
    /// * neptune-graph:DeleteDataViaQuery
    pub fn executeQuery(self: *Self, allocator: std.mem.Allocator, input: execute_query.ExecuteQueryInput, options: execute_query.Options) !execute_query.ExecuteQueryOutput {
        return execute_query.execute(self, allocator, input, options);
    }

    /// Retrieves a specified export task.
    pub fn getExportTask(self: *Self, allocator: std.mem.Allocator, input: get_export_task.GetExportTaskInput, options: get_export_task.Options) !get_export_task.GetExportTaskOutput {
        return get_export_task.execute(self, allocator, input, options);
    }

    /// Gets information about a specified graph.
    pub fn getGraph(self: *Self, allocator: std.mem.Allocator, input: get_graph.GetGraphInput, options: get_graph.Options) !get_graph.GetGraphOutput {
        return get_graph.execute(self, allocator, input, options);
    }

    /// Retrieves a specified graph snapshot.
    pub fn getGraphSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_graph_snapshot.GetGraphSnapshotInput, options: get_graph_snapshot.Options) !get_graph_snapshot.GetGraphSnapshotOutput {
        return get_graph_snapshot.execute(self, allocator, input, options);
    }

    /// Gets a graph summary for a property graph.
    pub fn getGraphSummary(self: *Self, allocator: std.mem.Allocator, input: get_graph_summary.GetGraphSummaryInput, options: get_graph_summary.Options) !get_graph_summary.GetGraphSummaryOutput {
        return get_graph_summary.execute(self, allocator, input, options);
    }

    /// Retrieves a specified import task.
    pub fn getImportTask(self: *Self, allocator: std.mem.Allocator, input: get_import_task.GetImportTaskInput, options: get_import_task.Options) !get_import_task.GetImportTaskOutput {
        return get_import_task.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified private endpoint.
    pub fn getPrivateGraphEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_private_graph_endpoint.GetPrivateGraphEndpointInput, options: get_private_graph_endpoint.Options) !get_private_graph_endpoint.GetPrivateGraphEndpointOutput {
        return get_private_graph_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves the status of a specified query.
    ///
    /// When invoking this operation in a Neptune Analytics cluster, the IAM user or
    /// role making the request must have the `neptune-graph:GetQueryStatus` IAM
    /// action attached.
    pub fn getQuery(self: *Self, allocator: std.mem.Allocator, input: get_query.GetQueryInput, options: get_query.Options) !get_query.GetQueryOutput {
        return get_query.execute(self, allocator, input, options);
    }

    /// Retrieves a list of export tasks.
    pub fn listExportTasks(self: *Self, allocator: std.mem.Allocator, input: list_export_tasks.ListExportTasksInput, options: list_export_tasks.Options) !list_export_tasks.ListExportTasksOutput {
        return list_export_tasks.execute(self, allocator, input, options);
    }

    /// Lists available snapshots of a specified Neptune Analytics graph.
    pub fn listGraphSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_graph_snapshots.ListGraphSnapshotsInput, options: list_graph_snapshots.Options) !list_graph_snapshots.ListGraphSnapshotsOutput {
        return list_graph_snapshots.execute(self, allocator, input, options);
    }

    /// Lists available Neptune Analytics graphs.
    pub fn listGraphs(self: *Self, allocator: std.mem.Allocator, input: list_graphs.ListGraphsInput, options: list_graphs.Options) !list_graphs.ListGraphsOutput {
        return list_graphs.execute(self, allocator, input, options);
    }

    /// Lists import tasks.
    pub fn listImportTasks(self: *Self, allocator: std.mem.Allocator, input: list_import_tasks.ListImportTasksInput, options: list_import_tasks.Options) !list_import_tasks.ListImportTasksOutput {
        return list_import_tasks.execute(self, allocator, input, options);
    }

    /// Lists private endpoints for a specified Neptune Analytics graph.
    pub fn listPrivateGraphEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_private_graph_endpoints.ListPrivateGraphEndpointsInput, options: list_private_graph_endpoints.Options) !list_private_graph_endpoints.ListPrivateGraphEndpointsOutput {
        return list_private_graph_endpoints.execute(self, allocator, input, options);
    }

    /// Lists active openCypher queries.
    pub fn listQueries(self: *Self, allocator: std.mem.Allocator, input: list_queries.ListQueriesInput, options: list_queries.Options) !list_queries.ListQueriesOutput {
        return list_queries.execute(self, allocator, input, options);
    }

    /// Lists tags associated with a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Empties the data from a specified Neptune Analytics graph.
    pub fn resetGraph(self: *Self, allocator: std.mem.Allocator, input: reset_graph.ResetGraphInput, options: reset_graph.Options) !reset_graph.ResetGraphOutput {
        return reset_graph.execute(self, allocator, input, options);
    }

    /// Restores a graph from a snapshot.
    pub fn restoreGraphFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_graph_from_snapshot.RestoreGraphFromSnapshotInput, options: restore_graph_from_snapshot.Options) !restore_graph_from_snapshot.RestoreGraphFromSnapshotOutput {
        return restore_graph_from_snapshot.execute(self, allocator, input, options);
    }

    /// Export data from an existing Neptune Analytics graph to Amazon S3. The graph
    /// state should be `AVAILABLE`.
    pub fn startExportTask(self: *Self, allocator: std.mem.Allocator, input: start_export_task.StartExportTaskInput, options: start_export_task.Options) !start_export_task.StartExportTaskOutput {
        return start_export_task.execute(self, allocator, input, options);
    }

    /// Starts the specific graph.
    pub fn startGraph(self: *Self, allocator: std.mem.Allocator, input: start_graph.StartGraphInput, options: start_graph.Options) !start_graph.StartGraphOutput {
        return start_graph.execute(self, allocator, input, options);
    }

    /// Import data into existing Neptune Analytics graph from Amazon Simple Storage
    /// Service (S3). The graph needs to be empty and in the AVAILABLE state.
    pub fn startImportTask(self: *Self, allocator: std.mem.Allocator, input: start_import_task.StartImportTaskInput, options: start_import_task.Options) !start_import_task.StartImportTaskOutput {
        return start_import_task.execute(self, allocator, input, options);
    }

    /// Stops the specific graph.
    pub fn stopGraph(self: *Self, allocator: std.mem.Allocator, input: stop_graph.StopGraphInput, options: stop_graph.Options) !stop_graph.StopGraphOutput {
        return stop_graph.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a specified Neptune Analytics graph
    pub fn updateGraph(self: *Self, allocator: std.mem.Allocator, input: update_graph.UpdateGraphInput, options: update_graph.Options) !update_graph.UpdateGraphOutput {
        return update_graph.execute(self, allocator, input, options);
    }

    pub fn listExportTasksPaginator(self: *Self, params: list_export_tasks.ListExportTasksInput) paginator.ListExportTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGraphSnapshotsPaginator(self: *Self, params: list_graph_snapshots.ListGraphSnapshotsInput) paginator.ListGraphSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGraphsPaginator(self: *Self, params: list_graphs.ListGraphsInput) paginator.ListGraphsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImportTasksPaginator(self: *Self, params: list_import_tasks.ListImportTasksInput) paginator.ListImportTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrivateGraphEndpointsPaginator(self: *Self, params: list_private_graph_endpoints.ListPrivateGraphEndpointsInput) paginator.ListPrivateGraphEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilExportTaskCancelled(self: *Self, params: get_export_task.GetExportTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.ExportTaskCancelledWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilExportTaskSuccessful(self: *Self, params: get_export_task.GetExportTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.ExportTaskSuccessfulWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilGraphAvailable(self: *Self, params: get_graph.GetGraphInput) aws.waiter.WaiterError!void {
        var w = waiters.GraphAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilGraphDeleted(self: *Self, params: get_graph.GetGraphInput) aws.waiter.WaiterError!void {
        var w = waiters.GraphDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilGraphSnapshotAvailable(self: *Self, params: get_graph_snapshot.GetGraphSnapshotInput) aws.waiter.WaiterError!void {
        var w = waiters.GraphSnapshotAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilGraphSnapshotDeleted(self: *Self, params: get_graph_snapshot.GetGraphSnapshotInput) aws.waiter.WaiterError!void {
        var w = waiters.GraphSnapshotDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilGraphStopped(self: *Self, params: get_graph.GetGraphInput) aws.waiter.WaiterError!void {
        var w = waiters.GraphStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImportTaskCancelled(self: *Self, params: get_import_task.GetImportTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.ImportTaskCancelledWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilImportTaskSuccessful(self: *Self, params: get_import_task.GetImportTaskInput) aws.waiter.WaiterError!void {
        var w = waiters.ImportTaskSuccessfulWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPrivateGraphEndpointAvailable(self: *Self, params: get_private_graph_endpoint.GetPrivateGraphEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.PrivateGraphEndpointAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPrivateGraphEndpointDeleted(self: *Self, params: get_private_graph_endpoint.GetPrivateGraphEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.PrivateGraphEndpointDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
