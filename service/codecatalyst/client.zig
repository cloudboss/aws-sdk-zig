const aws = @import("aws");
const std = @import("std");

const create_access_token = @import("create_access_token.zig");
const create_dev_environment = @import("create_dev_environment.zig");
const create_project = @import("create_project.zig");
const create_source_repository = @import("create_source_repository.zig");
const create_source_repository_branch = @import("create_source_repository_branch.zig");
const delete_access_token = @import("delete_access_token.zig");
const delete_dev_environment = @import("delete_dev_environment.zig");
const delete_project = @import("delete_project.zig");
const delete_source_repository = @import("delete_source_repository.zig");
const delete_space = @import("delete_space.zig");
const get_dev_environment = @import("get_dev_environment.zig");
const get_project = @import("get_project.zig");
const get_source_repository = @import("get_source_repository.zig");
const get_source_repository_clone_urls = @import("get_source_repository_clone_urls.zig");
const get_space = @import("get_space.zig");
const get_subscription = @import("get_subscription.zig");
const get_user_details = @import("get_user_details.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_run = @import("get_workflow_run.zig");
const list_access_tokens = @import("list_access_tokens.zig");
const list_dev_environment_sessions = @import("list_dev_environment_sessions.zig");
const list_dev_environments = @import("list_dev_environments.zig");
const list_event_logs = @import("list_event_logs.zig");
const list_projects = @import("list_projects.zig");
const list_source_repositories = @import("list_source_repositories.zig");
const list_source_repository_branches = @import("list_source_repository_branches.zig");
const list_spaces = @import("list_spaces.zig");
const list_workflow_runs = @import("list_workflow_runs.zig");
const list_workflows = @import("list_workflows.zig");
const start_dev_environment = @import("start_dev_environment.zig");
const start_dev_environment_session = @import("start_dev_environment_session.zig");
const start_workflow_run = @import("start_workflow_run.zig");
const stop_dev_environment = @import("stop_dev_environment.zig");
const stop_dev_environment_session = @import("stop_dev_environment_session.zig");
const update_dev_environment = @import("update_dev_environment.zig");
const update_project = @import("update_project.zig");
const update_space = @import("update_space.zig");
const verify_session = @import("verify_session.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeCatalyst";

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

    /// Creates a personal access token (PAT) for the current user. A personal
    /// access token (PAT) is similar to a password.
    /// It is associated with your user identity for use across all spaces and
    /// projects in Amazon CodeCatalyst. You use PATs to access CodeCatalyst
    /// from resources that include integrated development environments (IDEs) and
    /// Git-based source repositories.
    /// PATs represent you in Amazon CodeCatalyst and you can manage them in your
    /// user settings.For more information, see
    /// [Managing personal access tokens in Amazon
    /// CodeCatalyst](https://docs.aws.amazon.com/codecatalyst/latest/userguide/ipa-tokens-keys.html).
    pub fn createAccessToken(self: *Self, allocator: std.mem.Allocator, input: create_access_token.CreateAccessTokenInput, options: create_access_token.Options) !create_access_token.CreateAccessTokenOutput {
        return create_access_token.execute(self, allocator, input, options);
    }

    /// Creates a Dev Environment in Amazon CodeCatalyst, a cloud-based development
    /// environment that you can use to quickly work on the code stored
    /// in the source repositories of your project.
    ///
    /// When created in the Amazon CodeCatalyst console, by default a Dev
    /// Environment is configured to have a 2 core processor, 4GB of RAM, and 16GB
    /// of persistent storage. None of these
    /// defaults apply to a Dev Environment created programmatically.
    pub fn createDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_dev_environment.CreateDevEnvironmentInput, options: create_dev_environment.Options) !create_dev_environment.CreateDevEnvironmentOutput {
        return create_dev_environment.execute(self, allocator, input, options);
    }

    /// Creates a project in a specified space.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: create_project.Options) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Creates an empty Git-based source repository in a specified project. The
    /// repository is
    /// created with an initial empty commit with a default branch named `main`.
    pub fn createSourceRepository(self: *Self, allocator: std.mem.Allocator, input: create_source_repository.CreateSourceRepositoryInput, options: create_source_repository.Options) !create_source_repository.CreateSourceRepositoryOutput {
        return create_source_repository.execute(self, allocator, input, options);
    }

    /// Creates a branch in a specified source repository in Amazon CodeCatalyst.
    ///
    /// This API only creates a branch in a source repository hosted in Amazon
    /// CodeCatalyst. You cannot use this API to create a branch in a linked
    /// repository.
    pub fn createSourceRepositoryBranch(self: *Self, allocator: std.mem.Allocator, input: create_source_repository_branch.CreateSourceRepositoryBranchInput, options: create_source_repository_branch.Options) !create_source_repository_branch.CreateSourceRepositoryBranchOutput {
        return create_source_repository_branch.execute(self, allocator, input, options);
    }

    /// Deletes a specified personal access token (PAT). A personal access token can
    /// only be deleted by the user who created it.
    pub fn deleteAccessToken(self: *Self, allocator: std.mem.Allocator, input: delete_access_token.DeleteAccessTokenInput, options: delete_access_token.Options) !delete_access_token.DeleteAccessTokenOutput {
        return delete_access_token.execute(self, allocator, input, options);
    }

    /// Deletes a Dev Environment.
    pub fn deleteDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_dev_environment.DeleteDevEnvironmentInput, options: delete_dev_environment.Options) !delete_dev_environment.DeleteDevEnvironmentOutput {
        return delete_dev_environment.execute(self, allocator, input, options);
    }

    /// Deletes a project in a space.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: delete_project.Options) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a source repository in Amazon CodeCatalyst. You cannot use this API
    /// to delete a linked repository. It can only be used to delete a Amazon
    /// CodeCatalyst source repository.
    pub fn deleteSourceRepository(self: *Self, allocator: std.mem.Allocator, input: delete_source_repository.DeleteSourceRepositoryInput, options: delete_source_repository.Options) !delete_source_repository.DeleteSourceRepositoryOutput {
        return delete_source_repository.execute(self, allocator, input, options);
    }

    /// Deletes a space.
    ///
    /// Deleting a space cannot be undone. Additionally, since space names must be
    /// unique across Amazon CodeCatalyst, you cannot reuse names of deleted spaces.
    pub fn deleteSpace(self: *Self, allocator: std.mem.Allocator, input: delete_space.DeleteSpaceInput, options: delete_space.Options) !delete_space.DeleteSpaceOutput {
        return delete_space.execute(self, allocator, input, options);
    }

    /// Returns information about a Dev Environment for a source repository in a
    /// project. Dev Environments are specific to the user who creates them.
    pub fn getDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_dev_environment.GetDevEnvironmentInput, options: get_dev_environment.Options) !get_dev_environment.GetDevEnvironmentOutput {
        return get_dev_environment.execute(self, allocator, input, options);
    }

    /// Returns information about a project.
    pub fn getProject(self: *Self, allocator: std.mem.Allocator, input: get_project.GetProjectInput, options: get_project.Options) !get_project.GetProjectOutput {
        return get_project.execute(self, allocator, input, options);
    }

    /// Returns information about a source repository.
    pub fn getSourceRepository(self: *Self, allocator: std.mem.Allocator, input: get_source_repository.GetSourceRepositoryInput, options: get_source_repository.Options) !get_source_repository.GetSourceRepositoryOutput {
        return get_source_repository.execute(self, allocator, input, options);
    }

    /// Returns information about the URLs that can be used with a Git client to
    /// clone a source
    /// repository.
    pub fn getSourceRepositoryCloneUrls(self: *Self, allocator: std.mem.Allocator, input: get_source_repository_clone_urls.GetSourceRepositoryCloneUrlsInput, options: get_source_repository_clone_urls.Options) !get_source_repository_clone_urls.GetSourceRepositoryCloneUrlsOutput {
        return get_source_repository_clone_urls.execute(self, allocator, input, options);
    }

    /// Returns information about an space.
    pub fn getSpace(self: *Self, allocator: std.mem.Allocator, input: get_space.GetSpaceInput, options: get_space.Options) !get_space.GetSpaceOutput {
        return get_space.execute(self, allocator, input, options);
    }

    /// Returns information about the Amazon Web Services account used for billing
    /// purposes
    /// and the billing plan for the space.
    pub fn getSubscription(self: *Self, allocator: std.mem.Allocator, input: get_subscription.GetSubscriptionInput, options: get_subscription.Options) !get_subscription.GetSubscriptionOutput {
        return get_subscription.execute(self, allocator, input, options);
    }

    /// Returns information about a user.
    pub fn getUserDetails(self: *Self, allocator: std.mem.Allocator, input: get_user_details.GetUserDetailsInput, options: get_user_details.Options) !get_user_details.GetUserDetailsOutput {
        return get_user_details.execute(self, allocator, input, options);
    }

    /// Returns information about a workflow.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: get_workflow.Options) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Returns information about a specified run of a workflow.
    pub fn getWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: get_workflow_run.GetWorkflowRunInput, options: get_workflow_run.Options) !get_workflow_run.GetWorkflowRunOutput {
        return get_workflow_run.execute(self, allocator, input, options);
    }

    /// Lists all personal access tokens (PATs) associated with the user who calls
    /// the API. You can only list PATs associated with your Amazon Web Services
    /// Builder ID.
    pub fn listAccessTokens(self: *Self, allocator: std.mem.Allocator, input: list_access_tokens.ListAccessTokensInput, options: list_access_tokens.Options) !list_access_tokens.ListAccessTokensOutput {
        return list_access_tokens.execute(self, allocator, input, options);
    }

    /// Retrieves a list of active sessions for a Dev Environment in a project.
    pub fn listDevEnvironmentSessions(self: *Self, allocator: std.mem.Allocator, input: list_dev_environment_sessions.ListDevEnvironmentSessionsInput, options: list_dev_environment_sessions.Options) !list_dev_environment_sessions.ListDevEnvironmentSessionsOutput {
        return list_dev_environment_sessions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Dev Environments in a project.
    pub fn listDevEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_dev_environments.ListDevEnvironmentsInput, options: list_dev_environments.Options) !list_dev_environments.ListDevEnvironmentsOutput {
        return list_dev_environments.execute(self, allocator, input, options);
    }

    /// Retrieves a list of events that occurred during a specific time in a space.
    /// You can
    /// use these events to audit user and system activity in a space. For more
    /// information, see
    /// [Monitoring](https://docs.aws.amazon.com/codecatalyst/latest/userguide/ipa-monitoring.html) in the *Amazon CodeCatalyst User Guide*.
    ///
    /// ListEventLogs guarantees events for the last 30 days in a given space. You
    /// can also
    /// view and retrieve a list of management events over the last 90 days for
    /// Amazon CodeCatalyst in the
    /// CloudTrail console by viewing Event history, or by creating a trail to
    /// create
    /// and maintain a record of events that extends past 90 days. For more
    /// information, see [Working with CloudTrail Event
    /// History](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/view-cloudtrail-events.html) and [Working with
    /// CloudTrail
    /// trails](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-getting-started.html).
    pub fn listEventLogs(self: *Self, allocator: std.mem.Allocator, input: list_event_logs.ListEventLogsInput, options: list_event_logs.Options) !list_event_logs.ListEventLogsOutput {
        return list_event_logs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of projects.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: list_projects.Options) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Retrieves a list of source repositories in a project.
    pub fn listSourceRepositories(self: *Self, allocator: std.mem.Allocator, input: list_source_repositories.ListSourceRepositoriesInput, options: list_source_repositories.Options) !list_source_repositories.ListSourceRepositoriesOutput {
        return list_source_repositories.execute(self, allocator, input, options);
    }

    /// Retrieves a list of branches in a specified source repository.
    pub fn listSourceRepositoryBranches(self: *Self, allocator: std.mem.Allocator, input: list_source_repository_branches.ListSourceRepositoryBranchesInput, options: list_source_repository_branches.Options) !list_source_repository_branches.ListSourceRepositoryBranchesOutput {
        return list_source_repository_branches.execute(self, allocator, input, options);
    }

    /// Retrieves a list of spaces.
    pub fn listSpaces(self: *Self, allocator: std.mem.Allocator, input: list_spaces.ListSpacesInput, options: list_spaces.Options) !list_spaces.ListSpacesOutput {
        return list_spaces.execute(self, allocator, input, options);
    }

    /// Retrieves a list of workflow runs of a specified workflow.
    pub fn listWorkflowRuns(self: *Self, allocator: std.mem.Allocator, input: list_workflow_runs.ListWorkflowRunsInput, options: list_workflow_runs.Options) !list_workflow_runs.ListWorkflowRunsOutput {
        return list_workflow_runs.execute(self, allocator, input, options);
    }

    /// Retrieves a list of workflows in a specified project.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Starts a specified Dev Environment and puts it into an active state.
    pub fn startDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: start_dev_environment.StartDevEnvironmentInput, options: start_dev_environment.Options) !start_dev_environment.StartDevEnvironmentOutput {
        return start_dev_environment.execute(self, allocator, input, options);
    }

    /// Starts a session for a specified Dev Environment.
    pub fn startDevEnvironmentSession(self: *Self, allocator: std.mem.Allocator, input: start_dev_environment_session.StartDevEnvironmentSessionInput, options: start_dev_environment_session.Options) !start_dev_environment_session.StartDevEnvironmentSessionOutput {
        return start_dev_environment_session.execute(self, allocator, input, options);
    }

    /// Begins a run of a specified workflow.
    pub fn startWorkflowRun(self: *Self, allocator: std.mem.Allocator, input: start_workflow_run.StartWorkflowRunInput, options: start_workflow_run.Options) !start_workflow_run.StartWorkflowRunOutput {
        return start_workflow_run.execute(self, allocator, input, options);
    }

    /// Pauses a specified Dev Environment and places it in a non-running state.
    /// Stopped Dev Environments do not consume compute minutes.
    pub fn stopDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: stop_dev_environment.StopDevEnvironmentInput, options: stop_dev_environment.Options) !stop_dev_environment.StopDevEnvironmentOutput {
        return stop_dev_environment.execute(self, allocator, input, options);
    }

    /// Stops a session for a specified Dev Environment.
    pub fn stopDevEnvironmentSession(self: *Self, allocator: std.mem.Allocator, input: stop_dev_environment_session.StopDevEnvironmentSessionInput, options: stop_dev_environment_session.Options) !stop_dev_environment_session.StopDevEnvironmentSessionOutput {
        return stop_dev_environment_session.execute(self, allocator, input, options);
    }

    /// Changes one or more values for a Dev Environment. Updating certain values of
    /// the Dev Environment will cause a restart.
    pub fn updateDevEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_dev_environment.UpdateDevEnvironmentInput, options: update_dev_environment.Options) !update_dev_environment.UpdateDevEnvironmentOutput {
        return update_dev_environment.execute(self, allocator, input, options);
    }

    /// Changes one or more values for a project.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: update_project.Options) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Changes one or more values for a space.
    pub fn updateSpace(self: *Self, allocator: std.mem.Allocator, input: update_space.UpdateSpaceInput, options: update_space.Options) !update_space.UpdateSpaceOutput {
        return update_space.execute(self, allocator, input, options);
    }

    /// Verifies whether the calling user has a valid Amazon CodeCatalyst login and
    /// session. If successful, this returns the ID of the user in Amazon
    /// CodeCatalyst.
    pub fn verifySession(self: *Self, allocator: std.mem.Allocator, input: verify_session.VerifySessionInput, options: verify_session.Options) !verify_session.VerifySessionOutput {
        return verify_session.execute(self, allocator, input, options);
    }

    pub fn listAccessTokensPaginator(self: *Self, params: list_access_tokens.ListAccessTokensInput) paginator.ListAccessTokensPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevEnvironmentSessionsPaginator(self: *Self, params: list_dev_environment_sessions.ListDevEnvironmentSessionsInput) paginator.ListDevEnvironmentSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevEnvironmentsPaginator(self: *Self, params: list_dev_environments.ListDevEnvironmentsInput) paginator.ListDevEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventLogsPaginator(self: *Self, params: list_event_logs.ListEventLogsInput) paginator.ListEventLogsPaginator {
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

    pub fn listSourceRepositoriesPaginator(self: *Self, params: list_source_repositories.ListSourceRepositoriesInput) paginator.ListSourceRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourceRepositoryBranchesPaginator(self: *Self, params: list_source_repository_branches.ListSourceRepositoryBranchesInput) paginator.ListSourceRepositoryBranchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSpacesPaginator(self: *Self, params: list_spaces.ListSpacesInput) paginator.ListSpacesPaginator {
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

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
