const aws = @import("aws");
const std = @import("std");

const abort_environment_update = @import("abort_environment_update.zig");
const apply_environment_managed_action = @import("apply_environment_managed_action.zig");
const associate_environment_operations_role = @import("associate_environment_operations_role.zig");
const check_dns_availability = @import("check_dns_availability.zig");
const compose_environments = @import("compose_environments.zig");
const create_application = @import("create_application.zig");
const create_application_version = @import("create_application_version.zig");
const create_configuration_template = @import("create_configuration_template.zig");
const create_environment = @import("create_environment.zig");
const create_platform_version = @import("create_platform_version.zig");
const create_storage_location = @import("create_storage_location.zig");
const delete_application = @import("delete_application.zig");
const delete_application_version = @import("delete_application_version.zig");
const delete_configuration_template = @import("delete_configuration_template.zig");
const delete_environment_configuration = @import("delete_environment_configuration.zig");
const delete_platform_version = @import("delete_platform_version.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_application_versions = @import("describe_application_versions.zig");
const describe_applications = @import("describe_applications.zig");
const describe_configuration_options = @import("describe_configuration_options.zig");
const describe_configuration_settings = @import("describe_configuration_settings.zig");
const describe_environment_health = @import("describe_environment_health.zig");
const describe_environment_managed_action_history = @import("describe_environment_managed_action_history.zig");
const describe_environment_managed_actions = @import("describe_environment_managed_actions.zig");
const describe_environment_resources = @import("describe_environment_resources.zig");
const describe_environments = @import("describe_environments.zig");
const describe_events = @import("describe_events.zig");
const describe_instances_health = @import("describe_instances_health.zig");
const describe_platform_version = @import("describe_platform_version.zig");
const disassociate_environment_operations_role = @import("disassociate_environment_operations_role.zig");
const list_available_solution_stacks = @import("list_available_solution_stacks.zig");
const list_platform_branches = @import("list_platform_branches.zig");
const list_platform_versions = @import("list_platform_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const rebuild_environment = @import("rebuild_environment.zig");
const request_environment_info = @import("request_environment_info.zig");
const restart_app_server = @import("restart_app_server.zig");
const retrieve_environment_info = @import("retrieve_environment_info.zig");
const swap_environment_cnam_es = @import("swap_environment_cnam_es.zig");
const terminate_environment = @import("terminate_environment.zig");
const update_application = @import("update_application.zig");
const update_application_resource_lifecycle = @import("update_application_resource_lifecycle.zig");
const update_application_version = @import("update_application_version.zig");
const update_configuration_template = @import("update_configuration_template.zig");
const update_environment = @import("update_environment.zig");
const update_tags_for_resource = @import("update_tags_for_resource.zig");
const validate_configuration_settings = @import("validate_configuration_settings.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Elastic Beanstalk";

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

    /// Cancels in-progress environment configuration update or application version
    /// deployment.
    pub fn abortEnvironmentUpdate(self: *Self, allocator: std.mem.Allocator, input: abort_environment_update.AbortEnvironmentUpdateInput, options: abort_environment_update.Options) !abort_environment_update.AbortEnvironmentUpdateOutput {
        return abort_environment_update.execute(self, allocator, input, options);
    }

    /// Applies a scheduled managed action immediately. A managed action can be
    /// applied only if
    /// its status is `Scheduled`. Get the status and action ID of a managed action
    /// with
    /// DescribeEnvironmentManagedActions.
    pub fn applyEnvironmentManagedAction(self: *Self, allocator: std.mem.Allocator, input: apply_environment_managed_action.ApplyEnvironmentManagedActionInput, options: apply_environment_managed_action.Options) !apply_environment_managed_action.ApplyEnvironmentManagedActionOutput {
        return apply_environment_managed_action.execute(self, allocator, input, options);
    }

    /// Add or change the operations role used by an environment. After this call is
    /// made, Elastic Beanstalk
    /// uses the associated operations role for permissions to downstream services
    /// during subsequent
    /// calls acting on this environment. For more information, see [Operations
    /// roles](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-operationsrole.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    pub fn associateEnvironmentOperationsRole(self: *Self, allocator: std.mem.Allocator, input: associate_environment_operations_role.AssociateEnvironmentOperationsRoleInput, options: associate_environment_operations_role.Options) !associate_environment_operations_role.AssociateEnvironmentOperationsRoleOutput {
        return associate_environment_operations_role.execute(self, allocator, input, options);
    }

    /// Checks if the specified CNAME is available.
    pub fn checkDnsAvailability(self: *Self, allocator: std.mem.Allocator, input: check_dns_availability.CheckDNSAvailabilityInput, options: check_dns_availability.Options) !check_dns_availability.CheckDNSAvailabilityOutput {
        return check_dns_availability.execute(self, allocator, input, options);
    }

    /// Create or update a group of environments that each run a separate component
    /// of a single
    /// application. Takes a list of version labels that specify application source
    /// bundles for each
    /// of the environments to create or update. The name of each environment and
    /// other required
    /// information must be included in the source bundles in an environment
    /// manifest named
    /// `env.yaml`. See [Compose
    /// Environments](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environment-mgmt-compose.html)
    /// for details.
    pub fn composeEnvironments(self: *Self, allocator: std.mem.Allocator, input: compose_environments.ComposeEnvironmentsInput, options: compose_environments.Options) !compose_environments.ComposeEnvironmentsOutput {
        return compose_environments.execute(self, allocator, input, options);
    }

    /// Creates an application that has one configuration template named `default`
    /// and no application versions.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an application version for the specified application. You can create
    /// an
    /// application version from a source bundle in Amazon S3, a commit in AWS
    /// CodeCommit, or the
    /// output of an AWS CodeBuild build as follows:
    ///
    /// Specify a commit in an AWS CodeCommit repository with
    /// `SourceBuildInformation`.
    ///
    /// Specify a build in an AWS CodeBuild with `SourceBuildInformation` and
    /// `BuildConfiguration`.
    ///
    /// Specify a source bundle in S3 with `SourceBundle`
    ///
    /// Omit both `SourceBuildInformation` and `SourceBundle` to use the
    /// default sample application.
    ///
    /// After you create an application version with a specified Amazon S3 bucket
    /// and key
    /// location, you can't change that Amazon S3 location. If you change the Amazon
    /// S3 location,
    /// you receive an exception when you attempt to launch an environment from the
    /// application
    /// version.
    pub fn createApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: create_application_version.CreateApplicationVersionInput, options: create_application_version.Options) !create_application_version.CreateApplicationVersionOutput {
        return create_application_version.execute(self, allocator, input, options);
    }

    /// Creates an AWS Elastic Beanstalk configuration template, associated with a
    /// specific Elastic Beanstalk
    /// application. You define application configuration settings in a
    /// configuration template. You
    /// can then use the configuration template to deploy different versions of the
    /// application with
    /// the same configuration settings.
    ///
    /// Templates aren't associated with any environment. The `EnvironmentName`
    /// response element is always `null`.
    ///
    /// Related Topics
    ///
    /// * DescribeConfigurationOptions
    ///
    /// * DescribeConfigurationSettings
    ///
    /// * ListAvailableSolutionStacks
    pub fn createConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_configuration_template.CreateConfigurationTemplateInput, options: create_configuration_template.Options) !create_configuration_template.CreateConfigurationTemplateOutput {
        return create_configuration_template.execute(self, allocator, input, options);
    }

    /// Launches an AWS Elastic Beanstalk environment for the specified application
    /// using the specified
    /// configuration.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Create a new version of your custom platform.
    pub fn createPlatformVersion(self: *Self, allocator: std.mem.Allocator, input: create_platform_version.CreatePlatformVersionInput, options: create_platform_version.Options) !create_platform_version.CreatePlatformVersionOutput {
        return create_platform_version.execute(self, allocator, input, options);
    }

    /// Creates a bucket in Amazon S3 to store application versions, logs, and other
    /// files used
    /// by Elastic Beanstalk environments. The Elastic Beanstalk console and EB CLI
    /// call this API the
    /// first time you create an environment in a region. If the storage location
    /// already exists,
    /// `CreateStorageLocation` still returns the bucket name but does not create a
    /// new
    /// bucket.
    pub fn createStorageLocation(self: *Self, allocator: std.mem.Allocator, input: create_storage_location.CreateStorageLocationInput, options: create_storage_location.Options) !create_storage_location.CreateStorageLocationOutput {
        return create_storage_location.execute(self, allocator, input, options);
    }

    /// Deletes the specified application along with all associated versions and
    /// configurations. The application versions will not be deleted from your
    /// Amazon S3
    /// bucket.
    ///
    /// You cannot delete an application that has a running environment.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes the specified version from the specified application.
    ///
    /// You cannot delete an application version that is associated with a running
    /// environment.
    pub fn deleteApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: delete_application_version.DeleteApplicationVersionInput, options: delete_application_version.Options) !delete_application_version.DeleteApplicationVersionOutput {
        return delete_application_version.execute(self, allocator, input, options);
    }

    /// Deletes the specified configuration template.
    ///
    /// When you launch an environment using a configuration template, the
    /// environment gets a
    /// copy of the template. You can delete or modify the environment's copy of the
    /// template
    /// without affecting the running environment.
    pub fn deleteConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_template.DeleteConfigurationTemplateInput, options: delete_configuration_template.Options) !delete_configuration_template.DeleteConfigurationTemplateOutput {
        return delete_configuration_template.execute(self, allocator, input, options);
    }

    /// Deletes the draft configuration associated with the running environment.
    ///
    /// Updating a running environment with any configuration changes creates a
    /// draft
    /// configuration set. You can get the draft configuration using
    /// DescribeConfigurationSettings while the update is in progress or if the
    /// update
    /// fails. The `DeploymentStatus` for the draft configuration indicates whether
    /// the
    /// deployment is in process or has failed. The draft configuration remains in
    /// existence until it
    /// is deleted with this action.
    pub fn deleteEnvironmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_environment_configuration.DeleteEnvironmentConfigurationInput, options: delete_environment_configuration.Options) !delete_environment_configuration.DeleteEnvironmentConfigurationOutput {
        return delete_environment_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified version of a custom platform.
    pub fn deletePlatformVersion(self: *Self, allocator: std.mem.Allocator, input: delete_platform_version.DeletePlatformVersionInput, options: delete_platform_version.Options) !delete_platform_version.DeletePlatformVersionOutput {
        return delete_platform_version.execute(self, allocator, input, options);
    }

    /// Returns attributes related to AWS Elastic Beanstalk that are associated with
    /// the calling AWS
    /// account.
    ///
    /// The result currently has one set of attributes—resource quotas.
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: describe_account_attributes.Options) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Retrieve a list of application versions.
    pub fn describeApplicationVersions(self: *Self, allocator: std.mem.Allocator, input: describe_application_versions.DescribeApplicationVersionsInput, options: describe_application_versions.Options) !describe_application_versions.DescribeApplicationVersionsOutput {
        return describe_application_versions.execute(self, allocator, input, options);
    }

    /// Returns the descriptions of existing applications.
    pub fn describeApplications(self: *Self, allocator: std.mem.Allocator, input: describe_applications.DescribeApplicationsInput, options: describe_applications.Options) !describe_applications.DescribeApplicationsOutput {
        return describe_applications.execute(self, allocator, input, options);
    }

    /// Describes the configuration options that are used in a particular
    /// configuration
    /// template or environment, or that a specified solution stack defines. The
    /// description includes
    /// the values the options, their default values, and an indication of the
    /// required action on a
    /// running environment if an option value is changed.
    pub fn describeConfigurationOptions(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_options.DescribeConfigurationOptionsInput, options: describe_configuration_options.Options) !describe_configuration_options.DescribeConfigurationOptionsOutput {
        return describe_configuration_options.execute(self, allocator, input, options);
    }

    /// Returns a description of the settings for the specified configuration set,
    /// that is,
    /// either a configuration template or the configuration set associated with a
    /// running
    /// environment.
    ///
    /// When describing the settings for the configuration set associated with a
    /// running
    /// environment, it is possible to receive two sets of setting descriptions. One
    /// is the deployed
    /// configuration set, and the other is a draft configuration of an environment
    /// that is either in
    /// the process of deployment or that failed to deploy.
    ///
    /// Related Topics
    ///
    /// * DeleteEnvironmentConfiguration
    pub fn describeConfigurationSettings(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_settings.DescribeConfigurationSettingsInput, options: describe_configuration_settings.Options) !describe_configuration_settings.DescribeConfigurationSettingsOutput {
        return describe_configuration_settings.execute(self, allocator, input, options);
    }

    /// Returns information about the overall health of the specified environment.
    /// The
    /// **DescribeEnvironmentHealth** operation is only available with
    /// AWS Elastic Beanstalk Enhanced Health.
    pub fn describeEnvironmentHealth(self: *Self, allocator: std.mem.Allocator, input: describe_environment_health.DescribeEnvironmentHealthInput, options: describe_environment_health.Options) !describe_environment_health.DescribeEnvironmentHealthOutput {
        return describe_environment_health.execute(self, allocator, input, options);
    }

    /// Lists an environment's completed and failed managed actions.
    pub fn describeEnvironmentManagedActionHistory(self: *Self, allocator: std.mem.Allocator, input: describe_environment_managed_action_history.DescribeEnvironmentManagedActionHistoryInput, options: describe_environment_managed_action_history.Options) !describe_environment_managed_action_history.DescribeEnvironmentManagedActionHistoryOutput {
        return describe_environment_managed_action_history.execute(self, allocator, input, options);
    }

    /// Lists an environment's upcoming and in-progress managed actions.
    pub fn describeEnvironmentManagedActions(self: *Self, allocator: std.mem.Allocator, input: describe_environment_managed_actions.DescribeEnvironmentManagedActionsInput, options: describe_environment_managed_actions.Options) !describe_environment_managed_actions.DescribeEnvironmentManagedActionsOutput {
        return describe_environment_managed_actions.execute(self, allocator, input, options);
    }

    /// Returns AWS resources for this environment.
    pub fn describeEnvironmentResources(self: *Self, allocator: std.mem.Allocator, input: describe_environment_resources.DescribeEnvironmentResourcesInput, options: describe_environment_resources.Options) !describe_environment_resources.DescribeEnvironmentResourcesOutput {
        return describe_environment_resources.execute(self, allocator, input, options);
    }

    /// Returns descriptions for existing environments.
    pub fn describeEnvironments(self: *Self, allocator: std.mem.Allocator, input: describe_environments.DescribeEnvironmentsInput, options: describe_environments.Options) !describe_environments.DescribeEnvironmentsOutput {
        return describe_environments.execute(self, allocator, input, options);
    }

    /// Returns list of event descriptions matching criteria up to the last 6 weeks.
    ///
    /// This action returns the most recent 1,000 events from the specified
    /// `NextToken`.
    pub fn describeEvents(self: *Self, allocator: std.mem.Allocator, input: describe_events.DescribeEventsInput, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        return describe_events.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about the health of instances in your AWS
    /// Elastic
    /// Beanstalk. This operation requires [enhanced health
    /// reporting](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced.html).
    pub fn describeInstancesHealth(self: *Self, allocator: std.mem.Allocator, input: describe_instances_health.DescribeInstancesHealthInput, options: describe_instances_health.Options) !describe_instances_health.DescribeInstancesHealthOutput {
        return describe_instances_health.execute(self, allocator, input, options);
    }

    /// Describes a platform version. Provides full details. Compare to
    /// ListPlatformVersions, which provides summary information about a list of
    /// platform versions.
    ///
    /// For definitions of platform version and other platform-related terms, see
    /// [AWS Elastic Beanstalk
    /// Platforms
    /// Glossary](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/platforms-glossary.html).
    pub fn describePlatformVersion(self: *Self, allocator: std.mem.Allocator, input: describe_platform_version.DescribePlatformVersionInput, options: describe_platform_version.Options) !describe_platform_version.DescribePlatformVersionOutput {
        return describe_platform_version.execute(self, allocator, input, options);
    }

    /// Disassociate the operations role from an environment. After this call is
    /// made, Elastic Beanstalk uses
    /// the caller's permissions for permissions to downstream services during
    /// subsequent calls acting
    /// on this environment. For more information, see [Operations
    /// roles](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-operationsrole.html) in the
    /// *AWS Elastic Beanstalk Developer Guide*.
    pub fn disassociateEnvironmentOperationsRole(self: *Self, allocator: std.mem.Allocator, input: disassociate_environment_operations_role.DisassociateEnvironmentOperationsRoleInput, options: disassociate_environment_operations_role.Options) !disassociate_environment_operations_role.DisassociateEnvironmentOperationsRoleOutput {
        return disassociate_environment_operations_role.execute(self, allocator, input, options);
    }

    /// Returns a list of the available solution stack names, with the public
    /// version first and
    /// then in reverse chronological order.
    pub fn listAvailableSolutionStacks(self: *Self, allocator: std.mem.Allocator, input: list_available_solution_stacks.ListAvailableSolutionStacksInput, options: list_available_solution_stacks.Options) !list_available_solution_stacks.ListAvailableSolutionStacksOutput {
        return list_available_solution_stacks.execute(self, allocator, input, options);
    }

    /// Lists the platform branches available for your account in an AWS Region.
    /// Provides
    /// summary information about each platform branch.
    ///
    /// For definitions of platform branch and other platform-related terms, see
    /// [AWS Elastic Beanstalk
    /// Platforms
    /// Glossary](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/platforms-glossary.html).
    pub fn listPlatformBranches(self: *Self, allocator: std.mem.Allocator, input: list_platform_branches.ListPlatformBranchesInput, options: list_platform_branches.Options) !list_platform_branches.ListPlatformBranchesOutput {
        return list_platform_branches.execute(self, allocator, input, options);
    }

    /// Lists the platform versions available for your account in an AWS Region.
    /// Provides
    /// summary information about each platform version. Compare to
    /// DescribePlatformVersion, which provides full details about a single platform
    /// version.
    ///
    /// For definitions of platform version and other platform-related terms, see
    /// [AWS Elastic Beanstalk
    /// Platforms
    /// Glossary](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/platforms-glossary.html).
    pub fn listPlatformVersions(self: *Self, allocator: std.mem.Allocator, input: list_platform_versions.ListPlatformVersionsInput, options: list_platform_versions.Options) !list_platform_versions.ListPlatformVersionsOutput {
        return list_platform_versions.execute(self, allocator, input, options);
    }

    /// Return the tags applied to an AWS Elastic Beanstalk resource. The response
    /// contains a list of tag key-value pairs.
    ///
    /// Elastic Beanstalk supports tagging of all of its resources. For details
    /// about resource tagging, see
    /// [Tagging Application
    /// Resources](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/applications-tagging-resources.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Deletes and recreates all of the AWS resources (for example: the Auto
    /// Scaling group,
    /// load balancer, etc.) for a specified environment and forces a restart.
    pub fn rebuildEnvironment(self: *Self, allocator: std.mem.Allocator, input: rebuild_environment.RebuildEnvironmentInput, options: rebuild_environment.Options) !rebuild_environment.RebuildEnvironmentOutput {
        return rebuild_environment.execute(self, allocator, input, options);
    }

    /// Initiates a request to compile the specified type of information of the
    /// deployed
    /// environment.
    ///
    /// Setting the `InfoType` to `tail` compiles the last lines from
    /// the application server log files of every Amazon EC2 instance in your
    /// environment.
    ///
    /// Setting the `InfoType` to `bundle` compresses the application
    /// server log files for every Amazon EC2 instance into a `.zip` file. Legacy
    /// and .NET
    /// containers do not support bundle logs.
    ///
    /// Use RetrieveEnvironmentInfo to obtain the set of logs.
    ///
    /// Related Topics
    ///
    /// * RetrieveEnvironmentInfo
    pub fn requestEnvironmentInfo(self: *Self, allocator: std.mem.Allocator, input: request_environment_info.RequestEnvironmentInfoInput, options: request_environment_info.Options) !request_environment_info.RequestEnvironmentInfoOutput {
        return request_environment_info.execute(self, allocator, input, options);
    }

    /// Causes the environment to restart the application container server running
    /// on each
    /// Amazon EC2 instance.
    pub fn restartAppServer(self: *Self, allocator: std.mem.Allocator, input: restart_app_server.RestartAppServerInput, options: restart_app_server.Options) !restart_app_server.RestartAppServerOutput {
        return restart_app_server.execute(self, allocator, input, options);
    }

    /// Retrieves the compiled information from a RequestEnvironmentInfo
    /// request.
    ///
    /// Related Topics
    ///
    /// * RequestEnvironmentInfo
    pub fn retrieveEnvironmentInfo(self: *Self, allocator: std.mem.Allocator, input: retrieve_environment_info.RetrieveEnvironmentInfoInput, options: retrieve_environment_info.Options) !retrieve_environment_info.RetrieveEnvironmentInfoOutput {
        return retrieve_environment_info.execute(self, allocator, input, options);
    }

    /// Swaps the CNAMEs of two environments.
    pub fn swapEnvironmentCnamEs(self: *Self, allocator: std.mem.Allocator, input: swap_environment_cnam_es.SwapEnvironmentCNAMEsInput, options: swap_environment_cnam_es.Options) !swap_environment_cnam_es.SwapEnvironmentCNAMEsOutput {
        return swap_environment_cnam_es.execute(self, allocator, input, options);
    }

    /// Terminates the specified environment.
    pub fn terminateEnvironment(self: *Self, allocator: std.mem.Allocator, input: terminate_environment.TerminateEnvironmentInput, options: terminate_environment.Options) !terminate_environment.TerminateEnvironmentOutput {
        return terminate_environment.execute(self, allocator, input, options);
    }

    /// Updates the specified application to have the specified properties.
    ///
    /// If a property (for example, `description`) is not provided, the value
    /// remains unchanged. To clear these properties, specify an empty string.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Modifies lifecycle settings for an application.
    pub fn updateApplicationResourceLifecycle(self: *Self, allocator: std.mem.Allocator, input: update_application_resource_lifecycle.UpdateApplicationResourceLifecycleInput, options: update_application_resource_lifecycle.Options) !update_application_resource_lifecycle.UpdateApplicationResourceLifecycleOutput {
        return update_application_resource_lifecycle.execute(self, allocator, input, options);
    }

    /// Updates the specified application version to have the specified properties.
    ///
    /// If a property (for example, `description`) is not provided, the value
    /// remains unchanged. To clear properties, specify an empty string.
    pub fn updateApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: update_application_version.UpdateApplicationVersionInput, options: update_application_version.Options) !update_application_version.UpdateApplicationVersionOutput {
        return update_application_version.execute(self, allocator, input, options);
    }

    /// Updates the specified configuration template to have the specified
    /// properties or
    /// configuration option values.
    ///
    /// If a property (for example, `ApplicationName`) is not provided, its value
    /// remains unchanged. To clear such properties, specify an empty string.
    ///
    /// Related Topics
    ///
    /// * DescribeConfigurationOptions
    pub fn updateConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_configuration_template.UpdateConfigurationTemplateInput, options: update_configuration_template.Options) !update_configuration_template.UpdateConfigurationTemplateOutput {
        return update_configuration_template.execute(self, allocator, input, options);
    }

    /// Updates the environment description, deploys a new application version,
    /// updates the
    /// configuration settings to an entirely new configuration template, or updates
    /// select
    /// configuration option values in the running environment.
    ///
    /// Attempting to update both the release and configuration is not allowed and
    /// AWS Elastic
    /// Beanstalk returns an `InvalidParameterCombination` error.
    ///
    /// When updating the configuration settings to a new template or individual
    /// settings, a
    /// draft configuration is created and DescribeConfigurationSettings for this
    /// environment returns two setting descriptions with different
    /// `DeploymentStatus`
    /// values.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Update the list of tags applied to an AWS Elastic Beanstalk resource. Two
    /// lists can be passed: `TagsToAdd`
    /// for tags to add or update, and `TagsToRemove`.
    ///
    /// Elastic Beanstalk supports tagging of all of its resources. For details
    /// about resource tagging, see
    /// [Tagging Application
    /// Resources](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/applications-tagging-resources.html).
    ///
    /// If you create a custom IAM user policy to control permission to this
    /// operation, specify
    /// one of the following two virtual actions (or both) instead of the API
    /// operation name:
    ///
    /// **elasticbeanstalk:AddTags**
    ///
    /// Controls permission to call `UpdateTagsForResource` and pass a list of tags
    /// to add in the `TagsToAdd`
    /// parameter.
    ///
    /// **elasticbeanstalk:RemoveTags**
    ///
    /// Controls permission to call `UpdateTagsForResource` and pass a list of tag
    /// keys to remove in the `TagsToRemove`
    /// parameter.
    ///
    /// For details about creating a custom user policy, see [Creating a Custom User
    /// Policy](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/AWSHowTo.iam.managed-policies.html#AWSHowTo.iam.policies).
    pub fn updateTagsForResource(self: *Self, allocator: std.mem.Allocator, input: update_tags_for_resource.UpdateTagsForResourceInput, options: update_tags_for_resource.Options) !update_tags_for_resource.UpdateTagsForResourceOutput {
        return update_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Takes a set of configuration settings and either a configuration template or
    /// environment, and determines whether those values are valid.
    ///
    /// This action returns a list of messages indicating any errors or warnings
    /// associated
    /// with the selection of option values.
    pub fn validateConfigurationSettings(self: *Self, allocator: std.mem.Allocator, input: validate_configuration_settings.ValidateConfigurationSettingsInput, options: validate_configuration_settings.Options) !validate_configuration_settings.ValidateConfigurationSettingsOutput {
        return validate_configuration_settings.execute(self, allocator, input, options);
    }

    pub fn describeEnvironmentManagedActionHistoryPaginator(self: *Self, params: describe_environment_managed_action_history.DescribeEnvironmentManagedActionHistoryInput) paginator.DescribeEnvironmentManagedActionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEventsPaginator(self: *Self, params: describe_events.DescribeEventsInput) paginator.DescribeEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlatformBranchesPaginator(self: *Self, params: list_platform_branches.ListPlatformBranchesInput) paginator.ListPlatformBranchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlatformVersionsPaginator(self: *Self, params: list_platform_versions.ListPlatformVersionsInput) paginator.ListPlatformVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
