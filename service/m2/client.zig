const aws = @import("aws");
const std = @import("std");

const cancel_batch_job_execution = @import("cancel_batch_job_execution.zig");
const create_application = @import("create_application.zig");
const create_data_set_export_task = @import("create_data_set_export_task.zig");
const create_data_set_import_task = @import("create_data_set_import_task.zig");
const create_deployment = @import("create_deployment.zig");
const create_environment = @import("create_environment.zig");
const delete_application = @import("delete_application.zig");
const delete_application_from_environment = @import("delete_application_from_environment.zig");
const delete_environment = @import("delete_environment.zig");
const get_application = @import("get_application.zig");
const get_application_version = @import("get_application_version.zig");
const get_batch_job_execution = @import("get_batch_job_execution.zig");
const get_data_set_details = @import("get_data_set_details.zig");
const get_data_set_export_task = @import("get_data_set_export_task.zig");
const get_data_set_import_task = @import("get_data_set_import_task.zig");
const get_deployment = @import("get_deployment.zig");
const get_environment = @import("get_environment.zig");
const get_signed_bluinsights_url = @import("get_signed_bluinsights_url.zig");
const list_application_versions = @import("list_application_versions.zig");
const list_applications = @import("list_applications.zig");
const list_batch_job_definitions = @import("list_batch_job_definitions.zig");
const list_batch_job_executions = @import("list_batch_job_executions.zig");
const list_batch_job_restart_points = @import("list_batch_job_restart_points.zig");
const list_data_set_export_history = @import("list_data_set_export_history.zig");
const list_data_set_import_history = @import("list_data_set_import_history.zig");
const list_data_sets = @import("list_data_sets.zig");
const list_deployments = @import("list_deployments.zig");
const list_engine_versions = @import("list_engine_versions.zig");
const list_environments = @import("list_environments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_application = @import("start_application.zig");
const start_batch_job = @import("start_batch_job.zig");
const stop_application = @import("stop_application.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_environment = @import("update_environment.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "m2";

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

    /// Cancels the running of a specific batch job execution.
    pub fn cancelBatchJobExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_batch_job_execution.CancelBatchJobExecutionInput, options: cancel_batch_job_execution.Options) !cancel_batch_job_execution.CancelBatchJobExecutionOutput {
        return cancel_batch_job_execution.execute(self, allocator, input, options);
    }

    /// Creates a new application with given parameters. Requires an existing
    /// runtime
    /// environment and application definition file.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Starts a data set export task for a specific application.
    pub fn createDataSetExportTask(self: *Self, allocator: std.mem.Allocator, input: create_data_set_export_task.CreateDataSetExportTaskInput, options: create_data_set_export_task.Options) !create_data_set_export_task.CreateDataSetExportTaskOutput {
        return create_data_set_export_task.execute(self, allocator, input, options);
    }

    /// Starts a data set import task for a specific application.
    pub fn createDataSetImportTask(self: *Self, allocator: std.mem.Allocator, input: create_data_set_import_task.CreateDataSetImportTaskInput, options: create_data_set_import_task.Options) !create_data_set_import_task.CreateDataSetImportTaskOutput {
        return create_data_set_import_task.execute(self, allocator, input, options);
    }

    /// Creates and starts a deployment to deploy an application into a runtime
    /// environment.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: create_deployment.Options) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a runtime environment for a given runtime engine.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Deletes a specific application. You cannot delete a running application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes a specific application from the specific runtime environment where
    /// it was
    /// previously deployed. You cannot delete a runtime environment using
    /// DeleteEnvironment if any
    /// application has ever been deployed to it. This API removes the association
    /// of the
    /// application with the runtime environment so you can delete the environment
    /// smoothly.
    pub fn deleteApplicationFromEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_application_from_environment.DeleteApplicationFromEnvironmentInput, options: delete_application_from_environment.Options) !delete_application_from_environment.DeleteApplicationFromEnvironmentOutput {
        return delete_application_from_environment.execute(self, allocator, input, options);
    }

    /// Deletes a specific runtime environment. The environment cannot contain
    /// deployed
    /// applications. If it does, you must delete those applications before you
    /// delete the
    /// environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Describes the details of a specific application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Returns details about a specific version of a specific application.
    pub fn getApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: get_application_version.GetApplicationVersionInput, options: get_application_version.Options) !get_application_version.GetApplicationVersionOutput {
        return get_application_version.execute(self, allocator, input, options);
    }

    /// Gets the details of a specific batch job execution for a specific
    /// application.
    pub fn getBatchJobExecution(self: *Self, allocator: std.mem.Allocator, input: get_batch_job_execution.GetBatchJobExecutionInput, options: get_batch_job_execution.Options) !get_batch_job_execution.GetBatchJobExecutionOutput {
        return get_batch_job_execution.execute(self, allocator, input, options);
    }

    /// Gets the details of a specific data set.
    pub fn getDataSetDetails(self: *Self, allocator: std.mem.Allocator, input: get_data_set_details.GetDataSetDetailsInput, options: get_data_set_details.Options) !get_data_set_details.GetDataSetDetailsOutput {
        return get_data_set_details.execute(self, allocator, input, options);
    }

    /// Gets the status of a data set import task initiated with the
    /// CreateDataSetExportTask operation.
    pub fn getDataSetExportTask(self: *Self, allocator: std.mem.Allocator, input: get_data_set_export_task.GetDataSetExportTaskInput, options: get_data_set_export_task.Options) !get_data_set_export_task.GetDataSetExportTaskOutput {
        return get_data_set_export_task.execute(self, allocator, input, options);
    }

    /// Gets the status of a data set import task initiated with the
    /// CreateDataSetImportTask operation.
    pub fn getDataSetImportTask(self: *Self, allocator: std.mem.Allocator, input: get_data_set_import_task.GetDataSetImportTaskInput, options: get_data_set_import_task.Options) !get_data_set_import_task.GetDataSetImportTaskOutput {
        return get_data_set_import_task.execute(self, allocator, input, options);
    }

    /// Gets details of a specific deployment with a given deployment identifier.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: get_deployment.Options) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Describes a specific runtime environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: get_environment.Options) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Gets a single sign-on URL that can be used to connect to AWS Blu Insights.
    pub fn getSignedBluinsightsUrl(self: *Self, allocator: std.mem.Allocator, input: get_signed_bluinsights_url.GetSignedBluinsightsUrlInput, options: get_signed_bluinsights_url.Options) !get_signed_bluinsights_url.GetSignedBluinsightsUrlOutput {
        return get_signed_bluinsights_url.execute(self, allocator, input, options);
    }

    /// Returns a list of the application versions for a specific application.
    pub fn listApplicationVersions(self: *Self, allocator: std.mem.Allocator, input: list_application_versions.ListApplicationVersionsInput, options: list_application_versions.Options) !list_application_versions.ListApplicationVersionsOutput {
        return list_application_versions.execute(self, allocator, input, options);
    }

    /// Lists the applications associated with a specific Amazon Web Services
    /// account. You can provide the
    /// unique identifier of a specific runtime environment in a query parameter to
    /// see all
    /// applications associated with that environment.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all the available batch job definitions based on the batch job
    /// resources uploaded
    /// during the application creation. You can use the batch job definitions in
    /// the list to start
    /// a batch job.
    pub fn listBatchJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_batch_job_definitions.ListBatchJobDefinitionsInput, options: list_batch_job_definitions.Options) !list_batch_job_definitions.ListBatchJobDefinitionsOutput {
        return list_batch_job_definitions.execute(self, allocator, input, options);
    }

    /// Lists historical, current, and scheduled batch job executions for a specific
    /// application.
    pub fn listBatchJobExecutions(self: *Self, allocator: std.mem.Allocator, input: list_batch_job_executions.ListBatchJobExecutionsInput, options: list_batch_job_executions.Options) !list_batch_job_executions.ListBatchJobExecutionsOutput {
        return list_batch_job_executions.execute(self, allocator, input, options);
    }

    /// Lists all the job steps for a JCL file to restart a batch job. This is only
    /// applicable for Micro Focus engine with versions 8.0.6 and above.
    pub fn listBatchJobRestartPoints(self: *Self, allocator: std.mem.Allocator, input: list_batch_job_restart_points.ListBatchJobRestartPointsInput, options: list_batch_job_restart_points.Options) !list_batch_job_restart_points.ListBatchJobRestartPointsOutput {
        return list_batch_job_restart_points.execute(self, allocator, input, options);
    }

    /// Lists the data set exports for the specified application.
    pub fn listDataSetExportHistory(self: *Self, allocator: std.mem.Allocator, input: list_data_set_export_history.ListDataSetExportHistoryInput, options: list_data_set_export_history.Options) !list_data_set_export_history.ListDataSetExportHistoryOutput {
        return list_data_set_export_history.execute(self, allocator, input, options);
    }

    /// Lists the data set imports for the specified application.
    pub fn listDataSetImportHistory(self: *Self, allocator: std.mem.Allocator, input: list_data_set_import_history.ListDataSetImportHistoryInput, options: list_data_set_import_history.Options) !list_data_set_import_history.ListDataSetImportHistoryOutput {
        return list_data_set_import_history.execute(self, allocator, input, options);
    }

    /// Lists the data sets imported for a specific application. In Amazon Web
    /// Services Mainframe Modernization, data sets are
    /// associated with applications deployed on runtime environments. This is known
    /// as importing
    /// data sets. Currently, Amazon Web Services Mainframe Modernization can import
    /// data sets into catalogs using
    /// [CreateDataSetImportTask](https://docs.aws.amazon.com/m2/latest/APIReference/API_CreateDataSetImportTask.html).
    pub fn listDataSets(self: *Self, allocator: std.mem.Allocator, input: list_data_sets.ListDataSetsInput, options: list_data_sets.Options) !list_data_sets.ListDataSetsOutput {
        return list_data_sets.execute(self, allocator, input, options);
    }

    /// Returns a list of all deployments of a specific application. A deployment is
    /// a
    /// combination of a specific application and a specific version of that
    /// application. Each
    /// deployment is mapped to a particular application version.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: list_deployments.Options) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the available engine versions.
    pub fn listEngineVersions(self: *Self, allocator: std.mem.Allocator, input: list_engine_versions.ListEngineVersionsInput, options: list_engine_versions.Options) !list_engine_versions.ListEngineVersionsOutput {
        return list_engine_versions.execute(self, allocator, input, options);
    }

    /// Lists the runtime environments.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts an application that is currently stopped.
    pub fn startApplication(self: *Self, allocator: std.mem.Allocator, input: start_application.StartApplicationInput, options: start_application.Options) !start_application.StartApplicationOutput {
        return start_application.execute(self, allocator, input, options);
    }

    /// Starts a batch job and returns the unique identifier of this execution of
    /// the batch job.
    /// The associated application must be running in order to start the batch job.
    pub fn startBatchJob(self: *Self, allocator: std.mem.Allocator, input: start_batch_job.StartBatchJobInput, options: start_batch_job.Options) !start_batch_job.StartBatchJobOutput {
        return start_batch_job.execute(self, allocator, input, options);
    }

    /// Stops a running application.
    pub fn stopApplication(self: *Self, allocator: std.mem.Allocator, input: stop_application.StopApplicationInput, options: stop_application.Options) !stop_application.StopApplicationOutput {
        return stop_application.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an application and creates a new version.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the configuration details for a specific runtime environment.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    pub fn listApplicationVersionsPaginator(self: *Self, params: list_application_versions.ListApplicationVersionsInput) paginator.ListApplicationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBatchJobDefinitionsPaginator(self: *Self, params: list_batch_job_definitions.ListBatchJobDefinitionsInput) paginator.ListBatchJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBatchJobExecutionsPaginator(self: *Self, params: list_batch_job_executions.ListBatchJobExecutionsInput) paginator.ListBatchJobExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSetExportHistoryPaginator(self: *Self, params: list_data_set_export_history.ListDataSetExportHistoryInput) paginator.ListDataSetExportHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSetImportHistoryPaginator(self: *Self, params: list_data_set_import_history.ListDataSetImportHistoryInput) paginator.ListDataSetImportHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataSetsPaginator(self: *Self, params: list_data_sets.ListDataSetsInput) paginator.ListDataSetsPaginator {
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

    pub fn listEngineVersionsPaginator(self: *Self, params: list_engine_versions.ListEngineVersionsInput) paginator.ListEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
