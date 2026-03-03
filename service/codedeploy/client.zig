const aws = @import("aws");
const std = @import("std");

const add_tags_to_on_premises_instances = @import("add_tags_to_on_premises_instances.zig");
const batch_get_application_revisions = @import("batch_get_application_revisions.zig");
const batch_get_applications = @import("batch_get_applications.zig");
const batch_get_deployment_groups = @import("batch_get_deployment_groups.zig");
const batch_get_deployment_instances = @import("batch_get_deployment_instances.zig");
const batch_get_deployment_targets = @import("batch_get_deployment_targets.zig");
const batch_get_deployments = @import("batch_get_deployments.zig");
const batch_get_on_premises_instances = @import("batch_get_on_premises_instances.zig");
const continue_deployment = @import("continue_deployment.zig");
const create_application = @import("create_application.zig");
const create_deployment = @import("create_deployment.zig");
const create_deployment_config = @import("create_deployment_config.zig");
const create_deployment_group = @import("create_deployment_group.zig");
const delete_application = @import("delete_application.zig");
const delete_deployment_config = @import("delete_deployment_config.zig");
const delete_deployment_group = @import("delete_deployment_group.zig");
const delete_git_hub_account_token = @import("delete_git_hub_account_token.zig");
const delete_resources_by_external_id = @import("delete_resources_by_external_id.zig");
const deregister_on_premises_instance = @import("deregister_on_premises_instance.zig");
const get_application = @import("get_application.zig");
const get_application_revision = @import("get_application_revision.zig");
const get_deployment = @import("get_deployment.zig");
const get_deployment_config = @import("get_deployment_config.zig");
const get_deployment_group = @import("get_deployment_group.zig");
const get_deployment_instance = @import("get_deployment_instance.zig");
const get_deployment_target = @import("get_deployment_target.zig");
const get_on_premises_instance = @import("get_on_premises_instance.zig");
const list_application_revisions = @import("list_application_revisions.zig");
const list_applications = @import("list_applications.zig");
const list_deployment_configs = @import("list_deployment_configs.zig");
const list_deployment_groups = @import("list_deployment_groups.zig");
const list_deployment_instances = @import("list_deployment_instances.zig");
const list_deployment_targets = @import("list_deployment_targets.zig");
const list_deployments = @import("list_deployments.zig");
const list_git_hub_account_token_names = @import("list_git_hub_account_token_names.zig");
const list_on_premises_instances = @import("list_on_premises_instances.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_lifecycle_event_hook_execution_status = @import("put_lifecycle_event_hook_execution_status.zig");
const register_application_revision = @import("register_application_revision.zig");
const register_on_premises_instance = @import("register_on_premises_instance.zig");
const remove_tags_from_on_premises_instances = @import("remove_tags_from_on_premises_instances.zig");
const skip_wait_time_for_instance_termination = @import("skip_wait_time_for_instance_termination.zig");
const stop_deployment = @import("stop_deployment.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_deployment_group = @import("update_deployment_group.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CodeDeploy";

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

    /// Adds tags to on-premises instances.
    pub fn addTagsToOnPremisesInstances(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_on_premises_instances.AddTagsToOnPremisesInstancesInput, options: add_tags_to_on_premises_instances.Options) !add_tags_to_on_premises_instances.AddTagsToOnPremisesInstancesOutput {
        return add_tags_to_on_premises_instances.execute(self, allocator, input, options);
    }

    /// Gets information about one or more application revisions. The maximum number
    /// of
    /// application revisions that can be returned is 25.
    pub fn batchGetApplicationRevisions(self: *Self, allocator: std.mem.Allocator, input: batch_get_application_revisions.BatchGetApplicationRevisionsInput, options: batch_get_application_revisions.Options) !batch_get_application_revisions.BatchGetApplicationRevisionsOutput {
        return batch_get_application_revisions.execute(self, allocator, input, options);
    }

    /// Gets information about one or more applications. The maximum number of
    /// applications
    /// that can be returned is 100.
    pub fn batchGetApplications(self: *Self, allocator: std.mem.Allocator, input: batch_get_applications.BatchGetApplicationsInput, options: batch_get_applications.Options) !batch_get_applications.BatchGetApplicationsOutput {
        return batch_get_applications.execute(self, allocator, input, options);
    }

    /// Gets information about one or more deployment groups.
    pub fn batchGetDeploymentGroups(self: *Self, allocator: std.mem.Allocator, input: batch_get_deployment_groups.BatchGetDeploymentGroupsInput, options: batch_get_deployment_groups.Options) !batch_get_deployment_groups.BatchGetDeploymentGroupsOutput {
        return batch_get_deployment_groups.execute(self, allocator, input, options);
    }

    /// This method works, but is deprecated. Use `BatchGetDeploymentTargets`
    /// instead.
    ///
    /// Returns an array of one or more instances associated with a deployment. This
    /// method
    /// works with EC2/On-premises and Lambda compute platforms. The newer
    /// `BatchGetDeploymentTargets` works with all compute platforms. The maximum
    /// number of instances that can be returned is 25.
    pub fn batchGetDeploymentInstances(self: *Self, allocator: std.mem.Allocator, input: batch_get_deployment_instances.BatchGetDeploymentInstancesInput, options: batch_get_deployment_instances.Options) !batch_get_deployment_instances.BatchGetDeploymentInstancesOutput {
        return batch_get_deployment_instances.execute(self, allocator, input, options);
    }

    /// Returns an array of one or more targets associated with a deployment. This
    /// method
    /// works with all compute types and should be used instead of the deprecated
    /// `BatchGetDeploymentInstances`. The maximum number of targets that can be
    /// returned is 25.
    ///
    /// The type of targets returned depends on the deployment's compute platform or
    /// deployment method:
    ///
    /// * **EC2/On-premises**: Information about Amazon EC2 instance targets.
    ///
    /// * **Lambda**: Information about
    /// Lambda functions targets.
    ///
    /// * **Amazon ECS**: Information about Amazon ECS service targets.
    ///
    /// * **CloudFormation**: Information about
    /// targets of blue/green deployments initiated by a CloudFormation stack
    /// update.
    pub fn batchGetDeploymentTargets(self: *Self, allocator: std.mem.Allocator, input: batch_get_deployment_targets.BatchGetDeploymentTargetsInput, options: batch_get_deployment_targets.Options) !batch_get_deployment_targets.BatchGetDeploymentTargetsOutput {
        return batch_get_deployment_targets.execute(self, allocator, input, options);
    }

    /// Gets information about one or more deployments. The maximum number of
    /// deployments that
    /// can be returned is 25.
    pub fn batchGetDeployments(self: *Self, allocator: std.mem.Allocator, input: batch_get_deployments.BatchGetDeploymentsInput, options: batch_get_deployments.Options) !batch_get_deployments.BatchGetDeploymentsOutput {
        return batch_get_deployments.execute(self, allocator, input, options);
    }

    /// Gets information about one or more on-premises instances. The maximum number
    /// of
    /// on-premises instances that can be returned is 25.
    pub fn batchGetOnPremisesInstances(self: *Self, allocator: std.mem.Allocator, input: batch_get_on_premises_instances.BatchGetOnPremisesInstancesInput, options: batch_get_on_premises_instances.Options) !batch_get_on_premises_instances.BatchGetOnPremisesInstancesOutput {
        return batch_get_on_premises_instances.execute(self, allocator, input, options);
    }

    /// For a blue/green deployment, starts the process of rerouting traffic from
    /// instances in
    /// the original environment to instances in the replacement environment without
    /// waiting for
    /// a specified wait time to elapse. (Traffic rerouting, which is achieved by
    /// registering
    /// instances in the replacement environment with the load balancer, can start
    /// as soon as
    /// all instances have a status of Ready.)
    pub fn continueDeployment(self: *Self, allocator: std.mem.Allocator, input: continue_deployment.ContinueDeploymentInput, options: continue_deployment.Options) !continue_deployment.ContinueDeploymentOutput {
        return continue_deployment.execute(self, allocator, input, options);
    }

    /// Creates an application.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Deploys an application revision through the specified deployment group.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: create_deployment.Options) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a deployment configuration.
    pub fn createDeploymentConfig(self: *Self, allocator: std.mem.Allocator, input: create_deployment_config.CreateDeploymentConfigInput, options: create_deployment_config.Options) !create_deployment_config.CreateDeploymentConfigOutput {
        return create_deployment_config.execute(self, allocator, input, options);
    }

    /// Creates a deployment group to which application revisions are deployed.
    pub fn createDeploymentGroup(self: *Self, allocator: std.mem.Allocator, input: create_deployment_group.CreateDeploymentGroupInput, options: create_deployment_group.Options) !create_deployment_group.CreateDeploymentGroupOutput {
        return create_deployment_group.execute(self, allocator, input, options);
    }

    /// Deletes an application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes a deployment configuration.
    ///
    /// A deployment configuration cannot be deleted if it is currently in use.
    /// Predefined
    /// configurations cannot be deleted.
    pub fn deleteDeploymentConfig(self: *Self, allocator: std.mem.Allocator, input: delete_deployment_config.DeleteDeploymentConfigInput, options: delete_deployment_config.Options) !delete_deployment_config.DeleteDeploymentConfigOutput {
        return delete_deployment_config.execute(self, allocator, input, options);
    }

    /// Deletes a deployment group.
    pub fn deleteDeploymentGroup(self: *Self, allocator: std.mem.Allocator, input: delete_deployment_group.DeleteDeploymentGroupInput, options: delete_deployment_group.Options) !delete_deployment_group.DeleteDeploymentGroupOutput {
        return delete_deployment_group.execute(self, allocator, input, options);
    }

    /// Deletes a GitHub account connection.
    pub fn deleteGitHubAccountToken(self: *Self, allocator: std.mem.Allocator, input: delete_git_hub_account_token.DeleteGitHubAccountTokenInput, options: delete_git_hub_account_token.Options) !delete_git_hub_account_token.DeleteGitHubAccountTokenOutput {
        return delete_git_hub_account_token.execute(self, allocator, input, options);
    }

    /// Deletes resources linked to an external ID. This action only applies if you
    /// have
    /// configured blue/green deployments through CloudFormation.
    ///
    /// It is not necessary to call this action directly. CloudFormation calls it
    /// on your behalf when it needs to delete stack resources. This action is
    /// offered
    /// publicly in case you need to delete resources to comply with General Data
    /// Protection
    /// Regulation (GDPR) requirements.
    pub fn deleteResourcesByExternalId(self: *Self, allocator: std.mem.Allocator, input: delete_resources_by_external_id.DeleteResourcesByExternalIdInput, options: delete_resources_by_external_id.Options) !delete_resources_by_external_id.DeleteResourcesByExternalIdOutput {
        return delete_resources_by_external_id.execute(self, allocator, input, options);
    }

    /// Deregisters an on-premises instance.
    pub fn deregisterOnPremisesInstance(self: *Self, allocator: std.mem.Allocator, input: deregister_on_premises_instance.DeregisterOnPremisesInstanceInput, options: deregister_on_premises_instance.Options) !deregister_on_premises_instance.DeregisterOnPremisesInstanceOutput {
        return deregister_on_premises_instance.execute(self, allocator, input, options);
    }

    /// Gets information about an application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Gets information about an application revision.
    pub fn getApplicationRevision(self: *Self, allocator: std.mem.Allocator, input: get_application_revision.GetApplicationRevisionInput, options: get_application_revision.Options) !get_application_revision.GetApplicationRevisionOutput {
        return get_application_revision.execute(self, allocator, input, options);
    }

    /// Gets information about a deployment.
    ///
    /// The `content` property of the `appSpecContent` object in
    /// the returned revision is always null. Use `GetApplicationRevision` and
    /// the `sha256` property of the returned `appSpecContent` object
    /// to get the content of the deployment’s AppSpec file.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: get_deployment.Options) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Gets information about a deployment configuration.
    pub fn getDeploymentConfig(self: *Self, allocator: std.mem.Allocator, input: get_deployment_config.GetDeploymentConfigInput, options: get_deployment_config.Options) !get_deployment_config.GetDeploymentConfigOutput {
        return get_deployment_config.execute(self, allocator, input, options);
    }

    /// Gets information about a deployment group.
    pub fn getDeploymentGroup(self: *Self, allocator: std.mem.Allocator, input: get_deployment_group.GetDeploymentGroupInput, options: get_deployment_group.Options) !get_deployment_group.GetDeploymentGroupOutput {
        return get_deployment_group.execute(self, allocator, input, options);
    }

    /// Gets information about an instance as part of a deployment.
    pub fn getDeploymentInstance(self: *Self, allocator: std.mem.Allocator, input: get_deployment_instance.GetDeploymentInstanceInput, options: get_deployment_instance.Options) !get_deployment_instance.GetDeploymentInstanceOutput {
        return get_deployment_instance.execute(self, allocator, input, options);
    }

    /// Returns information about a deployment target.
    pub fn getDeploymentTarget(self: *Self, allocator: std.mem.Allocator, input: get_deployment_target.GetDeploymentTargetInput, options: get_deployment_target.Options) !get_deployment_target.GetDeploymentTargetOutput {
        return get_deployment_target.execute(self, allocator, input, options);
    }

    /// Gets information about an on-premises instance.
    pub fn getOnPremisesInstance(self: *Self, allocator: std.mem.Allocator, input: get_on_premises_instance.GetOnPremisesInstanceInput, options: get_on_premises_instance.Options) !get_on_premises_instance.GetOnPremisesInstanceOutput {
        return get_on_premises_instance.execute(self, allocator, input, options);
    }

    /// Lists information about revisions for an application.
    pub fn listApplicationRevisions(self: *Self, allocator: std.mem.Allocator, input: list_application_revisions.ListApplicationRevisionsInput, options: list_application_revisions.Options) !list_application_revisions.ListApplicationRevisionsOutput {
        return list_application_revisions.execute(self, allocator, input, options);
    }

    /// Lists the applications registered with the user or Amazon Web Services
    /// account.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists the deployment configurations with the user or Amazon Web Services
    /// account.
    pub fn listDeploymentConfigs(self: *Self, allocator: std.mem.Allocator, input: list_deployment_configs.ListDeploymentConfigsInput, options: list_deployment_configs.Options) !list_deployment_configs.ListDeploymentConfigsOutput {
        return list_deployment_configs.execute(self, allocator, input, options);
    }

    /// Lists the deployment groups for an application registered with the Amazon
    /// Web Services
    /// user or Amazon Web Services account.
    pub fn listDeploymentGroups(self: *Self, allocator: std.mem.Allocator, input: list_deployment_groups.ListDeploymentGroupsInput, options: list_deployment_groups.Options) !list_deployment_groups.ListDeploymentGroupsOutput {
        return list_deployment_groups.execute(self, allocator, input, options);
    }

    /// The newer `BatchGetDeploymentTargets` should be used instead because
    /// it works with all compute types. `ListDeploymentInstances` throws an
    /// exception if it is used with a compute platform other than EC2/On-premises
    /// or
    /// Lambda.
    ///
    /// Lists the instance for a deployment associated with the user or Amazon Web
    /// Services account.
    pub fn listDeploymentInstances(self: *Self, allocator: std.mem.Allocator, input: list_deployment_instances.ListDeploymentInstancesInput, options: list_deployment_instances.Options) !list_deployment_instances.ListDeploymentInstancesOutput {
        return list_deployment_instances.execute(self, allocator, input, options);
    }

    /// Returns an array of target IDs that are associated a deployment.
    pub fn listDeploymentTargets(self: *Self, allocator: std.mem.Allocator, input: list_deployment_targets.ListDeploymentTargetsInput, options: list_deployment_targets.Options) !list_deployment_targets.ListDeploymentTargetsOutput {
        return list_deployment_targets.execute(self, allocator, input, options);
    }

    /// Lists the deployments in a deployment group for an application registered
    /// with the
    /// user or Amazon Web Services account.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: list_deployments.Options) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the names of stored connections to GitHub accounts.
    pub fn listGitHubAccountTokenNames(self: *Self, allocator: std.mem.Allocator, input: list_git_hub_account_token_names.ListGitHubAccountTokenNamesInput, options: list_git_hub_account_token_names.Options) !list_git_hub_account_token_names.ListGitHubAccountTokenNamesOutput {
        return list_git_hub_account_token_names.execute(self, allocator, input, options);
    }

    /// Gets a list of names for one or more on-premises instances.
    ///
    /// Unless otherwise specified, both registered and deregistered on-premises
    /// instance
    /// names are listed. To list only registered or deregistered on-premises
    /// instance names,
    /// use the registration status parameter.
    pub fn listOnPremisesInstances(self: *Self, allocator: std.mem.Allocator, input: list_on_premises_instances.ListOnPremisesInstancesInput, options: list_on_premises_instances.Options) !list_on_premises_instances.ListOnPremisesInstancesOutput {
        return list_on_premises_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for the resource identified by a specified Amazon
    /// Resource
    /// Name (ARN). Tags are used to organize and categorize your CodeDeploy
    /// resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the result of a Lambda validation function. The function validates
    /// lifecycle hooks during a deployment that uses the Lambda or Amazon ECS
    /// compute platform. For Lambda deployments, the available
    /// lifecycle hooks are `BeforeAllowTraffic` and `AfterAllowTraffic`.
    /// For Amazon ECS deployments, the available lifecycle hooks are
    /// `BeforeInstall`, `AfterInstall`,
    /// `AfterAllowTestTraffic`, `BeforeAllowTraffic`, and
    /// `AfterAllowTraffic`. Lambda validation functions return
    /// `Succeeded` or `Failed`. For more information, see [AppSpec 'hooks' Section
    /// for an Lambda Deployment
    /// ](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html#appspec-hooks-lambda) and
    /// [AppSpec 'hooks' Section for an Amazon ECS
    /// Deployment](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html#appspec-hooks-ecs).
    pub fn putLifecycleEventHookExecutionStatus(self: *Self, allocator: std.mem.Allocator, input: put_lifecycle_event_hook_execution_status.PutLifecycleEventHookExecutionStatusInput, options: put_lifecycle_event_hook_execution_status.Options) !put_lifecycle_event_hook_execution_status.PutLifecycleEventHookExecutionStatusOutput {
        return put_lifecycle_event_hook_execution_status.execute(self, allocator, input, options);
    }

    /// Registers with CodeDeploy a revision for the specified application.
    pub fn registerApplicationRevision(self: *Self, allocator: std.mem.Allocator, input: register_application_revision.RegisterApplicationRevisionInput, options: register_application_revision.Options) !register_application_revision.RegisterApplicationRevisionOutput {
        return register_application_revision.execute(self, allocator, input, options);
    }

    /// Registers an on-premises instance.
    ///
    /// Only one IAM ARN (an IAM session ARN or IAM user ARN) is supported in the
    /// request. You cannot use both.
    pub fn registerOnPremisesInstance(self: *Self, allocator: std.mem.Allocator, input: register_on_premises_instance.RegisterOnPremisesInstanceInput, options: register_on_premises_instance.Options) !register_on_premises_instance.RegisterOnPremisesInstanceOutput {
        return register_on_premises_instance.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from one or more on-premises instances.
    pub fn removeTagsFromOnPremisesInstances(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_on_premises_instances.RemoveTagsFromOnPremisesInstancesInput, options: remove_tags_from_on_premises_instances.Options) !remove_tags_from_on_premises_instances.RemoveTagsFromOnPremisesInstancesOutput {
        return remove_tags_from_on_premises_instances.execute(self, allocator, input, options);
    }

    /// In a blue/green deployment, overrides any specified wait time and starts
    /// terminating
    /// instances immediately after the traffic routing is complete.
    pub fn skipWaitTimeForInstanceTermination(self: *Self, allocator: std.mem.Allocator, input: skip_wait_time_for_instance_termination.SkipWaitTimeForInstanceTerminationInput, options: skip_wait_time_for_instance_termination.Options) !skip_wait_time_for_instance_termination.SkipWaitTimeForInstanceTerminationOutput {
        return skip_wait_time_for_instance_termination.execute(self, allocator, input, options);
    }

    /// Attempts to stop an ongoing deployment.
    pub fn stopDeployment(self: *Self, allocator: std.mem.Allocator, input: stop_deployment.StopDeploymentInput, options: stop_deployment.Options) !stop_deployment.StopDeploymentOutput {
        return stop_deployment.execute(self, allocator, input, options);
    }

    /// Associates the list of tags in the input `Tags` parameter with the
    /// resource identified by the `ResourceArn` input parameter.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Disassociates a resource from a list of tags. The resource is identified by
    /// the
    /// `ResourceArn` input parameter. The tags are identified by the list of
    /// keys in the `TagKeys` input parameter.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Changes the name of an application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Changes information about a deployment group.
    pub fn updateDeploymentGroup(self: *Self, allocator: std.mem.Allocator, input: update_deployment_group.UpdateDeploymentGroupInput, options: update_deployment_group.Options) !update_deployment_group.UpdateDeploymentGroupOutput {
        return update_deployment_group.execute(self, allocator, input, options);
    }

    pub fn listApplicationRevisionsPaginator(self: *Self, params: list_application_revisions.ListApplicationRevisionsInput) paginator.ListApplicationRevisionsPaginator {
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

    pub fn listDeploymentConfigsPaginator(self: *Self, params: list_deployment_configs.ListDeploymentConfigsInput) paginator.ListDeploymentConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentGroupsPaginator(self: *Self, params: list_deployment_groups.ListDeploymentGroupsInput) paginator.ListDeploymentGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentInstancesPaginator(self: *Self, params: list_deployment_instances.ListDeploymentInstancesInput) paginator.ListDeploymentInstancesPaginator {
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

    pub fn waitUntilDeploymentSuccessful(self: *Self, params: get_deployment.GetDeploymentInput) aws.waiter.WaiterError!void {
        var w = waiters.DeploymentSuccessfulWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
