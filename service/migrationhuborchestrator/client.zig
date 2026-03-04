const aws = @import("aws");
const std = @import("std");

const create_template = @import("create_template.zig");
const create_workflow = @import("create_workflow.zig");
const create_workflow_step = @import("create_workflow_step.zig");
const create_workflow_step_group = @import("create_workflow_step_group.zig");
const delete_template = @import("delete_template.zig");
const delete_workflow = @import("delete_workflow.zig");
const delete_workflow_step = @import("delete_workflow_step.zig");
const delete_workflow_step_group = @import("delete_workflow_step_group.zig");
const get_template = @import("get_template.zig");
const get_template_step = @import("get_template_step.zig");
const get_template_step_group = @import("get_template_step_group.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_step = @import("get_workflow_step.zig");
const get_workflow_step_group = @import("get_workflow_step_group.zig");
const list_plugins = @import("list_plugins.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_step_groups = @import("list_template_step_groups.zig");
const list_template_steps = @import("list_template_steps.zig");
const list_templates = @import("list_templates.zig");
const list_workflow_step_groups = @import("list_workflow_step_groups.zig");
const list_workflow_steps = @import("list_workflow_steps.zig");
const list_workflows = @import("list_workflows.zig");
const retry_workflow_step = @import("retry_workflow_step.zig");
const start_workflow = @import("start_workflow.zig");
const stop_workflow = @import("stop_workflow.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_template = @import("update_template.zig");
const update_workflow = @import("update_workflow.zig");
const update_workflow_step = @import("update_workflow_step.zig");
const update_workflow_step_group = @import("update_workflow_step_group.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MigrationHubOrchestrator";

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

    /// Creates a migration workflow template.
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: CallOptions) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// Create a workflow to orchestrate your migrations.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: CallOptions) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Create a step in the migration workflow.
    pub fn createWorkflowStep(self: *Self, allocator: std.mem.Allocator, input: create_workflow_step.CreateWorkflowStepInput, options: CallOptions) !create_workflow_step.CreateWorkflowStepOutput {
        return create_workflow_step.execute(self, allocator, input, options);
    }

    /// Create a step group in a migration workflow.
    pub fn createWorkflowStepGroup(self: *Self, allocator: std.mem.Allocator, input: create_workflow_step_group.CreateWorkflowStepGroupInput, options: CallOptions) !create_workflow_step_group.CreateWorkflowStepGroupOutput {
        return create_workflow_step_group.execute(self, allocator, input, options);
    }

    /// Deletes a migration workflow template.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: CallOptions) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Delete a migration workflow. You must pause a running workflow in Migration
    /// Hub Orchestrator console to
    /// delete it.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: CallOptions) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// Delete a step in a migration workflow. Pause the workflow to delete a
    /// running
    /// step.
    pub fn deleteWorkflowStep(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_step.DeleteWorkflowStepInput, options: CallOptions) !delete_workflow_step.DeleteWorkflowStepOutput {
        return delete_workflow_step.execute(self, allocator, input, options);
    }

    /// Delete a step group in a migration workflow.
    pub fn deleteWorkflowStepGroup(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_step_group.DeleteWorkflowStepGroupInput, options: CallOptions) !delete_workflow_step_group.DeleteWorkflowStepGroupOutput {
        return delete_workflow_step_group.execute(self, allocator, input, options);
    }

    /// Get the template you want to use for creating a migration workflow.
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: CallOptions) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Get a specific step in a template.
    pub fn getTemplateStep(self: *Self, allocator: std.mem.Allocator, input: get_template_step.GetTemplateStepInput, options: CallOptions) !get_template_step.GetTemplateStepOutput {
        return get_template_step.execute(self, allocator, input, options);
    }

    /// Get a step group in a template.
    pub fn getTemplateStepGroup(self: *Self, allocator: std.mem.Allocator, input: get_template_step_group.GetTemplateStepGroupInput, options: CallOptions) !get_template_step_group.GetTemplateStepGroupOutput {
        return get_template_step_group.execute(self, allocator, input, options);
    }

    /// Get migration workflow.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: CallOptions) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Get a step in the migration workflow.
    pub fn getWorkflowStep(self: *Self, allocator: std.mem.Allocator, input: get_workflow_step.GetWorkflowStepInput, options: CallOptions) !get_workflow_step.GetWorkflowStepOutput {
        return get_workflow_step.execute(self, allocator, input, options);
    }

    /// Get the step group of a migration workflow.
    pub fn getWorkflowStepGroup(self: *Self, allocator: std.mem.Allocator, input: get_workflow_step_group.GetWorkflowStepGroupInput, options: CallOptions) !get_workflow_step_group.GetWorkflowStepGroupOutput {
        return get_workflow_step_group.execute(self, allocator, input, options);
    }

    /// List AWS Migration Hub Orchestrator plugins.
    pub fn listPlugins(self: *Self, allocator: std.mem.Allocator, input: list_plugins.ListPluginsInput, options: CallOptions) !list_plugins.ListPluginsOutput {
        return list_plugins.execute(self, allocator, input, options);
    }

    /// List the tags added to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List the step groups in a template.
    pub fn listTemplateStepGroups(self: *Self, allocator: std.mem.Allocator, input: list_template_step_groups.ListTemplateStepGroupsInput, options: CallOptions) !list_template_step_groups.ListTemplateStepGroupsOutput {
        return list_template_step_groups.execute(self, allocator, input, options);
    }

    /// List the steps in a template.
    pub fn listTemplateSteps(self: *Self, allocator: std.mem.Allocator, input: list_template_steps.ListTemplateStepsInput, options: CallOptions) !list_template_steps.ListTemplateStepsOutput {
        return list_template_steps.execute(self, allocator, input, options);
    }

    /// List the templates available in Migration Hub Orchestrator to create a
    /// migration workflow.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: CallOptions) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// List the step groups in a migration workflow.
    pub fn listWorkflowStepGroups(self: *Self, allocator: std.mem.Allocator, input: list_workflow_step_groups.ListWorkflowStepGroupsInput, options: CallOptions) !list_workflow_step_groups.ListWorkflowStepGroupsOutput {
        return list_workflow_step_groups.execute(self, allocator, input, options);
    }

    /// List the steps in a workflow.
    pub fn listWorkflowSteps(self: *Self, allocator: std.mem.Allocator, input: list_workflow_steps.ListWorkflowStepsInput, options: CallOptions) !list_workflow_steps.ListWorkflowStepsOutput {
        return list_workflow_steps.execute(self, allocator, input, options);
    }

    /// List the migration workflows.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: CallOptions) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Retry a failed step in a migration workflow.
    pub fn retryWorkflowStep(self: *Self, allocator: std.mem.Allocator, input: retry_workflow_step.RetryWorkflowStepInput, options: CallOptions) !retry_workflow_step.RetryWorkflowStepOutput {
        return retry_workflow_step.execute(self, allocator, input, options);
    }

    /// Start a migration workflow.
    pub fn startWorkflow(self: *Self, allocator: std.mem.Allocator, input: start_workflow.StartWorkflowInput, options: CallOptions) !start_workflow.StartWorkflowOutput {
        return start_workflow.execute(self, allocator, input, options);
    }

    /// Stop an ongoing migration workflow.
    pub fn stopWorkflow(self: *Self, allocator: std.mem.Allocator, input: stop_workflow.StopWorkflowInput, options: CallOptions) !stop_workflow.StopWorkflowOutput {
        return stop_workflow.execute(self, allocator, input, options);
    }

    /// Tag a resource by specifying its Amazon Resource Name (ARN).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes the tags for a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a migration workflow template.
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: CallOptions) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    /// Update a migration workflow.
    pub fn updateWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_workflow.UpdateWorkflowInput, options: CallOptions) !update_workflow.UpdateWorkflowOutput {
        return update_workflow.execute(self, allocator, input, options);
    }

    /// Update a step in a migration workflow.
    pub fn updateWorkflowStep(self: *Self, allocator: std.mem.Allocator, input: update_workflow_step.UpdateWorkflowStepInput, options: CallOptions) !update_workflow_step.UpdateWorkflowStepOutput {
        return update_workflow_step.execute(self, allocator, input, options);
    }

    /// Update the step group in a migration workflow.
    pub fn updateWorkflowStepGroup(self: *Self, allocator: std.mem.Allocator, input: update_workflow_step_group.UpdateWorkflowStepGroupInput, options: CallOptions) !update_workflow_step_group.UpdateWorkflowStepGroupOutput {
        return update_workflow_step_group.execute(self, allocator, input, options);
    }

    pub fn listPluginsPaginator(self: *Self, params: list_plugins.ListPluginsInput) paginator.ListPluginsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateStepGroupsPaginator(self: *Self, params: list_template_step_groups.ListTemplateStepGroupsInput) paginator.ListTemplateStepGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateStepsPaginator(self: *Self, params: list_template_steps.ListTemplateStepsInput) paginator.ListTemplateStepsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplatesPaginator(self: *Self, params: list_templates.ListTemplatesInput) paginator.ListTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowStepGroupsPaginator(self: *Self, params: list_workflow_step_groups.ListWorkflowStepGroupsInput) paginator.ListWorkflowStepGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowStepsPaginator(self: *Self, params: list_workflow_steps.ListWorkflowStepsInput) paginator.ListWorkflowStepsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
