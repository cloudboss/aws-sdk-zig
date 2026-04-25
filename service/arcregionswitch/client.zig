const aws = @import("aws");
const std = @import("std");

const approve_plan_execution_step = @import("approve_plan_execution_step.zig");
const cancel_plan_execution = @import("cancel_plan_execution.zig");
const create_plan = @import("create_plan.zig");
const delete_plan = @import("delete_plan.zig");
const get_plan = @import("get_plan.zig");
const get_plan_evaluation_status = @import("get_plan_evaluation_status.zig");
const get_plan_execution = @import("get_plan_execution.zig");
const get_plan_in_region = @import("get_plan_in_region.zig");
const list_plan_execution_events = @import("list_plan_execution_events.zig");
const list_plan_executions = @import("list_plan_executions.zig");
const list_plans = @import("list_plans.zig");
const list_plans_in_region = @import("list_plans_in_region.zig");
const list_route_53_health_checks = @import("list_route_53_health_checks.zig");
const list_route_53_health_checks_in_region = @import("list_route_53_health_checks_in_region.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_plan_execution = @import("start_plan_execution.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_plan = @import("update_plan.zig");
const update_plan_execution = @import("update_plan_execution.zig");
const update_plan_execution_step = @import("update_plan_execution_step.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ARC Region switch";

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

    /// Approves a step in a plan execution that requires manual approval. When you
    /// create a plan, you can include approval steps that require manual
    /// intervention before the execution can proceed. This operation allows you to
    /// provide that approval.
    ///
    /// You must specify the plan ARN, execution ID, step name, and approval status.
    /// You can also provide an optional comment explaining the approval decision.
    pub fn approvePlanExecutionStep(self: *Self, allocator: std.mem.Allocator, input: approve_plan_execution_step.ApprovePlanExecutionStepInput, options: CallOptions) !approve_plan_execution_step.ApprovePlanExecutionStepOutput {
        return approve_plan_execution_step.execute(self, allocator, input, options);
    }

    /// Cancels an in-progress plan execution. This operation stops the execution of
    /// the plan and prevents any further steps from being processed.
    ///
    /// You must specify the plan ARN and execution ID. You can also provide an
    /// optional comment explaining why the execution was canceled.
    pub fn cancelPlanExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_plan_execution.CancelPlanExecutionInput, options: CallOptions) !cancel_plan_execution.CancelPlanExecutionOutput {
        return cancel_plan_execution.execute(self, allocator, input, options);
    }

    /// Creates a new Region switch plan. A plan defines the steps required to shift
    /// traffic from one Amazon Web Services Region to another.
    ///
    /// You must specify a name for the plan, the primary Region, and at least one
    /// additional Region. You can also provide a description, execution role,
    /// recovery time objective, associated alarms, triggers, and workflows that
    /// define the steps to execute during a Region switch.
    pub fn createPlan(self: *Self, allocator: std.mem.Allocator, input: create_plan.CreatePlanInput, options: CallOptions) !create_plan.CreatePlanOutput {
        return create_plan.execute(self, allocator, input, options);
    }

    /// Deletes a Region switch plan. You must specify the ARN of the plan to
    /// delete.
    ///
    /// You cannot delete a plan that has an active execution in progress.
    pub fn deletePlan(self: *Self, allocator: std.mem.Allocator, input: delete_plan.DeletePlanInput, options: CallOptions) !delete_plan.DeletePlanOutput {
        return delete_plan.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a Region switch plan. You must specify
    /// the ARN of the plan.
    pub fn getPlan(self: *Self, allocator: std.mem.Allocator, input: get_plan.GetPlanInput, options: CallOptions) !get_plan.GetPlanOutput {
        return get_plan.execute(self, allocator, input, options);
    }

    /// Retrieves the evaluation status of a Region switch plan. The evaluation
    /// status provides information about the last time the plan was evaluated and
    /// any warnings or issues detected.
    pub fn getPlanEvaluationStatus(self: *Self, allocator: std.mem.Allocator, input: get_plan_evaluation_status.GetPlanEvaluationStatusInput, options: CallOptions) !get_plan_evaluation_status.GetPlanEvaluationStatusOutput {
        return get_plan_evaluation_status.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific plan execution. You must
    /// specify the plan ARN and execution ID.
    pub fn getPlanExecution(self: *Self, allocator: std.mem.Allocator, input: get_plan_execution.GetPlanExecutionInput, options: CallOptions) !get_plan_execution.GetPlanExecutionOutput {
        return get_plan_execution.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Region switch plan in a specific Amazon Web
    /// Services Region. This operation is useful for getting Region-specific
    /// information about a plan.
    pub fn getPlanInRegion(self: *Self, allocator: std.mem.Allocator, input: get_plan_in_region.GetPlanInRegionInput, options: CallOptions) !get_plan_in_region.GetPlanInRegionOutput {
        return get_plan_in_region.execute(self, allocator, input, options);
    }

    /// Lists the events that occurred during a plan execution. These events provide
    /// a detailed timeline of the execution process.
    pub fn listPlanExecutionEvents(self: *Self, allocator: std.mem.Allocator, input: list_plan_execution_events.ListPlanExecutionEventsInput, options: CallOptions) !list_plan_execution_events.ListPlanExecutionEventsOutput {
        return list_plan_execution_events.execute(self, allocator, input, options);
    }

    /// Lists the executions of a Region switch plan. This operation returns
    /// information about both current and historical executions.
    pub fn listPlanExecutions(self: *Self, allocator: std.mem.Allocator, input: list_plan_executions.ListPlanExecutionsInput, options: CallOptions) !list_plan_executions.ListPlanExecutionsOutput {
        return list_plan_executions.execute(self, allocator, input, options);
    }

    /// Lists all Region switch plans in your Amazon Web Services account.
    pub fn listPlans(self: *Self, allocator: std.mem.Allocator, input: list_plans.ListPlansInput, options: CallOptions) !list_plans.ListPlansOutput {
        return list_plans.execute(self, allocator, input, options);
    }

    /// Lists all Region switch plans in your Amazon Web Services account that are
    /// available in the current Amazon Web Services Region.
    pub fn listPlansInRegion(self: *Self, allocator: std.mem.Allocator, input: list_plans_in_region.ListPlansInRegionInput, options: CallOptions) !list_plans_in_region.ListPlansInRegionOutput {
        return list_plans_in_region.execute(self, allocator, input, options);
    }

    /// List the Amazon Route 53 health checks.
    pub fn listRoute53HealthChecks(self: *Self, allocator: std.mem.Allocator, input: list_route_53_health_checks.ListRoute53HealthChecksInput, options: CallOptions) !list_route_53_health_checks.ListRoute53HealthChecksOutput {
        return list_route_53_health_checks.execute(self, allocator, input, options);
    }

    /// List the Amazon Route 53 health checks in a specific Amazon Web Services
    /// Region.
    pub fn listRoute53HealthChecksInRegion(self: *Self, allocator: std.mem.Allocator, input: list_route_53_health_checks_in_region.ListRoute53HealthChecksInRegionInput, options: CallOptions) !list_route_53_health_checks_in_region.ListRoute53HealthChecksInRegionOutput {
        return list_route_53_health_checks_in_region.execute(self, allocator, input, options);
    }

    /// Lists the tags attached to a Region switch resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts the execution of a Region switch plan. You can execute a plan in
    /// either `graceful` or `ungraceful` mode.
    ///
    /// Specifing `ungraceful` mode either changes the behavior of the execution
    /// blocks in a workflow or skips specific execution blocks.
    pub fn startPlanExecution(self: *Self, allocator: std.mem.Allocator, input: start_plan_execution.StartPlanExecutionInput, options: CallOptions) !start_plan_execution.StartPlanExecutionOutput {
        return start_plan_execution.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a Region switch resource. You can assign metadata
    /// to your resources in the form of tags, which are key-value pairs.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a Region switch resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Region switch plan. You can modify the plan's
    /// description, workflows, execution role, recovery time objective, associated
    /// alarms, and triggers.
    pub fn updatePlan(self: *Self, allocator: std.mem.Allocator, input: update_plan.UpdatePlanInput, options: CallOptions) !update_plan.UpdatePlanOutput {
        return update_plan.execute(self, allocator, input, options);
    }

    /// Updates an in-progress plan execution. This operation allows you to modify
    /// certain aspects of the execution, such as adding a comment or changing the
    /// action.
    pub fn updatePlanExecution(self: *Self, allocator: std.mem.Allocator, input: update_plan_execution.UpdatePlanExecutionInput, options: CallOptions) !update_plan_execution.UpdatePlanExecutionOutput {
        return update_plan_execution.execute(self, allocator, input, options);
    }

    /// Updates a specific step in an in-progress plan execution. This operation
    /// allows you to modify the step's comment or action.
    pub fn updatePlanExecutionStep(self: *Self, allocator: std.mem.Allocator, input: update_plan_execution_step.UpdatePlanExecutionStepInput, options: CallOptions) !update_plan_execution_step.UpdatePlanExecutionStepOutput {
        return update_plan_execution_step.execute(self, allocator, input, options);
    }

    pub fn getPlanEvaluationStatusPaginator(self: *Self, params: get_plan_evaluation_status.GetPlanEvaluationStatusInput) paginator.GetPlanEvaluationStatusPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getPlanExecutionPaginator(self: *Self, params: get_plan_execution.GetPlanExecutionInput) paginator.GetPlanExecutionPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPlanExecutionEventsPaginator(self: *Self, params: list_plan_execution_events.ListPlanExecutionEventsInput) paginator.ListPlanExecutionEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPlanExecutionsPaginator(self: *Self, params: list_plan_executions.ListPlanExecutionsInput) paginator.ListPlanExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPlansPaginator(self: *Self, params: list_plans.ListPlansInput) paginator.ListPlansPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPlansInRegionPaginator(self: *Self, params: list_plans_in_region.ListPlansInRegionInput) paginator.ListPlansInRegionPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRoute53HealthChecksPaginator(self: *Self, params: list_route_53_health_checks.ListRoute53HealthChecksInput) paginator.ListRoute53HealthChecksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRoute53HealthChecksInRegionPaginator(self: *Self, params: list_route_53_health_checks_in_region.ListRoute53HealthChecksInRegionInput) paginator.ListRoute53HealthChecksInRegionPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilPlanEvaluationStatusPassed(self: *Self, params: get_plan_evaluation_status.GetPlanEvaluationStatusInput) aws.waiter.WaiterError!void {
        var w = waiters.PlanEvaluationStatusPassedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilPlanExecutionCompleted(self: *Self, params: get_plan_execution.GetPlanExecutionInput) aws.waiter.WaiterError!void {
        var w = waiters.PlanExecutionCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
