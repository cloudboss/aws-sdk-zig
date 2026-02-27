const aws = @import("aws");
const std = @import("std");

const create_act = @import("create_act.zig");
const create_session = @import("create_session.zig");
const create_workflow_definition = @import("create_workflow_definition.zig");
const create_workflow_run = @import("create_workflow_run.zig");
const delete_workflow_definition = @import("delete_workflow_definition.zig");
const delete_workflow_run = @import("delete_workflow_run.zig");
const get_workflow_definition = @import("get_workflow_definition.zig");
const get_workflow_run = @import("get_workflow_run.zig");
const invoke_act_step = @import("invoke_act_step.zig");
const list_acts = @import("list_acts.zig");
const list_models = @import("list_models.zig");
const list_sessions = @import("list_sessions.zig");
const list_workflow_definitions = @import("list_workflow_definitions.zig");
const list_workflow_runs = @import("list_workflow_runs.zig");
const update_act = @import("update_act.zig");
const update_workflow_run = @import("update_workflow_run.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Nova Act";

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

    /// Creates a new AI task (act) within a session that can interact with tools
    /// and perform specific actions.
    pub fn createAct(self: *Self, allocator: std.mem.Allocator, input: create_act.CreateActInput, options: create_act.Options) !create_act.CreateActOutput {
        return create_act.execute(self, allocator, input, options);
    }

    /// Creates a new session context within a workflow run to manage conversation
    /// state and acts.
    pub fn createSession(self: *Self, allocator: std.mem.Allocator, input: create_session.CreateSessionInput, options: create_session.Options) !create_session.CreateSessionOutput {
        return create_session.execute(self, allocator, input, options);
    }

    /// Creates a new workflow definition template that can be used to execute
    /// multiple workflow runs.
    pub fn createWorkflowDefinition(self: *Self, allocator: std.mem.Allocator, input: create_workflow_definition.CreateWorkflowDefinitionInput, options: create_workflow_definition.Options) !create_workflow_definition.CreateWorkflowDefinitionOutput {
        return create_workflow_definition.execute(self, allocator, input, options);
    }

    /// Creates a new execution instance of a workflow definition with specified
    /// parameters.
    pub fn createWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: create_workflow_run.CreateWorkflowRunInput, options: create_workflow_run.Options) !create_workflow_run.CreateWorkflowRunOutput {
        return create_workflow_run.execute(self, allocator, input, options);
    }

    /// Deletes a workflow definition and all associated resources. This operation
    /// cannot be undone.
    pub fn deleteWorkflowDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_definition.DeleteWorkflowDefinitionInput, options: delete_workflow_definition.Options) !delete_workflow_definition.DeleteWorkflowDefinitionOutput {
        return delete_workflow_definition.execute(self, allocator, input, options);
    }

    /// Terminates and cleans up a workflow run, stopping all associated acts and
    /// sessions.
    pub fn deleteWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: delete_workflow_run.DeleteWorkflowRunInput, options: delete_workflow_run.Options) !delete_workflow_run.DeleteWorkflowRunOutput {
        return delete_workflow_run.execute(self, allocator, input, options);
    }

    /// Retrieves the details and configuration of a specific workflow definition.
    pub fn getWorkflowDefinition(self: *Self, allocator: std.mem.Allocator, input: get_workflow_definition.GetWorkflowDefinitionInput, options: get_workflow_definition.Options) !get_workflow_definition.GetWorkflowDefinitionOutput {
        return get_workflow_definition.execute(self, allocator, input, options);
    }

    /// Retrieves the current state, configuration, and execution details of a
    /// workflow run.
    pub fn getWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: get_workflow_run.GetWorkflowRunInput, options: get_workflow_run.Options) !get_workflow_run.GetWorkflowRunOutput {
        return get_workflow_run.execute(self, allocator, input, options);
    }

    /// Executes the next step of an act, processing tool call results and returning
    /// new tool calls if needed.
    pub fn invokeActStep(self: *Self, allocator: std.mem.Allocator, input: invoke_act_step.InvokeActStepInput, options: invoke_act_step.Options) !invoke_act_step.InvokeActStepOutput {
        return invoke_act_step.execute(self, allocator, input, options);
    }

    /// Lists all acts within a specific session with their current status and
    /// execution details.
    pub fn listActs(self: *Self, allocator: std.mem.Allocator, input: list_acts.ListActsInput, options: list_acts.Options) !list_acts.ListActsOutput {
        return list_acts.execute(self, allocator, input, options);
    }

    /// Lists all available AI models that can be used for workflow execution,
    /// including their status and compatibility information.
    pub fn listModels(self: *Self, allocator: std.mem.Allocator, input: list_models.ListModelsInput, options: list_models.Options) !list_models.ListModelsOutput {
        return list_models.execute(self, allocator, input, options);
    }

    /// Lists all sessions within a specific workflow run.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: list_sessions.Options) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Lists all workflow definitions in your account with optional filtering and
    /// pagination.
    pub fn listWorkflowDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_definitions.ListWorkflowDefinitionsInput, options: list_workflow_definitions.Options) !list_workflow_definitions.ListWorkflowDefinitionsOutput {
        return list_workflow_definitions.execute(self, allocator, input, options);
    }

    /// Lists all workflow runs for a specific workflow definition with optional
    /// filtering and pagination.
    pub fn listWorkflowRuns(self: *Self, allocator: std.mem.Allocator, input: list_workflow_runs.ListWorkflowRunsInput, options: list_workflow_runs.Options) !list_workflow_runs.ListWorkflowRunsOutput {
        return list_workflow_runs.execute(self, allocator, input, options);
    }

    /// Updates an existing act's configuration, status, or error information.
    pub fn updateAct(self: *Self, allocator: std.mem.Allocator, input: update_act.UpdateActInput, options: update_act.Options) !update_act.UpdateActOutput {
        return update_act.execute(self, allocator, input, options);
    }

    /// Updates the configuration or state of an active workflow run.
    pub fn updateWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: update_workflow_run.UpdateWorkflowRunInput, options: update_workflow_run.Options) !update_workflow_run.UpdateWorkflowRunOutput {
        return update_workflow_run.execute(self, allocator, input, options);
    }

    pub fn listActsPaginator(self: *Self, params: list_acts.ListActsInput) paginator.ListActsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowDefinitionsPaginator(self: *Self, params: list_workflow_definitions.ListWorkflowDefinitionsInput) paginator.ListWorkflowDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowRunsPaginator(self: *Self, params: list_workflow_runs.ListWorkflowRunsInput) paginator.ListWorkflowRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
