const aws = @import("aws");
const std = @import("std");

const create_rescore_execution_plan = @import("create_rescore_execution_plan.zig");
const delete_rescore_execution_plan = @import("delete_rescore_execution_plan.zig");
const describe_rescore_execution_plan = @import("describe_rescore_execution_plan.zig");
const list_rescore_execution_plans = @import("list_rescore_execution_plans.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const rescore_ = @import("rescore.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_rescore_execution_plan = @import("update_rescore_execution_plan.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kendra Ranking";

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

    /// Creates a rescore execution plan. A rescore execution
    /// plan is an Amazon Kendra Intelligent Ranking resource
    /// used for provisioning the `Rescore` API. You set
    /// the number of capacity units that you require for
    /// Amazon Kendra Intelligent Ranking to rescore or re-rank
    /// a search service's results.
    ///
    /// For an example of using the
    /// `CreateRescoreExecutionPlan` API, including using
    /// the Python and Java SDKs, see [Semantically
    /// ranking a search service's
    /// results](https://docs.aws.amazon.com/kendra/latest/dg/search-service-rerank.html).
    pub fn createRescoreExecutionPlan(self: *Self, allocator: std.mem.Allocator, input: create_rescore_execution_plan.CreateRescoreExecutionPlanInput, options: create_rescore_execution_plan.Options) !create_rescore_execution_plan.CreateRescoreExecutionPlanOutput {
        return create_rescore_execution_plan.execute(self, allocator, input, options);
    }

    /// Deletes a rescore execution plan. A rescore execution
    /// plan is an Amazon Kendra Intelligent Ranking resource
    /// used for provisioning the `Rescore` API.
    pub fn deleteRescoreExecutionPlan(self: *Self, allocator: std.mem.Allocator, input: delete_rescore_execution_plan.DeleteRescoreExecutionPlanInput, options: delete_rescore_execution_plan.Options) !delete_rescore_execution_plan.DeleteRescoreExecutionPlanOutput {
        return delete_rescore_execution_plan.execute(self, allocator, input, options);
    }

    /// Gets information about a rescore execution plan. A rescore
    /// execution plan is an Amazon Kendra Intelligent Ranking
    /// resource used for provisioning the `Rescore` API.
    pub fn describeRescoreExecutionPlan(self: *Self, allocator: std.mem.Allocator, input: describe_rescore_execution_plan.DescribeRescoreExecutionPlanInput, options: describe_rescore_execution_plan.Options) !describe_rescore_execution_plan.DescribeRescoreExecutionPlanOutput {
        return describe_rescore_execution_plan.execute(self, allocator, input, options);
    }

    /// Lists your rescore execution plans. A rescore execution plan
    /// is an Amazon Kendra Intelligent Ranking resource used for
    /// provisioning the `Rescore` API.
    pub fn listRescoreExecutionPlans(self: *Self, allocator: std.mem.Allocator, input: list_rescore_execution_plans.ListRescoreExecutionPlansInput, options: list_rescore_execution_plans.Options) !list_rescore_execution_plans.ListRescoreExecutionPlansOutput {
        return list_rescore_execution_plans.execute(self, allocator, input, options);
    }

    /// Gets a list of tags associated with a specified resource.
    /// A rescore execution plan is an example of a resource that
    /// can have tags associated with it.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rescores or re-ranks search results from a search service
    /// such as OpenSearch (self managed). You use the semantic search
    /// capabilities of Amazon Kendra Intelligent Ranking to
    /// improve the search service's results.
    pub fn rescore(self: *Self, allocator: std.mem.Allocator, input: rescore_.RescoreInput, options: rescore_.Options) !rescore_.RescoreOutput {
        return rescore_.execute(self, allocator, input, options);
    }

    /// Adds a specified tag to a specified rescore execution
    /// plan. A rescore execution plan is an Amazon Kendra
    /// Intelligent Ranking resource used for provisioning the
    /// `Rescore` API. If the tag already exists,
    /// the existing value is replaced with the new value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a rescore execution plan. A rescore
    /// execution plan is an Amazon Kendra Intelligent
    /// Ranking resource used for provisioning the
    /// `Rescore` operation.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a rescore execution plan. A rescore execution plan
    /// is an Amazon Kendra Intelligent Ranking resource used for
    /// provisioning the `Rescore` API. You can update the
    /// number of capacity units you require for Amazon Kendra
    /// Intelligent Ranking to rescore or re-rank a search service's
    /// results.
    pub fn updateRescoreExecutionPlan(self: *Self, allocator: std.mem.Allocator, input: update_rescore_execution_plan.UpdateRescoreExecutionPlanInput, options: update_rescore_execution_plan.Options) !update_rescore_execution_plan.UpdateRescoreExecutionPlanOutput {
        return update_rescore_execution_plan.execute(self, allocator, input, options);
    }

    pub fn listRescoreExecutionPlansPaginator(self: *Self, params: list_rescore_execution_plans.ListRescoreExecutionPlansInput) paginator.ListRescoreExecutionPlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
