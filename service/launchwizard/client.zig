const aws = @import("aws");
const std = @import("std");

const create_deployment = @import("create_deployment.zig");
const delete_deployment = @import("delete_deployment.zig");
const get_deployment = @import("get_deployment.zig");
const get_deployment_pattern_version = @import("get_deployment_pattern_version.zig");
const get_workload = @import("get_workload.zig");
const get_workload_deployment_pattern = @import("get_workload_deployment_pattern.zig");
const list_deployment_events = @import("list_deployment_events.zig");
const list_deployment_pattern_versions = @import("list_deployment_pattern_versions.zig");
const list_deployments = @import("list_deployments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workload_deployment_patterns = @import("list_workload_deployment_patterns.zig");
const list_workloads = @import("list_workloads.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_deployment = @import("update_deployment.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Launch Wizard";

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

    /// Creates a deployment for the given workload. Deployments created by this
    /// operation are not available in the Launch Wizard console to use the `Clone
    /// deployment` action on.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: CallOptions) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Deletes a deployment.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: CallOptions) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Returns information about the deployment.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: CallOptions) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Returns information about a deployment pattern version.
    pub fn getDeploymentPatternVersion(self: *Self, allocator: std.mem.Allocator, input: get_deployment_pattern_version.GetDeploymentPatternVersionInput, options: CallOptions) !get_deployment_pattern_version.GetDeploymentPatternVersionOutput {
        return get_deployment_pattern_version.execute(self, allocator, input, options);
    }

    /// Returns information about a workload.
    pub fn getWorkload(self: *Self, allocator: std.mem.Allocator, input: get_workload.GetWorkloadInput, options: CallOptions) !get_workload.GetWorkloadOutput {
        return get_workload.execute(self, allocator, input, options);
    }

    /// Returns details for a given workload and deployment pattern, including the
    /// available specifications. You can use the
    /// [ListWorkloads](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloads.html) operation to discover the available workload names and the [ListWorkloadDeploymentPatterns](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloadDeploymentPatterns.html) operation to discover the available deployment pattern names of a given workload.
    pub fn getWorkloadDeploymentPattern(self: *Self, allocator: std.mem.Allocator, input: get_workload_deployment_pattern.GetWorkloadDeploymentPatternInput, options: CallOptions) !get_workload_deployment_pattern.GetWorkloadDeploymentPatternOutput {
        return get_workload_deployment_pattern.execute(self, allocator, input, options);
    }

    /// Lists the events of a deployment.
    pub fn listDeploymentEvents(self: *Self, allocator: std.mem.Allocator, input: list_deployment_events.ListDeploymentEventsInput, options: CallOptions) !list_deployment_events.ListDeploymentEventsOutput {
        return list_deployment_events.execute(self, allocator, input, options);
    }

    /// Lists the deployment pattern versions.
    pub fn listDeploymentPatternVersions(self: *Self, allocator: std.mem.Allocator, input: list_deployment_pattern_versions.ListDeploymentPatternVersionsInput, options: CallOptions) !list_deployment_pattern_versions.ListDeploymentPatternVersionsOutput {
        return list_deployment_pattern_versions.execute(self, allocator, input, options);
    }

    /// Lists the deployments that have been created.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: CallOptions) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the workload deployment patterns for a given workload name. You can
    /// use the
    /// [ListWorkloads](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloads.html) operation to discover the available workload names.
    pub fn listWorkloadDeploymentPatterns(self: *Self, allocator: std.mem.Allocator, input: list_workload_deployment_patterns.ListWorkloadDeploymentPatternsInput, options: CallOptions) !list_workload_deployment_patterns.ListWorkloadDeploymentPatternsOutput {
        return list_workload_deployment_patterns.execute(self, allocator, input, options);
    }

    /// Lists the available workload names. You can use the
    /// [ListWorkloadDeploymentPatterns](https://docs.aws.amazon.com/launchwizard/latest/APIReference/API_ListWorkloadDeploymentPatterns.html) operation to discover the available deployment patterns for a given workload.
    pub fn listWorkloads(self: *Self, allocator: std.mem.Allocator, input: list_workloads.ListWorkloadsInput, options: CallOptions) !list_workloads.ListWorkloadsOutput {
        return list_workloads.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the given resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the given resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a deployment.
    pub fn updateDeployment(self: *Self, allocator: std.mem.Allocator, input: update_deployment.UpdateDeploymentInput, options: CallOptions) !update_deployment.UpdateDeploymentOutput {
        return update_deployment.execute(self, allocator, input, options);
    }

    pub fn listDeploymentEventsPaginator(self: *Self, params: list_deployment_events.ListDeploymentEventsInput) paginator.ListDeploymentEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentPatternVersionsPaginator(self: *Self, params: list_deployment_pattern_versions.ListDeploymentPatternVersionsInput) paginator.ListDeploymentPatternVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentsPaginator(self: *Self, params: list_deployments.ListDeploymentsInput) paginator.ListDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkloadDeploymentPatternsPaginator(self: *Self, params: list_workload_deployment_patterns.ListWorkloadDeploymentPatternsInput) paginator.ListWorkloadDeploymentPatternsPaginator {
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
