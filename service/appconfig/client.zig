const aws = @import("aws");
const std = @import("std");

const create_application = @import("create_application.zig");
const create_configuration_profile = @import("create_configuration_profile.zig");
const create_deployment_strategy = @import("create_deployment_strategy.zig");
const create_environment = @import("create_environment.zig");
const create_extension = @import("create_extension.zig");
const create_extension_association = @import("create_extension_association.zig");
const create_hosted_configuration_version = @import("create_hosted_configuration_version.zig");
const delete_application = @import("delete_application.zig");
const delete_configuration_profile = @import("delete_configuration_profile.zig");
const delete_deployment_strategy = @import("delete_deployment_strategy.zig");
const delete_environment = @import("delete_environment.zig");
const delete_extension = @import("delete_extension.zig");
const delete_extension_association = @import("delete_extension_association.zig");
const delete_hosted_configuration_version = @import("delete_hosted_configuration_version.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_application = @import("get_application.zig");
const get_configuration = @import("get_configuration.zig");
const get_configuration_profile = @import("get_configuration_profile.zig");
const get_deployment = @import("get_deployment.zig");
const get_deployment_strategy = @import("get_deployment_strategy.zig");
const get_environment = @import("get_environment.zig");
const get_extension = @import("get_extension.zig");
const get_extension_association = @import("get_extension_association.zig");
const get_hosted_configuration_version = @import("get_hosted_configuration_version.zig");
const list_applications = @import("list_applications.zig");
const list_configuration_profiles = @import("list_configuration_profiles.zig");
const list_deployment_strategies = @import("list_deployment_strategies.zig");
const list_deployments = @import("list_deployments.zig");
const list_environments = @import("list_environments.zig");
const list_extension_associations = @import("list_extension_associations.zig");
const list_extensions = @import("list_extensions.zig");
const list_hosted_configuration_versions = @import("list_hosted_configuration_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_deployment = @import("start_deployment.zig");
const stop_deployment = @import("stop_deployment.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_application = @import("update_application.zig");
const update_configuration_profile = @import("update_configuration_profile.zig");
const update_deployment_strategy = @import("update_deployment_strategy.zig");
const update_environment = @import("update_environment.zig");
const update_extension = @import("update_extension.zig");
const update_extension_association = @import("update_extension_association.zig");
const validate_configuration = @import("validate_configuration.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppConfig";

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

    /// Creates an application. In AppConfig, an application is simply an
    /// organizational construct like a folder. This organizational construct has a
    /// relationship
    /// with some unit of executable code. For example, you could create an
    /// application called
    /// MyMobileApp to organize and manage configuration data for a mobile
    /// application installed by
    /// your users.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a configuration profile, which is information that enables AppConfig
    /// to access the configuration source. Valid configuration sources include the
    /// following:
    ///
    /// * Configuration data in YAML, JSON, and other formats stored in the
    ///   AppConfig hosted configuration store
    ///
    /// * Configuration data stored as objects in an Amazon Simple Storage Service
    ///   (Amazon S3)
    /// bucket
    ///
    /// * Pipelines stored in CodePipeline
    ///
    /// * Secrets stored in Secrets Manager
    ///
    /// * Standard and secure string parameters stored in Amazon Web Services
    ///   Systems Manager Parameter Store
    ///
    /// * Configuration data in SSM documents stored in the Systems Manager document
    ///   store
    ///
    /// A configuration profile includes the following information:
    ///
    /// * The URI location of the configuration data.
    ///
    /// * The Identity and Access Management (IAM) role that provides access to the
    ///   configuration data.
    ///
    /// * A validator for the configuration data. Available validators include
    ///   either a JSON
    /// Schema or an Amazon Web Services Lambda function.
    ///
    /// For more information, see [Create a
    /// Configuration and a Configuration
    /// Profile](http://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-creating-configuration-and-profile.html) in the *AppConfig
    /// User Guide*.
    pub fn createConfigurationProfile(self: *Self, allocator: std.mem.Allocator, input: create_configuration_profile.CreateConfigurationProfileInput, options: create_configuration_profile.Options) !create_configuration_profile.CreateConfigurationProfileOutput {
        return create_configuration_profile.execute(self, allocator, input, options);
    }

    /// Creates a deployment strategy that defines important criteria for rolling
    /// out your
    /// configuration to the designated targets. A deployment strategy includes the
    /// overall
    /// duration required, a percentage of targets to receive the deployment during
    /// each interval,
    /// an algorithm that defines how percentage grows, and bake time.
    pub fn createDeploymentStrategy(self: *Self, allocator: std.mem.Allocator, input: create_deployment_strategy.CreateDeploymentStrategyInput, options: create_deployment_strategy.Options) !create_deployment_strategy.CreateDeploymentStrategyOutput {
        return create_deployment_strategy.execute(self, allocator, input, options);
    }

    /// Creates an environment. For each application, you define one or more
    /// environments. An
    /// environment is a deployment group of AppConfig targets, such as applications
    /// in a
    /// `Beta` or `Production` environment. You can also define
    /// environments for application subcomponents such as the `Web`,
    /// `Mobile` and `Back-end` components for your application. You can
    /// configure Amazon CloudWatch alarms for each environment. The system monitors
    /// alarms during a
    /// configuration deployment. If an alarm is triggered, the system rolls back
    /// the
    /// configuration.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates an AppConfig extension. An extension augments your ability to inject
    /// logic or behavior at different points during the AppConfig workflow of
    /// creating
    /// or deploying a configuration.
    ///
    /// You can create your own extensions or use the Amazon Web Services authored
    /// extensions provided by
    /// AppConfig. For an AppConfig extension that uses Lambda, you must create a
    /// Lambda function to perform any computation and processing
    /// defined in the extension. If you plan to create custom versions of the
    /// Amazon Web Services
    /// authored notification extensions, you only need to specify an Amazon
    /// Resource Name (ARN) in
    /// the `Uri` field for the new extension version.
    ///
    /// * For a custom EventBridge notification extension, enter the ARN of the
    ///   EventBridge
    /// default events in the `Uri` field.
    ///
    /// * For a custom Amazon SNS notification extension, enter the ARN of an Amazon
    ///   SNS
    /// topic in the `Uri` field.
    ///
    /// * For a custom Amazon SQS notification extension, enter the ARN of an Amazon
    ///   SQS
    /// message queue in the `Uri` field.
    ///
    /// For more information about extensions, see [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn createExtension(self: *Self, allocator: std.mem.Allocator, input: create_extension.CreateExtensionInput, options: create_extension.Options) !create_extension.CreateExtensionOutput {
        return create_extension.execute(self, allocator, input, options);
    }

    /// When you create an extension or configure an Amazon Web Services authored
    /// extension, you
    /// associate the extension with an AppConfig application, environment, or
    /// configuration profile. For example, you can choose to run the `AppConfig
    /// deployment events to Amazon SNS`
    /// Amazon Web Services authored extension and receive notifications on an
    /// Amazon SNS
    /// topic anytime a configuration deployment is started for a specific
    /// application. Defining
    /// which extension to associate with an AppConfig resource is called an
    /// *extension association*. An extension association is a specified
    /// relationship between an extension and an AppConfig resource, such as an
    /// application or a configuration profile. For more information about
    /// extensions and
    /// associations, see [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn createExtensionAssociation(self: *Self, allocator: std.mem.Allocator, input: create_extension_association.CreateExtensionAssociationInput, options: create_extension_association.Options) !create_extension_association.CreateExtensionAssociationOutput {
        return create_extension_association.execute(self, allocator, input, options);
    }

    /// Creates a new configuration in the AppConfig hosted configuration store. If
    /// you're creating a feature flag, we recommend you familiarize yourself with
    /// the JSON schema
    /// for feature flag data. For more information, see [Type reference for
    /// AWS.AppConfig.FeatureFlags](https://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-creating-configuration-and-profile-feature-flags.html#appconfig-type-reference-feature-flags) in the
    /// *AppConfig User Guide*.
    pub fn createHostedConfigurationVersion(self: *Self, allocator: std.mem.Allocator, input: create_hosted_configuration_version.CreateHostedConfigurationVersionInput, options: create_hosted_configuration_version.Options) !create_hosted_configuration_version.CreateHostedConfigurationVersionOutput {
        return create_hosted_configuration_version.execute(self, allocator, input, options);
    }

    /// Deletes an application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes a configuration profile.
    ///
    /// To prevent users from unintentionally deleting actively-used configuration
    /// profiles,
    /// enable [deletion
    /// protection](https://docs.aws.amazon.com/appconfig/latest/userguide/deletion-protection.html).
    pub fn deleteConfigurationProfile(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_profile.DeleteConfigurationProfileInput, options: delete_configuration_profile.Options) !delete_configuration_profile.DeleteConfigurationProfileOutput {
        return delete_configuration_profile.execute(self, allocator, input, options);
    }

    /// Deletes a deployment strategy.
    pub fn deleteDeploymentStrategy(self: *Self, allocator: std.mem.Allocator, input: delete_deployment_strategy.DeleteDeploymentStrategyInput, options: delete_deployment_strategy.Options) !delete_deployment_strategy.DeleteDeploymentStrategyOutput {
        return delete_deployment_strategy.execute(self, allocator, input, options);
    }

    /// Deletes an environment.
    ///
    /// To prevent users from unintentionally deleting actively-used environments,
    /// enable [deletion
    /// protection](https://docs.aws.amazon.com/appconfig/latest/userguide/deletion-protection.html).
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes an AppConfig extension. You must delete all associations to an
    /// extension before you delete the extension.
    pub fn deleteExtension(self: *Self, allocator: std.mem.Allocator, input: delete_extension.DeleteExtensionInput, options: delete_extension.Options) !delete_extension.DeleteExtensionOutput {
        return delete_extension.execute(self, allocator, input, options);
    }

    /// Deletes an extension association. This action doesn't delete extensions
    /// defined in the
    /// association.
    pub fn deleteExtensionAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_extension_association.DeleteExtensionAssociationInput, options: delete_extension_association.Options) !delete_extension_association.DeleteExtensionAssociationOutput {
        return delete_extension_association.execute(self, allocator, input, options);
    }

    /// Deletes a version of a configuration from the AppConfig hosted configuration
    /// store.
    pub fn deleteHostedConfigurationVersion(self: *Self, allocator: std.mem.Allocator, input: delete_hosted_configuration_version.DeleteHostedConfigurationVersionInput, options: delete_hosted_configuration_version.Options) !delete_hosted_configuration_version.DeleteHostedConfigurationVersionOutput {
        return delete_hosted_configuration_version.execute(self, allocator, input, options);
    }

    /// Returns information about the status of the `DeletionProtection`
    /// parameter.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: get_account_settings.Options) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Retrieves information about an application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// (Deprecated) Retrieves the latest deployed configuration.
    ///
    /// Note the following important information.
    ///
    /// * This API action is deprecated. Calls to receive configuration data should
    ///   use
    /// the
    /// [StartConfigurationSession](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/API_appconfigdata_StartConfigurationSession.html) and [GetLatestConfiguration](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/API_appconfigdata_GetLatestConfiguration.html) APIs instead.
    ///
    /// * GetConfiguration is a priced call. For more information, see
    /// [Pricing](https://aws.amazon.com/systems-manager/pricing/).
    pub fn getConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_configuration.GetConfigurationInput, options: get_configuration.Options) !get_configuration.GetConfigurationOutput {
        return get_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a configuration profile.
    pub fn getConfigurationProfile(self: *Self, allocator: std.mem.Allocator, input: get_configuration_profile.GetConfigurationProfileInput, options: get_configuration_profile.Options) !get_configuration_profile.GetConfigurationProfileOutput {
        return get_configuration_profile.execute(self, allocator, input, options);
    }

    /// Retrieves information about a configuration deployment.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: get_deployment.Options) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Retrieves information about a deployment strategy. A deployment strategy
    /// defines
    /// important criteria for rolling out your configuration to the designated
    /// targets. A
    /// deployment strategy includes the overall duration required, a percentage of
    /// targets to
    /// receive the deployment during each interval, an algorithm that defines how
    /// percentage
    /// grows, and bake time.
    pub fn getDeploymentStrategy(self: *Self, allocator: std.mem.Allocator, input: get_deployment_strategy.GetDeploymentStrategyInput, options: get_deployment_strategy.Options) !get_deployment_strategy.GetDeploymentStrategyOutput {
        return get_deployment_strategy.execute(self, allocator, input, options);
    }

    /// Retrieves information about an environment. An environment is a deployment
    /// group of
    /// AppConfig applications, such as applications in a `Production`
    /// environment or in an `EU_Region` environment. Each configuration deployment
    /// targets an environment. You can enable one or more Amazon CloudWatch alarms
    /// for an environment. If
    /// an alarm is triggered during a deployment, AppConfig roles back the
    /// configuration.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: get_environment.Options) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Returns information about an AppConfig extension.
    pub fn getExtension(self: *Self, allocator: std.mem.Allocator, input: get_extension.GetExtensionInput, options: get_extension.Options) !get_extension.GetExtensionOutput {
        return get_extension.execute(self, allocator, input, options);
    }

    /// Returns information about an AppConfig extension association. For more
    /// information about extensions and associations, see [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn getExtensionAssociation(self: *Self, allocator: std.mem.Allocator, input: get_extension_association.GetExtensionAssociationInput, options: get_extension_association.Options) !get_extension_association.GetExtensionAssociationOutput {
        return get_extension_association.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific configuration version.
    pub fn getHostedConfigurationVersion(self: *Self, allocator: std.mem.Allocator, input: get_hosted_configuration_version.GetHostedConfigurationVersionInput, options: get_hosted_configuration_version.Options) !get_hosted_configuration_version.GetHostedConfigurationVersionOutput {
        return get_hosted_configuration_version.execute(self, allocator, input, options);
    }

    /// Lists all applications in your Amazon Web Services account.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists the configuration profiles for an application.
    pub fn listConfigurationProfiles(self: *Self, allocator: std.mem.Allocator, input: list_configuration_profiles.ListConfigurationProfilesInput, options: list_configuration_profiles.Options) !list_configuration_profiles.ListConfigurationProfilesOutput {
        return list_configuration_profiles.execute(self, allocator, input, options);
    }

    /// Lists deployment strategies.
    pub fn listDeploymentStrategies(self: *Self, allocator: std.mem.Allocator, input: list_deployment_strategies.ListDeploymentStrategiesInput, options: list_deployment_strategies.Options) !list_deployment_strategies.ListDeploymentStrategiesOutput {
        return list_deployment_strategies.execute(self, allocator, input, options);
    }

    /// Lists the deployments for an environment in descending deployment number
    /// order.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: list_deployments.Options) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the environments for an application.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists all AppConfig extension associations in the account. For more
    /// information about extensions and associations, see [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn listExtensionAssociations(self: *Self, allocator: std.mem.Allocator, input: list_extension_associations.ListExtensionAssociationsInput, options: list_extension_associations.Options) !list_extension_associations.ListExtensionAssociationsOutput {
        return list_extension_associations.execute(self, allocator, input, options);
    }

    /// Lists all custom and Amazon Web Services authored AppConfig extensions in
    /// the
    /// account. For more information about extensions, see [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn listExtensions(self: *Self, allocator: std.mem.Allocator, input: list_extensions.ListExtensionsInput, options: list_extensions.Options) !list_extensions.ListExtensionsOutput {
        return list_extensions.execute(self, allocator, input, options);
    }

    /// Lists configurations stored in the AppConfig hosted configuration store by
    /// version.
    pub fn listHostedConfigurationVersions(self: *Self, allocator: std.mem.Allocator, input: list_hosted_configuration_versions.ListHostedConfigurationVersionsInput, options: list_hosted_configuration_versions.Options) !list_hosted_configuration_versions.ListHostedConfigurationVersionsOutput {
        return list_hosted_configuration_versions.execute(self, allocator, input, options);
    }

    /// Retrieves the list of key-value tags assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a deployment.
    pub fn startDeployment(self: *Self, allocator: std.mem.Allocator, input: start_deployment.StartDeploymentInput, options: start_deployment.Options) !start_deployment.StartDeploymentOutput {
        return start_deployment.execute(self, allocator, input, options);
    }

    /// Stops a deployment. This API action works only on deployments that have a
    /// status of
    /// `DEPLOYING`, unless an `AllowRevert` parameter is supplied. If the
    /// `AllowRevert` parameter is supplied, the status of an in-progress deployment
    /// will be `ROLLED_BACK`. The status of a completed deployment will be
    /// `REVERTED`. AppConfig only allows a revert within 72 hours of
    /// deployment completion.
    pub fn stopDeployment(self: *Self, allocator: std.mem.Allocator, input: stop_deployment.StopDeploymentInput, options: stop_deployment.Options) !stop_deployment.StopDeploymentOutput {
        return stop_deployment.execute(self, allocator, input, options);
    }

    /// Assigns metadata to an AppConfig resource. Tags help organize and categorize
    /// your AppConfig resources. Each tag consists of a key and an optional value,
    /// both
    /// of which you define. You can specify a maximum of 50 tags for a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes a tag key and value from an AppConfig resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the value of the `DeletionProtection` parameter.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: update_account_settings.Options) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Updates an application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates a configuration profile.
    pub fn updateConfigurationProfile(self: *Self, allocator: std.mem.Allocator, input: update_configuration_profile.UpdateConfigurationProfileInput, options: update_configuration_profile.Options) !update_configuration_profile.UpdateConfigurationProfileOutput {
        return update_configuration_profile.execute(self, allocator, input, options);
    }

    /// Updates a deployment strategy.
    pub fn updateDeploymentStrategy(self: *Self, allocator: std.mem.Allocator, input: update_deployment_strategy.UpdateDeploymentStrategyInput, options: update_deployment_strategy.Options) !update_deployment_strategy.UpdateDeploymentStrategyOutput {
        return update_deployment_strategy.execute(self, allocator, input, options);
    }

    /// Updates an environment.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Updates an AppConfig extension. For more information about extensions, see
    /// [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn updateExtension(self: *Self, allocator: std.mem.Allocator, input: update_extension.UpdateExtensionInput, options: update_extension.Options) !update_extension.UpdateExtensionOutput {
        return update_extension.execute(self, allocator, input, options);
    }

    /// Updates an association. For more information about extensions and
    /// associations, see
    /// [Extending
    /// workflows](https://docs.aws.amazon.com/appconfig/latest/userguide/working-with-appconfig-extensions.html) in the *AppConfig User Guide*.
    pub fn updateExtensionAssociation(self: *Self, allocator: std.mem.Allocator, input: update_extension_association.UpdateExtensionAssociationInput, options: update_extension_association.Options) !update_extension_association.UpdateExtensionAssociationOutput {
        return update_extension_association.execute(self, allocator, input, options);
    }

    /// Uses the validators in a configuration profile to validate a configuration.
    pub fn validateConfiguration(self: *Self, allocator: std.mem.Allocator, input: validate_configuration.ValidateConfigurationInput, options: validate_configuration.Options) !validate_configuration.ValidateConfigurationOutput {
        return validate_configuration.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationProfilesPaginator(self: *Self, params: list_configuration_profiles.ListConfigurationProfilesInput) paginator.ListConfigurationProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentStrategiesPaginator(self: *Self, params: list_deployment_strategies.ListDeploymentStrategiesInput) paginator.ListDeploymentStrategiesPaginator {
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

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExtensionAssociationsPaginator(self: *Self, params: list_extension_associations.ListExtensionAssociationsInput) paginator.ListExtensionAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExtensionsPaginator(self: *Self, params: list_extensions.ListExtensionsInput) paginator.ListExtensionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHostedConfigurationVersionsPaginator(self: *Self, params: list_hosted_configuration_versions.ListHostedConfigurationVersionsInput) paginator.ListHostedConfigurationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilDeploymentComplete(self: *Self, params: get_deployment.GetDeploymentInput) aws.waiter.WaiterError!void {
        var w = waiters.DeploymentCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilEnvironmentReadyForDeployment(self: *Self, params: get_environment.GetEnvironmentInput) aws.waiter.WaiterError!void {
        var w = waiters.EnvironmentReadyForDeploymentWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
