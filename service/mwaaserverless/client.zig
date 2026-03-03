const aws = @import("aws");
const std = @import("std");

const create_workflow = @import("create_workflow.zig");
const delete_workflow = @import("delete_workflow.zig");
const get_task_instance = @import("get_task_instance.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_run = @import("get_workflow_run.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_task_instances = @import("list_task_instances.zig");
const list_workflow_runs = @import("list_workflow_runs.zig");
const list_workflow_versions = @import("list_workflow_versions.zig");
const list_workflows = @import("list_workflows.zig");
const start_workflow_run = @import("start_workflow_run.zig");
const stop_workflow_run = @import("stop_workflow_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_workflow = @import("update_workflow.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MWAA Serverless";

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

    /// Creates a new workflow in Amazon Managed Workflows for Apache Airflow
    /// Serverless. This operation initializes a workflow with the specified
    /// configuration including the workflow definition, execution role, and
    /// optional settings for encryption, logging, and networking. You must provide
    /// the workflow definition as a YAML file stored in Amazon S3 that defines the
    /// DAG structure using supported Amazon Web Services operators. Amazon Managed
    /// Workflows for Apache Airflow Serverless automatically creates the first
    /// version of the workflow and sets up the necessary execution environment with
    /// multi-tenant isolation and security controls.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: create_workflow.Options) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Deletes a workflow and all its versions. This operation permanently removes
    /// the workflow and cannot be undone. Amazon Managed Workflows for Apache
    /// Airflow Serverless ensures that all associated resources are properly
    /// cleaned up, including stopping any running executions, removing scheduled
    /// triggers, and cleaning up execution history. The deletion process respects
    /// the multi-tenant isolation boundaries and ensures that no residual data or
    /// configurations remain that could affect other customers or workflows.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: delete_workflow.Options) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific task instance within a
    /// workflow run. Task instances represent individual tasks that are executed as
    /// part of a workflow in the Amazon Managed Workflows for Apache Airflow
    /// Serverless environment. Each task instance runs in an isolated ECS container
    /// with dedicated resources and security boundaries. The service tracks task
    /// execution state, retry attempts, and provides detailed timing and error
    /// information for troubleshooting and monitoring purposes.
    pub fn getTaskInstance(self: *Self, allocator: std.mem.Allocator, input: get_task_instance.GetTaskInstanceInput, options: get_task_instance.Options) !get_task_instance.GetTaskInstanceOutput {
        return get_task_instance.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a workflow, including its
    /// configuration, status, and metadata.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: get_workflow.Options) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific workflow run, including its
    /// status, execution details, and task instances.
    pub fn getWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: get_workflow_run.GetWorkflowRunInput, options: get_workflow_run.Options) !get_workflow_run.GetWorkflowRunOutput {
        return get_workflow_run.execute(self, allocator, input, options);
    }

    /// Lists all tags that are associated with a specified Amazon Managed Workflows
    /// for Apache Airflow Serverless resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all task instances for a specific workflow run, with optional
    /// pagination support.
    pub fn listTaskInstances(self: *Self, allocator: std.mem.Allocator, input: list_task_instances.ListTaskInstancesInput, options: list_task_instances.Options) !list_task_instances.ListTaskInstancesOutput {
        return list_task_instances.execute(self, allocator, input, options);
    }

    /// Lists all runs for a specified workflow, with optional pagination and
    /// filtering support.
    pub fn listWorkflowRuns(self: *Self, allocator: std.mem.Allocator, input: list_workflow_runs.ListWorkflowRunsInput, options: list_workflow_runs.Options) !list_workflow_runs.ListWorkflowRunsOutput {
        return list_workflow_runs.execute(self, allocator, input, options);
    }

    /// Lists all versions of a specified workflow, with optional pagination
    /// support.
    pub fn listWorkflowVersions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_versions.ListWorkflowVersionsInput, options: list_workflow_versions.Options) !list_workflow_versions.ListWorkflowVersionsOutput {
        return list_workflow_versions.execute(self, allocator, input, options);
    }

    /// Lists all workflows in your account, with optional pagination support. This
    /// operation returns summary information for workflows, showing only the most
    /// recently created version of each workflow. Amazon Managed Workflows for
    /// Apache Airflow Serverless maintains workflow metadata in a highly available,
    /// distributed storage system that enables efficient querying and filtering.
    /// The service implements proper access controls to ensure you can only view
    /// workflows that you have permissions to access, supporting both individual
    /// and team-based workflow management scenarios.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Starts a new execution of a workflow. This operation creates a workflow run
    /// that executes the tasks that are defined in the workflow. Amazon Managed
    /// Workflows for Apache Airflow Serverless schedules the workflow execution
    /// across its managed Airflow environment, automatically scaling ECS worker
    /// tasks based on the workload. The service handles task isolation, dependency
    /// resolution, and provides comprehensive monitoring and logging throughout the
    /// execution lifecycle.
    pub fn startWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: start_workflow_run.StartWorkflowRunInput, options: start_workflow_run.Options) !start_workflow_run.StartWorkflowRunOutput {
        return start_workflow_run.execute(self, allocator, input, options);
    }

    /// Stops a running workflow execution. This operation terminates all running
    /// tasks and prevents new tasks from starting. Amazon Managed Workflows for
    /// Apache Airflow Serverless gracefully shuts down the workflow execution by
    /// stopping task scheduling and terminating active ECS worker containers. The
    /// operation transitions the workflow run to a `STOPPING` state and then to
    /// `STOPPED` once all cleanup is complete. In-flight tasks may complete or be
    /// terminated depending on their current execution state.
    pub fn stopWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: stop_workflow_run.StopWorkflowRunInput, options: stop_workflow_run.Options) !stop_workflow_run.StopWorkflowRunOutput {
        return stop_workflow_run.execute(self, allocator, input, options);
    }

    /// Adds tags to an Amazon Managed Workflows for Apache Airflow Serverless
    /// resource. Tags are key-value pairs that help you organize and categorize
    /// your resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon Managed Workflows for Apache Airflow Serverless
    /// resource. This operation removes the specified tags from the resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing workflow with new configuration settings. This operation
    /// allows you to modify the workflow definition, role, and other settings. When
    /// you update a workflow, Amazon Managed Workflows for Apache Airflow
    /// Serverless automatically creates a new version with the updated
    /// configuration and disables scheduling on all previous versions to ensure
    /// only one version is actively scheduled at a time. The update operation
    /// maintains workflow history while providing a clean transition to the new
    /// configuration.
    pub fn updateWorkflow(self: *Self, allocator: std.mem.Allocator, input: update_workflow.UpdateWorkflowInput, options: update_workflow.Options) !update_workflow.UpdateWorkflowOutput {
        return update_workflow.execute(self, allocator, input, options);
    }

    pub fn listTaskInstancesPaginator(self: *Self, params: list_task_instances.ListTaskInstancesInput) paginator.ListTaskInstancesPaginator {
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

    pub fn listWorkflowVersionsPaginator(self: *Self, params: list_workflow_versions.ListWorkflowVersionsInput) paginator.ListWorkflowVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
