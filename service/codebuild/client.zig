const aws = @import("aws");
const std = @import("std");

const batch_delete_builds = @import("batch_delete_builds.zig");
const batch_get_build_batches = @import("batch_get_build_batches.zig");
const batch_get_builds = @import("batch_get_builds.zig");
const batch_get_command_executions = @import("batch_get_command_executions.zig");
const batch_get_fleets = @import("batch_get_fleets.zig");
const batch_get_projects = @import("batch_get_projects.zig");
const batch_get_report_groups = @import("batch_get_report_groups.zig");
const batch_get_reports = @import("batch_get_reports.zig");
const batch_get_sandboxes = @import("batch_get_sandboxes.zig");
const create_fleet = @import("create_fleet.zig");
const create_project = @import("create_project.zig");
const create_report_group = @import("create_report_group.zig");
const create_webhook = @import("create_webhook.zig");
const delete_build_batch = @import("delete_build_batch.zig");
const delete_fleet = @import("delete_fleet.zig");
const delete_project = @import("delete_project.zig");
const delete_report = @import("delete_report.zig");
const delete_report_group = @import("delete_report_group.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_source_credentials = @import("delete_source_credentials.zig");
const delete_webhook = @import("delete_webhook.zig");
const describe_code_coverages = @import("describe_code_coverages.zig");
const describe_test_cases = @import("describe_test_cases.zig");
const get_report_group_trend = @import("get_report_group_trend.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const import_source_credentials = @import("import_source_credentials.zig");
const invalidate_project_cache = @import("invalidate_project_cache.zig");
const list_build_batches = @import("list_build_batches.zig");
const list_build_batches_for_project = @import("list_build_batches_for_project.zig");
const list_builds = @import("list_builds.zig");
const list_builds_for_project = @import("list_builds_for_project.zig");
const list_command_executions_for_sandbox = @import("list_command_executions_for_sandbox.zig");
const list_curated_environment_images = @import("list_curated_environment_images.zig");
const list_fleets = @import("list_fleets.zig");
const list_projects = @import("list_projects.zig");
const list_report_groups = @import("list_report_groups.zig");
const list_reports = @import("list_reports.zig");
const list_reports_for_report_group = @import("list_reports_for_report_group.zig");
const list_sandboxes = @import("list_sandboxes.zig");
const list_sandboxes_for_project = @import("list_sandboxes_for_project.zig");
const list_shared_projects = @import("list_shared_projects.zig");
const list_shared_report_groups = @import("list_shared_report_groups.zig");
const list_source_credentials = @import("list_source_credentials.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const retry_build = @import("retry_build.zig");
const retry_build_batch = @import("retry_build_batch.zig");
const start_build = @import("start_build.zig");
const start_build_batch = @import("start_build_batch.zig");
const start_command_execution = @import("start_command_execution.zig");
const start_sandbox = @import("start_sandbox.zig");
const start_sandbox_connection = @import("start_sandbox_connection.zig");
const stop_build = @import("stop_build.zig");
const stop_build_batch = @import("stop_build_batch.zig");
const stop_sandbox = @import("stop_sandbox.zig");
const update_fleet = @import("update_fleet.zig");
const update_project = @import("update_project.zig");
const update_project_visibility = @import("update_project_visibility.zig");
const update_report_group = @import("update_report_group.zig");
const update_webhook = @import("update_webhook.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeBuild";

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

    /// Deletes one or more builds.
    pub fn batchDeleteBuilds(self: *Self, allocator: std.mem.Allocator, input: batch_delete_builds.BatchDeleteBuildsInput, options: CallOptions) !batch_delete_builds.BatchDeleteBuildsOutput {
        return batch_delete_builds.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more batch builds.
    pub fn batchGetBuildBatches(self: *Self, allocator: std.mem.Allocator, input: batch_get_build_batches.BatchGetBuildBatchesInput, options: CallOptions) !batch_get_build_batches.BatchGetBuildBatchesOutput {
        return batch_get_build_batches.execute(self, allocator, input, options);
    }

    /// Gets information about one or more builds.
    pub fn batchGetBuilds(self: *Self, allocator: std.mem.Allocator, input: batch_get_builds.BatchGetBuildsInput, options: CallOptions) !batch_get_builds.BatchGetBuildsOutput {
        return batch_get_builds.execute(self, allocator, input, options);
    }

    /// Gets information about the command executions.
    pub fn batchGetCommandExecutions(self: *Self, allocator: std.mem.Allocator, input: batch_get_command_executions.BatchGetCommandExecutionsInput, options: CallOptions) !batch_get_command_executions.BatchGetCommandExecutionsOutput {
        return batch_get_command_executions.execute(self, allocator, input, options);
    }

    /// Gets information about one or more compute fleets.
    pub fn batchGetFleets(self: *Self, allocator: std.mem.Allocator, input: batch_get_fleets.BatchGetFleetsInput, options: CallOptions) !batch_get_fleets.BatchGetFleetsOutput {
        return batch_get_fleets.execute(self, allocator, input, options);
    }

    /// Gets information about one or more build projects.
    pub fn batchGetProjects(self: *Self, allocator: std.mem.Allocator, input: batch_get_projects.BatchGetProjectsInput, options: CallOptions) !batch_get_projects.BatchGetProjectsOutput {
        return batch_get_projects.execute(self, allocator, input, options);
    }

    /// Returns an array of report groups.
    pub fn batchGetReportGroups(self: *Self, allocator: std.mem.Allocator, input: batch_get_report_groups.BatchGetReportGroupsInput, options: CallOptions) !batch_get_report_groups.BatchGetReportGroupsOutput {
        return batch_get_report_groups.execute(self, allocator, input, options);
    }

    /// Returns an array of reports.
    pub fn batchGetReports(self: *Self, allocator: std.mem.Allocator, input: batch_get_reports.BatchGetReportsInput, options: CallOptions) !batch_get_reports.BatchGetReportsOutput {
        return batch_get_reports.execute(self, allocator, input, options);
    }

    /// Gets information about the sandbox status.
    pub fn batchGetSandboxes(self: *Self, allocator: std.mem.Allocator, input: batch_get_sandboxes.BatchGetSandboxesInput, options: CallOptions) !batch_get_sandboxes.BatchGetSandboxesOutput {
        return batch_get_sandboxes.execute(self, allocator, input, options);
    }

    /// Creates a compute fleet.
    pub fn createFleet(self: *Self, allocator: std.mem.Allocator, input: create_fleet.CreateFleetInput, options: CallOptions) !create_fleet.CreateFleetOutput {
        return create_fleet.execute(self, allocator, input, options);
    }

    /// Creates a build project.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: CallOptions) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates a report group. A report group contains a collection of reports.
    pub fn createReportGroup(self: *Self, allocator: std.mem.Allocator, input: create_report_group.CreateReportGroupInput, options: CallOptions) !create_report_group.CreateReportGroupOutput {
        return create_report_group.execute(self, allocator, input, options);
    }

    /// For an existing CodeBuild build project that has its source code stored in a
    /// GitHub or
    /// Bitbucket repository, enables CodeBuild to start rebuilding the source code
    /// every time a
    /// code change is pushed to the repository.
    ///
    /// If you enable webhooks for an CodeBuild project, and the project is used as
    /// a build
    /// step in CodePipeline, then two identical builds are created for each commit.
    /// One build is
    /// triggered through webhooks, and one through CodePipeline. Because billing is
    /// on a per-build
    /// basis, you are billed for both builds. Therefore, if you are using
    /// CodePipeline, we
    /// recommend that you disable webhooks in CodeBuild. In the CodeBuild console,
    /// clear the
    /// Webhook box. For more information, see step 5 in [Change a Build Project's
    /// Settings](https://docs.aws.amazon.com/codebuild/latest/userguide/change-project.html#change-project-console).
    pub fn createWebhook(self: *Self, allocator: std.mem.Allocator, input: create_webhook.CreateWebhookInput, options: CallOptions) !create_webhook.CreateWebhookOutput {
        return create_webhook.execute(self, allocator, input, options);
    }

    /// Deletes a batch build.
    pub fn deleteBuildBatch(self: *Self, allocator: std.mem.Allocator, input: delete_build_batch.DeleteBuildBatchInput, options: CallOptions) !delete_build_batch.DeleteBuildBatchOutput {
        return delete_build_batch.execute(self, allocator, input, options);
    }

    /// Deletes a compute fleet. When you delete a compute fleet, its builds are not
    /// deleted.
    pub fn deleteFleet(self: *Self, allocator: std.mem.Allocator, input: delete_fleet.DeleteFleetInput, options: CallOptions) !delete_fleet.DeleteFleetOutput {
        return delete_fleet.execute(self, allocator, input, options);
    }

    /// Deletes a build project. When you delete a project, its builds are not
    /// deleted.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: CallOptions) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a report.
    pub fn deleteReport(self: *Self, allocator: std.mem.Allocator, input: delete_report.DeleteReportInput, options: CallOptions) !delete_report.DeleteReportOutput {
        return delete_report.execute(self, allocator, input, options);
    }

    /// Deletes a report group. Before you delete a report group, you must delete
    /// its reports.
    pub fn deleteReportGroup(self: *Self, allocator: std.mem.Allocator, input: delete_report_group.DeleteReportGroupInput, options: CallOptions) !delete_report_group.DeleteReportGroupOutput {
        return delete_report_group.execute(self, allocator, input, options);
    }

    /// Deletes a resource policy that is identified by its resource ARN.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a set of GitHub, GitHub Enterprise, or Bitbucket source credentials.
    pub fn deleteSourceCredentials(self: *Self, allocator: std.mem.Allocator, input: delete_source_credentials.DeleteSourceCredentialsInput, options: CallOptions) !delete_source_credentials.DeleteSourceCredentialsOutput {
        return delete_source_credentials.execute(self, allocator, input, options);
    }

    /// For an existing CodeBuild build project that has its source code stored in a
    /// GitHub or
    /// Bitbucket repository, stops CodeBuild from rebuilding the source code every
    /// time a code
    /// change is pushed to the repository.
    pub fn deleteWebhook(self: *Self, allocator: std.mem.Allocator, input: delete_webhook.DeleteWebhookInput, options: CallOptions) !delete_webhook.DeleteWebhookOutput {
        return delete_webhook.execute(self, allocator, input, options);
    }

    /// Retrieves one or more code coverage reports.
    pub fn describeCodeCoverages(self: *Self, allocator: std.mem.Allocator, input: describe_code_coverages.DescribeCodeCoveragesInput, options: CallOptions) !describe_code_coverages.DescribeCodeCoveragesOutput {
        return describe_code_coverages.execute(self, allocator, input, options);
    }

    /// Returns a list of details about test cases for a report.
    pub fn describeTestCases(self: *Self, allocator: std.mem.Allocator, input: describe_test_cases.DescribeTestCasesInput, options: CallOptions) !describe_test_cases.DescribeTestCasesOutput {
        return describe_test_cases.execute(self, allocator, input, options);
    }

    /// Analyzes and accumulates test report values for the specified test reports.
    pub fn getReportGroupTrend(self: *Self, allocator: std.mem.Allocator, input: get_report_group_trend.GetReportGroupTrendInput, options: CallOptions) !get_report_group_trend.GetReportGroupTrendOutput {
        return get_report_group_trend.execute(self, allocator, input, options);
    }

    /// Gets a resource policy that is identified by its resource ARN.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Imports the source repository credentials for an CodeBuild project that has
    /// its
    /// source code stored in a GitHub, GitHub Enterprise, GitLab, GitLab Self
    /// Managed, or Bitbucket repository.
    pub fn importSourceCredentials(self: *Self, allocator: std.mem.Allocator, input: import_source_credentials.ImportSourceCredentialsInput, options: CallOptions) !import_source_credentials.ImportSourceCredentialsOutput {
        return import_source_credentials.execute(self, allocator, input, options);
    }

    /// Resets the cache for a project.
    pub fn invalidateProjectCache(self: *Self, allocator: std.mem.Allocator, input: invalidate_project_cache.InvalidateProjectCacheInput, options: CallOptions) !invalidate_project_cache.InvalidateProjectCacheOutput {
        return invalidate_project_cache.execute(self, allocator, input, options);
    }

    /// Retrieves the identifiers of your build batches in the current region.
    pub fn listBuildBatches(self: *Self, allocator: std.mem.Allocator, input: list_build_batches.ListBuildBatchesInput, options: CallOptions) !list_build_batches.ListBuildBatchesOutput {
        return list_build_batches.execute(self, allocator, input, options);
    }

    /// Retrieves the identifiers of the build batches for a specific project.
    pub fn listBuildBatchesForProject(self: *Self, allocator: std.mem.Allocator, input: list_build_batches_for_project.ListBuildBatchesForProjectInput, options: CallOptions) !list_build_batches_for_project.ListBuildBatchesForProjectOutput {
        return list_build_batches_for_project.execute(self, allocator, input, options);
    }

    /// Gets a list of build IDs, with each build ID representing a single build.
    pub fn listBuilds(self: *Self, allocator: std.mem.Allocator, input: list_builds.ListBuildsInput, options: CallOptions) !list_builds.ListBuildsOutput {
        return list_builds.execute(self, allocator, input, options);
    }

    /// Gets a list of build identifiers for the specified build project, with each
    /// build
    /// identifier representing a single build.
    pub fn listBuildsForProject(self: *Self, allocator: std.mem.Allocator, input: list_builds_for_project.ListBuildsForProjectInput, options: CallOptions) !list_builds_for_project.ListBuildsForProjectOutput {
        return list_builds_for_project.execute(self, allocator, input, options);
    }

    /// Gets a list of command executions for a sandbox.
    pub fn listCommandExecutionsForSandbox(self: *Self, allocator: std.mem.Allocator, input: list_command_executions_for_sandbox.ListCommandExecutionsForSandboxInput, options: CallOptions) !list_command_executions_for_sandbox.ListCommandExecutionsForSandboxOutput {
        return list_command_executions_for_sandbox.execute(self, allocator, input, options);
    }

    /// Gets information about Docker images that are managed by CodeBuild.
    pub fn listCuratedEnvironmentImages(self: *Self, allocator: std.mem.Allocator, input: list_curated_environment_images.ListCuratedEnvironmentImagesInput, options: CallOptions) !list_curated_environment_images.ListCuratedEnvironmentImagesOutput {
        return list_curated_environment_images.execute(self, allocator, input, options);
    }

    /// Gets a list of compute fleet names with each compute fleet name representing
    /// a single compute fleet.
    pub fn listFleets(self: *Self, allocator: std.mem.Allocator, input: list_fleets.ListFleetsInput, options: CallOptions) !list_fleets.ListFleetsOutput {
        return list_fleets.execute(self, allocator, input, options);
    }

    /// Gets a list of build project names, with each build project name
    /// representing a single
    /// build project.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: CallOptions) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Gets a list ARNs for the report groups in the current Amazon Web Services
    /// account.
    pub fn listReportGroups(self: *Self, allocator: std.mem.Allocator, input: list_report_groups.ListReportGroupsInput, options: CallOptions) !list_report_groups.ListReportGroupsOutput {
        return list_report_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of ARNs for the reports in the current Amazon Web Services
    /// account.
    pub fn listReports(self: *Self, allocator: std.mem.Allocator, input: list_reports.ListReportsInput, options: CallOptions) !list_reports.ListReportsOutput {
        return list_reports.execute(self, allocator, input, options);
    }

    /// Returns a list of ARNs for the reports that belong to a `ReportGroup`.
    pub fn listReportsForReportGroup(self: *Self, allocator: std.mem.Allocator, input: list_reports_for_report_group.ListReportsForReportGroupInput, options: CallOptions) !list_reports_for_report_group.ListReportsForReportGroupOutput {
        return list_reports_for_report_group.execute(self, allocator, input, options);
    }

    /// Gets a list of sandboxes.
    pub fn listSandboxes(self: *Self, allocator: std.mem.Allocator, input: list_sandboxes.ListSandboxesInput, options: CallOptions) !list_sandboxes.ListSandboxesOutput {
        return list_sandboxes.execute(self, allocator, input, options);
    }

    /// Gets a list of sandboxes for a given project.
    pub fn listSandboxesForProject(self: *Self, allocator: std.mem.Allocator, input: list_sandboxes_for_project.ListSandboxesForProjectInput, options: CallOptions) !list_sandboxes_for_project.ListSandboxesForProjectOutput {
        return list_sandboxes_for_project.execute(self, allocator, input, options);
    }

    /// Gets a list of projects that are shared with other Amazon Web Services
    /// accounts or users.
    pub fn listSharedProjects(self: *Self, allocator: std.mem.Allocator, input: list_shared_projects.ListSharedProjectsInput, options: CallOptions) !list_shared_projects.ListSharedProjectsOutput {
        return list_shared_projects.execute(self, allocator, input, options);
    }

    /// Gets a list of report groups that are shared with other Amazon Web Services
    /// accounts or users.
    pub fn listSharedReportGroups(self: *Self, allocator: std.mem.Allocator, input: list_shared_report_groups.ListSharedReportGroupsInput, options: CallOptions) !list_shared_report_groups.ListSharedReportGroupsOutput {
        return list_shared_report_groups.execute(self, allocator, input, options);
    }

    /// Returns a list of `SourceCredentialsInfo` objects.
    pub fn listSourceCredentials(self: *Self, allocator: std.mem.Allocator, input: list_source_credentials.ListSourceCredentialsInput, options: CallOptions) !list_source_credentials.ListSourceCredentialsOutput {
        return list_source_credentials.execute(self, allocator, input, options);
    }

    /// Stores a resource policy for the ARN of a `Project` or
    /// `ReportGroup` object.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Restarts a build.
    pub fn retryBuild(self: *Self, allocator: std.mem.Allocator, input: retry_build.RetryBuildInput, options: CallOptions) !retry_build.RetryBuildOutput {
        return retry_build.execute(self, allocator, input, options);
    }

    /// Restarts a failed batch build. Only batch builds that have failed can be
    /// retried.
    pub fn retryBuildBatch(self: *Self, allocator: std.mem.Allocator, input: retry_build_batch.RetryBuildBatchInput, options: CallOptions) !retry_build_batch.RetryBuildBatchOutput {
        return retry_build_batch.execute(self, allocator, input, options);
    }

    /// Starts running a build with the settings defined in the project. These
    /// setting include: how to run a build,
    /// where to get the source code, which build environment to use, which build
    /// commands to run, and where to store the build output.
    ///
    /// You can also start a build run by overriding some of the build settings in
    /// the project. The overrides only apply for that
    /// specific start build request. The settings in the project are unaltered.
    pub fn startBuild(self: *Self, allocator: std.mem.Allocator, input: start_build.StartBuildInput, options: CallOptions) !start_build.StartBuildOutput {
        return start_build.execute(self, allocator, input, options);
    }

    /// Starts a batch build for a project.
    pub fn startBuildBatch(self: *Self, allocator: std.mem.Allocator, input: start_build_batch.StartBuildBatchInput, options: CallOptions) !start_build_batch.StartBuildBatchOutput {
        return start_build_batch.execute(self, allocator, input, options);
    }

    /// Starts a command execution.
    pub fn startCommandExecution(self: *Self, allocator: std.mem.Allocator, input: start_command_execution.StartCommandExecutionInput, options: CallOptions) !start_command_execution.StartCommandExecutionOutput {
        return start_command_execution.execute(self, allocator, input, options);
    }

    /// Starts a sandbox.
    pub fn startSandbox(self: *Self, allocator: std.mem.Allocator, input: start_sandbox.StartSandboxInput, options: CallOptions) !start_sandbox.StartSandboxOutput {
        return start_sandbox.execute(self, allocator, input, options);
    }

    /// Starts a sandbox connection.
    pub fn startSandboxConnection(self: *Self, allocator: std.mem.Allocator, input: start_sandbox_connection.StartSandboxConnectionInput, options: CallOptions) !start_sandbox_connection.StartSandboxConnectionOutput {
        return start_sandbox_connection.execute(self, allocator, input, options);
    }

    /// Attempts to stop running a build.
    pub fn stopBuild(self: *Self, allocator: std.mem.Allocator, input: stop_build.StopBuildInput, options: CallOptions) !stop_build.StopBuildOutput {
        return stop_build.execute(self, allocator, input, options);
    }

    /// Stops a running batch build.
    pub fn stopBuildBatch(self: *Self, allocator: std.mem.Allocator, input: stop_build_batch.StopBuildBatchInput, options: CallOptions) !stop_build_batch.StopBuildBatchOutput {
        return stop_build_batch.execute(self, allocator, input, options);
    }

    /// Stops a sandbox.
    pub fn stopSandbox(self: *Self, allocator: std.mem.Allocator, input: stop_sandbox.StopSandboxInput, options: CallOptions) !stop_sandbox.StopSandboxOutput {
        return stop_sandbox.execute(self, allocator, input, options);
    }

    /// Updates a compute fleet.
    pub fn updateFleet(self: *Self, allocator: std.mem.Allocator, input: update_fleet.UpdateFleetInput, options: CallOptions) !update_fleet.UpdateFleetOutput {
        return update_fleet.execute(self, allocator, input, options);
    }

    /// Changes the settings of a build project.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: CallOptions) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Changes the public visibility for a project. The project's build results,
    /// logs, and
    /// artifacts are available to the general public. For more information, see
    /// [Public build
    /// projects](https://docs.aws.amazon.com/codebuild/latest/userguide/public-builds.html) in the *CodeBuild User Guide*.
    ///
    /// The following should be kept in mind when making your projects public:
    ///
    /// * All of a project's build results, logs, and artifacts, including builds
    ///   that were run
    /// when the project was private, are available to the general public.
    ///
    /// * All build logs and artifacts are available to the public. Environment
    ///   variables, source
    /// code, and other sensitive information may have been output to the build logs
    /// and artifacts.
    /// You must be careful about what information is output to the build logs. Some
    /// best practice
    /// are:
    ///
    /// * Do not store sensitive values in environment variables. We recommend that
    ///   you use an Amazon EC2 Systems Manager Parameter Store
    /// or Secrets Manager to store sensitive values.
    ///
    /// * Follow [Best
    /// practices for using
    /// webhooks](https://docs.aws.amazon.com/codebuild/latest/userguide/webhooks.html#webhook-best-practices) in the *CodeBuild User
    /// Guide* to limit which entities can trigger a build, and do
    /// not store the buildspec in the project itself, to ensure that your webhooks
    /// are as
    /// secure as possible.
    ///
    /// * A malicious user can use public builds to distribute malicious artifacts.
    ///   We recommend
    /// that you review all pull requests to verify that the pull request is a
    /// legitimate change. We
    /// also recommend that you validate any artifacts with their checksums to make
    /// sure that the
    /// correct artifacts are being downloaded.
    pub fn updateProjectVisibility(self: *Self, allocator: std.mem.Allocator, input: update_project_visibility.UpdateProjectVisibilityInput, options: CallOptions) !update_project_visibility.UpdateProjectVisibilityOutput {
        return update_project_visibility.execute(self, allocator, input, options);
    }

    /// Updates a report group.
    pub fn updateReportGroup(self: *Self, allocator: std.mem.Allocator, input: update_report_group.UpdateReportGroupInput, options: CallOptions) !update_report_group.UpdateReportGroupOutput {
        return update_report_group.execute(self, allocator, input, options);
    }

    /// Updates the webhook associated with an CodeBuild build project.
    ///
    /// If you use Bitbucket for your repository, `rotateSecret` is ignored.
    pub fn updateWebhook(self: *Self, allocator: std.mem.Allocator, input: update_webhook.UpdateWebhookInput, options: CallOptions) !update_webhook.UpdateWebhookOutput {
        return update_webhook.execute(self, allocator, input, options);
    }

    pub fn describeCodeCoveragesPaginator(self: *Self, params: describe_code_coverages.DescribeCodeCoveragesInput) paginator.DescribeCodeCoveragesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTestCasesPaginator(self: *Self, params: describe_test_cases.DescribeTestCasesInput) paginator.DescribeTestCasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBuildBatchesPaginator(self: *Self, params: list_build_batches.ListBuildBatchesInput) paginator.ListBuildBatchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBuildBatchesForProjectPaginator(self: *Self, params: list_build_batches_for_project.ListBuildBatchesForProjectInput) paginator.ListBuildBatchesForProjectPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBuildsPaginator(self: *Self, params: list_builds.ListBuildsInput) paginator.ListBuildsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBuildsForProjectPaginator(self: *Self, params: list_builds_for_project.ListBuildsForProjectInput) paginator.ListBuildsForProjectPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommandExecutionsForSandboxPaginator(self: *Self, params: list_command_executions_for_sandbox.ListCommandExecutionsForSandboxInput) paginator.ListCommandExecutionsForSandboxPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetsPaginator(self: *Self, params: list_fleets.ListFleetsInput) paginator.ListFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReportGroupsPaginator(self: *Self, params: list_report_groups.ListReportGroupsInput) paginator.ListReportGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReportsPaginator(self: *Self, params: list_reports.ListReportsInput) paginator.ListReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReportsForReportGroupPaginator(self: *Self, params: list_reports_for_report_group.ListReportsForReportGroupInput) paginator.ListReportsForReportGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSandboxesPaginator(self: *Self, params: list_sandboxes.ListSandboxesInput) paginator.ListSandboxesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSandboxesForProjectPaginator(self: *Self, params: list_sandboxes_for_project.ListSandboxesForProjectInput) paginator.ListSandboxesForProjectPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSharedProjectsPaginator(self: *Self, params: list_shared_projects.ListSharedProjectsInput) paginator.ListSharedProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSharedReportGroupsPaginator(self: *Self, params: list_shared_report_groups.ListSharedReportGroupsInput) paginator.ListSharedReportGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
