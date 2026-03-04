const aws = @import("aws");
const std = @import("std");

const create_app = @import("create_app.zig");
const create_backend_environment = @import("create_backend_environment.zig");
const create_branch = @import("create_branch.zig");
const create_deployment = @import("create_deployment.zig");
const create_domain_association = @import("create_domain_association.zig");
const create_webhook = @import("create_webhook.zig");
const delete_app = @import("delete_app.zig");
const delete_backend_environment = @import("delete_backend_environment.zig");
const delete_branch = @import("delete_branch.zig");
const delete_domain_association = @import("delete_domain_association.zig");
const delete_job = @import("delete_job.zig");
const delete_webhook = @import("delete_webhook.zig");
const generate_access_logs = @import("generate_access_logs.zig");
const get_app = @import("get_app.zig");
const get_artifact_url = @import("get_artifact_url.zig");
const get_backend_environment = @import("get_backend_environment.zig");
const get_branch = @import("get_branch.zig");
const get_domain_association = @import("get_domain_association.zig");
const get_job = @import("get_job.zig");
const get_webhook = @import("get_webhook.zig");
const list_apps = @import("list_apps.zig");
const list_artifacts = @import("list_artifacts.zig");
const list_backend_environments = @import("list_backend_environments.zig");
const list_branches = @import("list_branches.zig");
const list_domain_associations = @import("list_domain_associations.zig");
const list_jobs = @import("list_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_webhooks = @import("list_webhooks.zig");
const start_deployment = @import("start_deployment.zig");
const start_job = @import("start_job.zig");
const stop_job = @import("stop_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_app = @import("update_app.zig");
const update_branch = @import("update_branch.zig");
const update_domain_association = @import("update_domain_association.zig");
const update_webhook = @import("update_webhook.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Amplify";

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

    /// Creates a new Amplify app.
    pub fn createApp(self: *Self, allocator: std.mem.Allocator, input: create_app.CreateAppInput, options: CallOptions) !create_app.CreateAppOutput {
        return create_app.execute(self, allocator, input, options);
    }

    /// Creates a new backend environment for an Amplify app.
    ///
    /// This API is available only to Amplify Gen 1 applications where the
    /// backend is created using Amplify Studio or the Amplify
    /// command line interface (CLI). This API isn’t available to Amplify Gen 2
    /// applications. When you deploy an application with Amplify Gen 2, you
    /// provision the app's
    /// backend infrastructure using Typescript code.
    pub fn createBackendEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_backend_environment.CreateBackendEnvironmentInput, options: CallOptions) !create_backend_environment.CreateBackendEnvironmentOutput {
        return create_backend_environment.execute(self, allocator, input, options);
    }

    /// Creates a new branch for an Amplify app.
    pub fn createBranch(self: *Self, allocator: std.mem.Allocator, input: create_branch.CreateBranchInput, options: CallOptions) !create_branch.CreateBranchOutput {
        return create_branch.execute(self, allocator, input, options);
    }

    /// Creates a deployment for a manually deployed Amplify app. Manually deployed
    /// apps are
    /// not connected to a Git repository.
    ///
    /// The maximum duration between the `CreateDeployment` call and the
    /// `StartDeployment` call cannot exceed 8 hours. If the duration exceeds 8
    /// hours, the `StartDeployment` call and the associated `Job` will
    /// fail.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: CallOptions) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a new domain association for an Amplify app. This action associates
    /// a custom
    /// domain with the Amplify app
    pub fn createDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: create_domain_association.CreateDomainAssociationInput, options: CallOptions) !create_domain_association.CreateDomainAssociationOutput {
        return create_domain_association.execute(self, allocator, input, options);
    }

    /// Creates a new webhook on an Amplify app.
    pub fn createWebhook(self: *Self, allocator: std.mem.Allocator, input: create_webhook.CreateWebhookInput, options: CallOptions) !create_webhook.CreateWebhookOutput {
        return create_webhook.execute(self, allocator, input, options);
    }

    /// Deletes an existing Amplify app specified by an app ID.
    pub fn deleteApp(self: *Self, allocator: std.mem.Allocator, input: delete_app.DeleteAppInput, options: CallOptions) !delete_app.DeleteAppOutput {
        return delete_app.execute(self, allocator, input, options);
    }

    /// Deletes a backend environment for an Amplify app.
    ///
    /// This API is available only to Amplify Gen 1 applications where the
    /// backend is created using Amplify Studio or the Amplify
    /// command line interface (CLI). This API isn’t available to Amplify Gen 2
    /// applications. When you deploy an application with Amplify Gen 2, you
    /// provision the app's
    /// backend infrastructure using Typescript code.
    pub fn deleteBackendEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_backend_environment.DeleteBackendEnvironmentInput, options: CallOptions) !delete_backend_environment.DeleteBackendEnvironmentOutput {
        return delete_backend_environment.execute(self, allocator, input, options);
    }

    /// Deletes a branch for an Amplify app.
    pub fn deleteBranch(self: *Self, allocator: std.mem.Allocator, input: delete_branch.DeleteBranchInput, options: CallOptions) !delete_branch.DeleteBranchOutput {
        return delete_branch.execute(self, allocator, input, options);
    }

    /// Deletes a domain association for an Amplify app.
    pub fn deleteDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_domain_association.DeleteDomainAssociationInput, options: CallOptions) !delete_domain_association.DeleteDomainAssociationOutput {
        return delete_domain_association.execute(self, allocator, input, options);
    }

    /// Deletes a job for a branch of an Amplify app.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: CallOptions) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes a webhook.
    pub fn deleteWebhook(self: *Self, allocator: std.mem.Allocator, input: delete_webhook.DeleteWebhookInput, options: CallOptions) !delete_webhook.DeleteWebhookOutput {
        return delete_webhook.execute(self, allocator, input, options);
    }

    /// Returns the website access logs for a specific time range using a presigned
    /// URL.
    pub fn generateAccessLogs(self: *Self, allocator: std.mem.Allocator, input: generate_access_logs.GenerateAccessLogsInput, options: CallOptions) !generate_access_logs.GenerateAccessLogsOutput {
        return generate_access_logs.execute(self, allocator, input, options);
    }

    /// Returns an existing Amplify app specified by an app ID.
    pub fn getApp(self: *Self, allocator: std.mem.Allocator, input: get_app.GetAppInput, options: CallOptions) !get_app.GetAppOutput {
        return get_app.execute(self, allocator, input, options);
    }

    /// Returns the artifact info that corresponds to an artifact id.
    pub fn getArtifactUrl(self: *Self, allocator: std.mem.Allocator, input: get_artifact_url.GetArtifactUrlInput, options: CallOptions) !get_artifact_url.GetArtifactUrlOutput {
        return get_artifact_url.execute(self, allocator, input, options);
    }

    /// Returns a backend environment for an Amplify app.
    ///
    /// This API is available only to Amplify Gen 1 applications where the
    /// backend is created using Amplify Studio or the Amplify
    /// command line interface (CLI). This API isn’t available to Amplify Gen 2
    /// applications. When you deploy an application with Amplify Gen 2, you
    /// provision the app's
    /// backend infrastructure using Typescript code.
    pub fn getBackendEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_backend_environment.GetBackendEnvironmentInput, options: CallOptions) !get_backend_environment.GetBackendEnvironmentOutput {
        return get_backend_environment.execute(self, allocator, input, options);
    }

    /// Returns a branch for an Amplify app.
    pub fn getBranch(self: *Self, allocator: std.mem.Allocator, input: get_branch.GetBranchInput, options: CallOptions) !get_branch.GetBranchOutput {
        return get_branch.execute(self, allocator, input, options);
    }

    /// Returns the domain information for an Amplify app.
    pub fn getDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: get_domain_association.GetDomainAssociationInput, options: CallOptions) !get_domain_association.GetDomainAssociationOutput {
        return get_domain_association.execute(self, allocator, input, options);
    }

    /// Returns a job for a branch of an Amplify app.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: CallOptions) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Returns the webhook information that corresponds to a specified webhook ID.
    pub fn getWebhook(self: *Self, allocator: std.mem.Allocator, input: get_webhook.GetWebhookInput, options: CallOptions) !get_webhook.GetWebhookOutput {
        return get_webhook.execute(self, allocator, input, options);
    }

    /// Returns a list of the existing Amplify apps.
    pub fn listApps(self: *Self, allocator: std.mem.Allocator, input: list_apps.ListAppsInput, options: CallOptions) !list_apps.ListAppsOutput {
        return list_apps.execute(self, allocator, input, options);
    }

    /// Returns a list of end-to-end testing artifacts for a specified app, branch,
    /// and
    /// job.
    ///
    /// To return the build artifacts, use the
    /// [GetJob](https://docs.aws.amazon.com/amplify/latest/APIReference/API_GetJob.html) API.
    ///
    /// For more information about Amplify testing support, see [Setting up
    /// end-to-end Cypress tests for your Amplify
    /// application](https://docs.aws.amazon.com/amplify/latest/userguide/running-tests.html) in the
    /// *Amplify Hosting User Guide*.
    pub fn listArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_artifacts.ListArtifactsInput, options: CallOptions) !list_artifacts.ListArtifactsOutput {
        return list_artifacts.execute(self, allocator, input, options);
    }

    /// Lists the backend environments for an Amplify app.
    ///
    /// This API is available only to Amplify Gen 1 applications where the
    /// backend is created using Amplify Studio or the Amplify
    /// command line interface (CLI). This API isn’t available to Amplify Gen 2
    /// applications. When you deploy an application with Amplify Gen 2, you
    /// provision the app's
    /// backend infrastructure using Typescript code.
    pub fn listBackendEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_backend_environments.ListBackendEnvironmentsInput, options: CallOptions) !list_backend_environments.ListBackendEnvironmentsOutput {
        return list_backend_environments.execute(self, allocator, input, options);
    }

    /// Lists the branches of an Amplify app.
    pub fn listBranches(self: *Self, allocator: std.mem.Allocator, input: list_branches.ListBranchesInput, options: CallOptions) !list_branches.ListBranchesOutput {
        return list_branches.execute(self, allocator, input, options);
    }

    /// Returns the domain associations for an Amplify app.
    pub fn listDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: list_domain_associations.ListDomainAssociationsInput, options: CallOptions) !list_domain_associations.ListDomainAssociationsOutput {
        return list_domain_associations.execute(self, allocator, input, options);
    }

    /// Lists the jobs for a branch of an Amplify app.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: CallOptions) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a specified Amazon Resource Name (ARN).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of webhooks for an Amplify app.
    pub fn listWebhooks(self: *Self, allocator: std.mem.Allocator, input: list_webhooks.ListWebhooksInput, options: CallOptions) !list_webhooks.ListWebhooksOutput {
        return list_webhooks.execute(self, allocator, input, options);
    }

    /// Starts a deployment for a manually deployed app. Manually deployed apps are
    /// not
    /// connected to a Git repository.
    ///
    /// The maximum duration between the `CreateDeployment` call and the
    /// `StartDeployment` call cannot exceed 8 hours. If the duration exceeds 8
    /// hours, the `StartDeployment` call and the associated `Job` will
    /// fail.
    pub fn startDeployment(self: *Self, allocator: std.mem.Allocator, input: start_deployment.StartDeploymentInput, options: CallOptions) !start_deployment.StartDeploymentOutput {
        return start_deployment.execute(self, allocator, input, options);
    }

    /// Starts a new job for a branch of an Amplify app.
    pub fn startJob(self: *Self, allocator: std.mem.Allocator, input: start_job.StartJobInput, options: CallOptions) !start_job.StartJobOutput {
        return start_job.execute(self, allocator, input, options);
    }

    /// Stops a job that is in progress for a branch of an Amplify app.
    pub fn stopJob(self: *Self, allocator: std.mem.Allocator, input: stop_job.StopJobInput, options: CallOptions) !stop_job.StopJobOutput {
        return stop_job.execute(self, allocator, input, options);
    }

    /// Tags the resource with a tag key and value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource with a specified Amazon Resource Name (ARN).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Amplify app.
    pub fn updateApp(self: *Self, allocator: std.mem.Allocator, input: update_app.UpdateAppInput, options: CallOptions) !update_app.UpdateAppOutput {
        return update_app.execute(self, allocator, input, options);
    }

    /// Updates a branch for an Amplify app.
    pub fn updateBranch(self: *Self, allocator: std.mem.Allocator, input: update_branch.UpdateBranchInput, options: CallOptions) !update_branch.UpdateBranchOutput {
        return update_branch.execute(self, allocator, input, options);
    }

    /// Creates a new domain association for an Amplify app.
    pub fn updateDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: update_domain_association.UpdateDomainAssociationInput, options: CallOptions) !update_domain_association.UpdateDomainAssociationOutput {
        return update_domain_association.execute(self, allocator, input, options);
    }

    /// Updates a webhook.
    pub fn updateWebhook(self: *Self, allocator: std.mem.Allocator, input: update_webhook.UpdateWebhookInput, options: CallOptions) !update_webhook.UpdateWebhookOutput {
        return update_webhook.execute(self, allocator, input, options);
    }

    pub fn listAppsPaginator(self: *Self, params: list_apps.ListAppsInput) paginator.ListAppsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBranchesPaginator(self: *Self, params: list_branches.ListBranchesInput) paginator.ListBranchesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDomainAssociationsPaginator(self: *Self, params: list_domain_associations.ListDomainAssociationsInput) paginator.ListDomainAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
