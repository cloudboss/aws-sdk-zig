const aws = @import("aws");
const std = @import("std");

const accept_environment_account_connection = @import("accept_environment_account_connection.zig");
const cancel_component_deployment = @import("cancel_component_deployment.zig");
const cancel_environment_deployment = @import("cancel_environment_deployment.zig");
const cancel_service_instance_deployment = @import("cancel_service_instance_deployment.zig");
const cancel_service_pipeline_deployment = @import("cancel_service_pipeline_deployment.zig");
const create_component = @import("create_component.zig");
const create_environment = @import("create_environment.zig");
const create_environment_account_connection = @import("create_environment_account_connection.zig");
const create_environment_template = @import("create_environment_template.zig");
const create_environment_template_version = @import("create_environment_template_version.zig");
const create_repository = @import("create_repository.zig");
const create_service = @import("create_service.zig");
const create_service_instance = @import("create_service_instance.zig");
const create_service_sync_config = @import("create_service_sync_config.zig");
const create_service_template = @import("create_service_template.zig");
const create_service_template_version = @import("create_service_template_version.zig");
const create_template_sync_config = @import("create_template_sync_config.zig");
const delete_component = @import("delete_component.zig");
const delete_deployment = @import("delete_deployment.zig");
const delete_environment = @import("delete_environment.zig");
const delete_environment_account_connection = @import("delete_environment_account_connection.zig");
const delete_environment_template = @import("delete_environment_template.zig");
const delete_environment_template_version = @import("delete_environment_template_version.zig");
const delete_repository = @import("delete_repository.zig");
const delete_service = @import("delete_service.zig");
const delete_service_sync_config = @import("delete_service_sync_config.zig");
const delete_service_template = @import("delete_service_template.zig");
const delete_service_template_version = @import("delete_service_template_version.zig");
const delete_template_sync_config = @import("delete_template_sync_config.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_component = @import("get_component.zig");
const get_deployment = @import("get_deployment.zig");
const get_environment = @import("get_environment.zig");
const get_environment_account_connection = @import("get_environment_account_connection.zig");
const get_environment_template = @import("get_environment_template.zig");
const get_environment_template_version = @import("get_environment_template_version.zig");
const get_repository = @import("get_repository.zig");
const get_repository_sync_status = @import("get_repository_sync_status.zig");
const get_resources_summary = @import("get_resources_summary.zig");
const get_service = @import("get_service.zig");
const get_service_instance = @import("get_service_instance.zig");
const get_service_instance_sync_status = @import("get_service_instance_sync_status.zig");
const get_service_sync_blocker_summary = @import("get_service_sync_blocker_summary.zig");
const get_service_sync_config = @import("get_service_sync_config.zig");
const get_service_template = @import("get_service_template.zig");
const get_service_template_version = @import("get_service_template_version.zig");
const get_template_sync_config = @import("get_template_sync_config.zig");
const get_template_sync_status = @import("get_template_sync_status.zig");
const list_component_outputs = @import("list_component_outputs.zig");
const list_component_provisioned_resources = @import("list_component_provisioned_resources.zig");
const list_components = @import("list_components.zig");
const list_deployments = @import("list_deployments.zig");
const list_environment_account_connections = @import("list_environment_account_connections.zig");
const list_environment_outputs = @import("list_environment_outputs.zig");
const list_environment_provisioned_resources = @import("list_environment_provisioned_resources.zig");
const list_environment_template_versions = @import("list_environment_template_versions.zig");
const list_environment_templates = @import("list_environment_templates.zig");
const list_environments = @import("list_environments.zig");
const list_repositories = @import("list_repositories.zig");
const list_repository_sync_definitions = @import("list_repository_sync_definitions.zig");
const list_service_instance_outputs = @import("list_service_instance_outputs.zig");
const list_service_instance_provisioned_resources = @import("list_service_instance_provisioned_resources.zig");
const list_service_instances = @import("list_service_instances.zig");
const list_service_pipeline_outputs = @import("list_service_pipeline_outputs.zig");
const list_service_pipeline_provisioned_resources = @import("list_service_pipeline_provisioned_resources.zig");
const list_service_template_versions = @import("list_service_template_versions.zig");
const list_service_templates = @import("list_service_templates.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const notify_resource_deployment_status_change = @import("notify_resource_deployment_status_change.zig");
const reject_environment_account_connection = @import("reject_environment_account_connection.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_component = @import("update_component.zig");
const update_environment = @import("update_environment.zig");
const update_environment_account_connection = @import("update_environment_account_connection.zig");
const update_environment_template = @import("update_environment_template.zig");
const update_environment_template_version = @import("update_environment_template_version.zig");
const update_service = @import("update_service.zig");
const update_service_instance = @import("update_service_instance.zig");
const update_service_pipeline = @import("update_service_pipeline.zig");
const update_service_sync_blocker = @import("update_service_sync_blocker.zig");
const update_service_sync_config = @import("update_service_sync_config.zig");
const update_service_template = @import("update_service_template.zig");
const update_service_template_version = @import("update_service_template_version.zig");
const update_template_sync_config = @import("update_template_sync_config.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Proton";

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

    /// In a management account, an environment account connection request is
    /// accepted. When the environment account connection request is accepted,
    /// Proton
    /// can use the associated IAM role to provision environment infrastructure
    /// resources in the associated environment account.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn acceptEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: accept_environment_account_connection.AcceptEnvironmentAccountConnectionInput, options: CallOptions) !accept_environment_account_connection.AcceptEnvironmentAccountConnectionOutput {
        return accept_environment_account_connection.execute(self, allocator, input, options);
    }

    /// Attempts to cancel a component deployment (for a component that is in the
    /// `IN_PROGRESS` deployment status).
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn cancelComponentDeployment(self: *Self, allocator: std.mem.Allocator, input: cancel_component_deployment.CancelComponentDeploymentInput, options: CallOptions) !cancel_component_deployment.CancelComponentDeploymentOutput {
        return cancel_component_deployment.execute(self, allocator, input, options);
    }

    /// Attempts to cancel an environment deployment on an UpdateEnvironment action,
    /// if the deployment is `IN_PROGRESS`. For more
    /// information, see [Update an
    /// environment](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-update.html) in the *Proton
    /// User guide*.
    ///
    /// The following list includes potential cancellation scenarios.
    ///
    /// * If the cancellation attempt succeeds, the resulting deployment state is
    ///   `CANCELLED`.
    ///
    /// * If the cancellation attempt fails, the resulting deployment state is
    ///   `FAILED`.
    ///
    /// * If the current UpdateEnvironment action succeeds before the cancellation
    ///   attempt starts, the resulting deployment state is
    /// `SUCCEEDED` and the cancellation attempt has no effect.
    pub fn cancelEnvironmentDeployment(self: *Self, allocator: std.mem.Allocator, input: cancel_environment_deployment.CancelEnvironmentDeploymentInput, options: CallOptions) !cancel_environment_deployment.CancelEnvironmentDeploymentOutput {
        return cancel_environment_deployment.execute(self, allocator, input, options);
    }

    /// Attempts to cancel a service instance deployment on an UpdateServiceInstance
    /// action, if the deployment is `IN_PROGRESS`. For
    /// more information, see [Update a service
    /// instance](https://docs.aws.amazon.com/proton/latest/userguide/ag-svc-instance-update.html)
    /// in the *Proton User guide*.
    ///
    /// The following list includes potential cancellation scenarios.
    ///
    /// * If the cancellation attempt succeeds, the resulting deployment state is
    /// `CANCELLED`.
    ///
    /// * If the cancellation attempt fails, the resulting deployment state is
    /// `FAILED`.
    ///
    /// * If the current UpdateServiceInstance action succeeds before the
    /// cancellation attempt starts, the resulting deployment state is `SUCCEEDED`
    /// and
    /// the cancellation attempt has no effect.
    pub fn cancelServiceInstanceDeployment(self: *Self, allocator: std.mem.Allocator, input: cancel_service_instance_deployment.CancelServiceInstanceDeploymentInput, options: CallOptions) !cancel_service_instance_deployment.CancelServiceInstanceDeploymentOutput {
        return cancel_service_instance_deployment.execute(self, allocator, input, options);
    }

    /// Attempts to cancel a service pipeline deployment on an UpdateServicePipeline
    /// action, if the deployment is `IN_PROGRESS`. For
    /// more information, see [Update a service
    /// pipeline](https://docs.aws.amazon.com/proton/latest/userguide/ag-svc-pipeline-update.html)
    /// in the *Proton User guide*.
    ///
    /// The following list includes potential cancellation scenarios.
    ///
    /// * If the cancellation attempt succeeds, the resulting deployment state is
    /// `CANCELLED`.
    ///
    /// * If the cancellation attempt fails, the resulting deployment state is
    /// `FAILED`.
    ///
    /// * If the current UpdateServicePipeline action succeeds before the
    /// cancellation attempt starts, the resulting deployment state is `SUCCEEDED`
    /// and
    /// the cancellation attempt has no effect.
    pub fn cancelServicePipelineDeployment(self: *Self, allocator: std.mem.Allocator, input: cancel_service_pipeline_deployment.CancelServicePipelineDeploymentInput, options: CallOptions) !cancel_service_pipeline_deployment.CancelServicePipelineDeploymentOutput {
        return cancel_service_pipeline_deployment.execute(self, allocator, input, options);
    }

    /// Create an Proton component. A component is an infrastructure extension for a
    /// service instance.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn createComponent(self: *Self, allocator: std.mem.Allocator, input: create_component.CreateComponentInput, options: CallOptions) !create_component.CreateComponentOutput {
        return create_component.execute(self, allocator, input, options);
    }

    /// Deploy a new environment. An Proton environment is created from an
    /// environment template that defines infrastructure and resources that can be
    /// shared across services.
    ///
    /// **You can provision environments using the following methods:**
    ///
    /// * Amazon Web Services-managed provisioning: Proton makes direct calls to
    ///   provision your resources.
    ///
    /// * Self-managed provisioning: Proton makes pull requests on your repository
    ///   to provide compiled infrastructure as code (IaC) files that your IaC
    /// engine uses to provision resources.
    ///
    /// For more information, see
    /// [Environments](https://docs.aws.amazon.com/proton/latest/userguide/ag-environments.html) and [Provisioning methods](https://docs.aws.amazon.com/proton/latest/userguide/ag-works-prov-methods.html) in the *Proton User
    /// Guide*.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: CallOptions) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Create an environment account connection in an environment account so that
    /// environment infrastructure resources can be provisioned in the environment
    /// account from a management account.
    ///
    /// An environment account connection is a secure bi-directional connection
    /// between a *management account* and an *environment
    /// account* that maintains authorization and permissions. For more information,
    /// see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User
    /// guide*.
    pub fn createEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: create_environment_account_connection.CreateEnvironmentAccountConnectionInput, options: CallOptions) !create_environment_account_connection.CreateEnvironmentAccountConnectionOutput {
        return create_environment_account_connection.execute(self, allocator, input, options);
    }

    /// Create an environment template for Proton. For more information, see
    /// [Environment
    /// Templates](https://docs.aws.amazon.com/proton/latest/userguide/ag-templates.html) in the *Proton User Guide*.
    ///
    /// You can create an environment template in one of the two following ways:
    ///
    /// * Register and publish a *standard* environment template that instructs
    ///   Proton to deploy and manage environment
    /// infrastructure.
    ///
    /// * Register and publish a *customer managed* environment template that
    ///   connects Proton to your existing provisioned
    /// infrastructure that you manage. Proton *doesn't* manage your existing
    /// provisioned infrastructure. To create an environment
    /// template for customer provisioned and managed infrastructure, include the
    /// `provisioning` parameter and set the value to
    /// `CUSTOMER_MANAGED`. For more information, see [Register
    /// and publish an environment
    /// template](https://docs.aws.amazon.com/proton/latest/userguide/template-create.html) in the *Proton User Guide*.
    pub fn createEnvironmentTemplate(self: *Self, allocator: std.mem.Allocator, input: create_environment_template.CreateEnvironmentTemplateInput, options: CallOptions) !create_environment_template.CreateEnvironmentTemplateOutput {
        return create_environment_template.execute(self, allocator, input, options);
    }

    /// Create a new major or minor version of an environment template. A major
    /// version of an environment template is a version that
    /// *isn't* backwards compatible. A minor version of an environment template is
    /// a version that's backwards compatible within its major
    /// version.
    pub fn createEnvironmentTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: create_environment_template_version.CreateEnvironmentTemplateVersionInput, options: CallOptions) !create_environment_template_version.CreateEnvironmentTemplateVersionOutput {
        return create_environment_template_version.execute(self, allocator, input, options);
    }

    /// Create and register a link to a repository. Proton uses the link to
    /// repeatedly access the repository, to either push to it (self-managed
    /// provisioning) or pull from it (template sync). You can share a linked
    /// repository across multiple resources (like environments using self-managed
    /// provisioning, or synced templates). When you create a repository link,
    /// Proton creates a [service-linked
    /// role](https://docs.aws.amazon.com/proton/latest/userguide/using-service-linked-roles.html) for you.
    ///
    /// For more information, see [Self-managed
    /// provisioning](https://docs.aws.amazon.com/proton/latest/userguide/ag-works-prov-methods.html#ag-works-prov-methods-self), [Template bundles](https://docs.aws.amazon.com/proton/latest/userguide/ag-template-authoring.html#ag-template-bundles), and
    /// [Template sync
    /// configurations](https://docs.aws.amazon.com/proton/latest/userguide/ag-template-sync-configs.html) in the *Proton
    /// User Guide*.
    pub fn createRepository(self: *Self, allocator: std.mem.Allocator, input: create_repository.CreateRepositoryInput, options: CallOptions) !create_repository.CreateRepositoryOutput {
        return create_repository.execute(self, allocator, input, options);
    }

    /// Create an Proton service. An Proton service is an instantiation of a service
    /// template and often includes several service instances and pipeline. For more
    /// information, see
    /// [Services](https://docs.aws.amazon.com/proton/latest/userguide/ag-services.html)
    /// in the *Proton User Guide*.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: CallOptions) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Create a service instance.
    pub fn createServiceInstance(self: *Self, allocator: std.mem.Allocator, input: create_service_instance.CreateServiceInstanceInput, options: CallOptions) !create_service_instance.CreateServiceInstanceOutput {
        return create_service_instance.execute(self, allocator, input, options);
    }

    /// Create the Proton Ops configuration file.
    pub fn createServiceSyncConfig(self: *Self, allocator: std.mem.Allocator, input: create_service_sync_config.CreateServiceSyncConfigInput, options: CallOptions) !create_service_sync_config.CreateServiceSyncConfigOutput {
        return create_service_sync_config.execute(self, allocator, input, options);
    }

    /// Create a service template. The administrator creates a service template to
    /// define
    /// standardized infrastructure and an optional CI/CD service pipeline.
    /// Developers, in turn,
    /// select the service template from Proton. If the selected service template
    /// includes a
    /// service pipeline definition, they provide a link to their source code
    /// repository. Proton
    /// then deploys and manages the infrastructure defined by the selected service
    /// template. For more
    /// information, see [Proton
    /// templates](https://docs.aws.amazon.com/proton/latest/userguide/ag-templates.html) in the *Proton User Guide*.
    pub fn createServiceTemplate(self: *Self, allocator: std.mem.Allocator, input: create_service_template.CreateServiceTemplateInput, options: CallOptions) !create_service_template.CreateServiceTemplateOutput {
        return create_service_template.execute(self, allocator, input, options);
    }

    /// Create a new major or minor version of a service template. A major version
    /// of a service
    /// template is a version that *isn't* backward compatible. A minor version of
    /// a service template is a version that's backward compatible within its major
    /// version.
    pub fn createServiceTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: create_service_template_version.CreateServiceTemplateVersionInput, options: CallOptions) !create_service_template_version.CreateServiceTemplateVersionOutput {
        return create_service_template_version.execute(self, allocator, input, options);
    }

    /// Set up a template to create new template versions automatically by tracking
    /// a linked repository. A linked repository is a repository that has
    /// been registered with Proton. For more information, see CreateRepository.
    ///
    /// When a commit is pushed to your linked repository, Proton checks for changes
    /// to your repository template bundles. If it detects a template
    /// bundle change, a new major or minor version of its template is created, if
    /// the version doesn’t already exist. For more information, see [Template sync
    /// configurations](https://docs.aws.amazon.com/proton/latest/userguide/ag-template-sync-configs.html) in the *Proton
    /// User Guide*.
    pub fn createTemplateSyncConfig(self: *Self, allocator: std.mem.Allocator, input: create_template_sync_config.CreateTemplateSyncConfigInput, options: CallOptions) !create_template_sync_config.CreateTemplateSyncConfigOutput {
        return create_template_sync_config.execute(self, allocator, input, options);
    }

    /// Delete an Proton component resource.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: CallOptions) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Delete the deployment.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: CallOptions) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Delete an environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: CallOptions) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// In an environment account, delete an environment account connection.
    ///
    /// After you delete an environment account connection that’s in use by an
    /// Proton environment, Proton *can’t* manage the
    /// environment infrastructure resources until a new environment account
    /// connection is accepted for the environment account and associated
    /// environment. You're
    /// responsible for cleaning up provisioned resources that remain without an
    /// environment connection.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn deleteEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: delete_environment_account_connection.DeleteEnvironmentAccountConnectionInput, options: CallOptions) !delete_environment_account_connection.DeleteEnvironmentAccountConnectionOutput {
        return delete_environment_account_connection.execute(self, allocator, input, options);
    }

    /// If no other major or minor versions of an environment template exist, delete
    /// the environment template.
    pub fn deleteEnvironmentTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_environment_template.DeleteEnvironmentTemplateInput, options: CallOptions) !delete_environment_template.DeleteEnvironmentTemplateOutput {
        return delete_environment_template.execute(self, allocator, input, options);
    }

    /// If no other minor versions of an environment template exist, delete a major
    /// version of the environment template if it's not the
    /// `Recommended` version. Delete the `Recommended` version of the environment
    /// template if no other major versions or minor versions
    /// of the environment template exist. A major version of an environment
    /// template is a version that's not backward compatible.
    ///
    /// Delete a minor version of an environment template if it *isn't* the
    /// `Recommended` version. Delete a
    /// `Recommended` minor version of the environment template if no other minor
    /// versions of the environment template exist. A minor version of an
    /// environment template is a version that's backward compatible.
    pub fn deleteEnvironmentTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: delete_environment_template_version.DeleteEnvironmentTemplateVersionInput, options: CallOptions) !delete_environment_template_version.DeleteEnvironmentTemplateVersionOutput {
        return delete_environment_template_version.execute(self, allocator, input, options);
    }

    /// De-register and unlink your repository.
    pub fn deleteRepository(self: *Self, allocator: std.mem.Allocator, input: delete_repository.DeleteRepositoryInput, options: CallOptions) !delete_repository.DeleteRepositoryOutput {
        return delete_repository.execute(self, allocator, input, options);
    }

    /// Delete a service, with its instances and pipeline.
    ///
    /// You can't delete a service if it has any service instances that have
    /// components attached
    /// to them.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: CallOptions) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Delete the Proton Ops file.
    pub fn deleteServiceSyncConfig(self: *Self, allocator: std.mem.Allocator, input: delete_service_sync_config.DeleteServiceSyncConfigInput, options: CallOptions) !delete_service_sync_config.DeleteServiceSyncConfigOutput {
        return delete_service_sync_config.execute(self, allocator, input, options);
    }

    /// If no other major or minor versions of the service template exist, delete
    /// the service
    /// template.
    pub fn deleteServiceTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_service_template.DeleteServiceTemplateInput, options: CallOptions) !delete_service_template.DeleteServiceTemplateOutput {
        return delete_service_template.execute(self, allocator, input, options);
    }

    /// If no other minor versions of a service template exist, delete a major
    /// version of the
    /// service template if it's not the `Recommended` version. Delete the
    /// `Recommended` version of the service template if no other major versions or
    /// minor
    /// versions of the service template exist. A major version of a service
    /// template is a version
    /// that *isn't* backwards compatible.
    ///
    /// Delete a minor version of a service template if it's not the `Recommended`
    /// version. Delete a `Recommended` minor version of the service template if no
    /// other
    /// minor versions of the service template exist. A minor version of a service
    /// template is a
    /// version that's backwards compatible.
    pub fn deleteServiceTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: delete_service_template_version.DeleteServiceTemplateVersionInput, options: CallOptions) !delete_service_template_version.DeleteServiceTemplateVersionOutput {
        return delete_service_template_version.execute(self, allocator, input, options);
    }

    /// Delete a template sync configuration.
    pub fn deleteTemplateSyncConfig(self: *Self, allocator: std.mem.Allocator, input: delete_template_sync_config.DeleteTemplateSyncConfigInput, options: CallOptions) !delete_template_sync_config.DeleteTemplateSyncConfigOutput {
        return delete_template_sync_config.execute(self, allocator, input, options);
    }

    /// Get detail data for Proton account-wide settings.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: CallOptions) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Get detailed data for a component.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: CallOptions) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Get detailed data for a deployment.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: CallOptions) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Get detailed data for an environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: CallOptions) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// In an environment account, get the detailed data for an environment account
    /// connection.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn getEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: get_environment_account_connection.GetEnvironmentAccountConnectionInput, options: CallOptions) !get_environment_account_connection.GetEnvironmentAccountConnectionOutput {
        return get_environment_account_connection.execute(self, allocator, input, options);
    }

    /// Get detailed data for an environment template.
    pub fn getEnvironmentTemplate(self: *Self, allocator: std.mem.Allocator, input: get_environment_template.GetEnvironmentTemplateInput, options: CallOptions) !get_environment_template.GetEnvironmentTemplateOutput {
        return get_environment_template.execute(self, allocator, input, options);
    }

    /// Get detailed data for a major or minor version of an environment template.
    pub fn getEnvironmentTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: get_environment_template_version.GetEnvironmentTemplateVersionInput, options: CallOptions) !get_environment_template_version.GetEnvironmentTemplateVersionOutput {
        return get_environment_template_version.execute(self, allocator, input, options);
    }

    /// Get detail data for a linked repository.
    pub fn getRepository(self: *Self, allocator: std.mem.Allocator, input: get_repository.GetRepositoryInput, options: CallOptions) !get_repository.GetRepositoryOutput {
        return get_repository.execute(self, allocator, input, options);
    }

    /// Get the sync status of a repository used for Proton template sync. For more
    /// information about template sync, see .
    ///
    /// A repository sync status isn't tied to the Proton Repository resource (or
    /// any other Proton resource). Therefore, tags on an Proton Repository resource
    /// have no effect on this action. Specifically, you can't use these tags to
    /// control access to this action using Attribute-based access control
    /// (ABAC).
    ///
    /// For more information about ABAC, see
    /// [ABAC](https://docs.aws.amazon.com/proton/latest/userguide/security_iam_service-with-iam.html#security_iam_service-with-iam-tags) in the *Proton User
    /// Guide*.
    pub fn getRepositorySyncStatus(self: *Self, allocator: std.mem.Allocator, input: get_repository_sync_status.GetRepositorySyncStatusInput, options: CallOptions) !get_repository_sync_status.GetRepositorySyncStatusOutput {
        return get_repository_sync_status.execute(self, allocator, input, options);
    }

    /// Get counts of Proton resources.
    ///
    /// For infrastructure-provisioning resources (environments, services, service
    /// instances, pipelines), the action returns staleness counts. A
    /// resource is stale when it's behind the recommended version of the Proton
    /// template that it uses and it needs an update to become current.
    ///
    /// The action returns staleness counts (counts of resources that are
    /// up-to-date, behind a template major version, or behind a template minor
    /// version), the total number of resources, and the number of resources that
    /// are in a failed state, grouped by resource type. Components,
    /// environments, and service templates return less information - see the
    /// `components`, `environments`, and
    /// `serviceTemplates` field descriptions.
    ///
    /// For context, the action also returns the total number of each type of Proton
    /// template in the Amazon Web Services account.
    ///
    /// For more information, see [Proton
    /// dashboard](https://docs.aws.amazon.com/proton/latest/userguide/monitoring-dashboard.html) in the
    /// *Proton User Guide*.
    pub fn getResourcesSummary(self: *Self, allocator: std.mem.Allocator, input: get_resources_summary.GetResourcesSummaryInput, options: CallOptions) !get_resources_summary.GetResourcesSummaryOutput {
        return get_resources_summary.execute(self, allocator, input, options);
    }

    /// Get detailed data for a service.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: CallOptions) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Get detailed data for a service instance. A service instance is an
    /// instantiation of
    /// service template and it runs in a specific environment.
    pub fn getServiceInstance(self: *Self, allocator: std.mem.Allocator, input: get_service_instance.GetServiceInstanceInput, options: CallOptions) !get_service_instance.GetServiceInstanceOutput {
        return get_service_instance.execute(self, allocator, input, options);
    }

    /// Get the status of the synced service instance.
    pub fn getServiceInstanceSyncStatus(self: *Self, allocator: std.mem.Allocator, input: get_service_instance_sync_status.GetServiceInstanceSyncStatusInput, options: CallOptions) !get_service_instance_sync_status.GetServiceInstanceSyncStatusOutput {
        return get_service_instance_sync_status.execute(self, allocator, input, options);
    }

    /// Get detailed data for the service sync blocker summary.
    pub fn getServiceSyncBlockerSummary(self: *Self, allocator: std.mem.Allocator, input: get_service_sync_blocker_summary.GetServiceSyncBlockerSummaryInput, options: CallOptions) !get_service_sync_blocker_summary.GetServiceSyncBlockerSummaryOutput {
        return get_service_sync_blocker_summary.execute(self, allocator, input, options);
    }

    /// Get detailed information for the service sync configuration.
    pub fn getServiceSyncConfig(self: *Self, allocator: std.mem.Allocator, input: get_service_sync_config.GetServiceSyncConfigInput, options: CallOptions) !get_service_sync_config.GetServiceSyncConfigOutput {
        return get_service_sync_config.execute(self, allocator, input, options);
    }

    /// Get detailed data for a service template.
    pub fn getServiceTemplate(self: *Self, allocator: std.mem.Allocator, input: get_service_template.GetServiceTemplateInput, options: CallOptions) !get_service_template.GetServiceTemplateOutput {
        return get_service_template.execute(self, allocator, input, options);
    }

    /// Get detailed data for a major or minor version of a service template.
    pub fn getServiceTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: get_service_template_version.GetServiceTemplateVersionInput, options: CallOptions) !get_service_template_version.GetServiceTemplateVersionOutput {
        return get_service_template_version.execute(self, allocator, input, options);
    }

    /// Get detail data for a template sync configuration.
    pub fn getTemplateSyncConfig(self: *Self, allocator: std.mem.Allocator, input: get_template_sync_config.GetTemplateSyncConfigInput, options: CallOptions) !get_template_sync_config.GetTemplateSyncConfigOutput {
        return get_template_sync_config.execute(self, allocator, input, options);
    }

    /// Get the status of a template sync.
    pub fn getTemplateSyncStatus(self: *Self, allocator: std.mem.Allocator, input: get_template_sync_status.GetTemplateSyncStatusInput, options: CallOptions) !get_template_sync_status.GetTemplateSyncStatusOutput {
        return get_template_sync_status.execute(self, allocator, input, options);
    }

    /// Get a list of component Infrastructure as Code (IaC) outputs.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn listComponentOutputs(self: *Self, allocator: std.mem.Allocator, input: list_component_outputs.ListComponentOutputsInput, options: CallOptions) !list_component_outputs.ListComponentOutputsOutput {
        return list_component_outputs.execute(self, allocator, input, options);
    }

    /// List provisioned resources for a component with details.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn listComponentProvisionedResources(self: *Self, allocator: std.mem.Allocator, input: list_component_provisioned_resources.ListComponentProvisionedResourcesInput, options: CallOptions) !list_component_provisioned_resources.ListComponentProvisionedResourcesOutput {
        return list_component_provisioned_resources.execute(self, allocator, input, options);
    }

    /// List components with summary data. You can filter the result list by
    /// environment, service, or a single service instance.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: CallOptions) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// List deployments. You can filter the result list by environment, service, or
    /// a single service instance.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: CallOptions) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// View a list of environment account connections.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn listEnvironmentAccountConnections(self: *Self, allocator: std.mem.Allocator, input: list_environment_account_connections.ListEnvironmentAccountConnectionsInput, options: CallOptions) !list_environment_account_connections.ListEnvironmentAccountConnectionsOutput {
        return list_environment_account_connections.execute(self, allocator, input, options);
    }

    /// List the infrastructure as code outputs for your environment.
    pub fn listEnvironmentOutputs(self: *Self, allocator: std.mem.Allocator, input: list_environment_outputs.ListEnvironmentOutputsInput, options: CallOptions) !list_environment_outputs.ListEnvironmentOutputsOutput {
        return list_environment_outputs.execute(self, allocator, input, options);
    }

    /// List the provisioned resources for your environment.
    pub fn listEnvironmentProvisionedResources(self: *Self, allocator: std.mem.Allocator, input: list_environment_provisioned_resources.ListEnvironmentProvisionedResourcesInput, options: CallOptions) !list_environment_provisioned_resources.ListEnvironmentProvisionedResourcesOutput {
        return list_environment_provisioned_resources.execute(self, allocator, input, options);
    }

    /// List major or minor versions of an environment template with detail data.
    pub fn listEnvironmentTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_environment_template_versions.ListEnvironmentTemplateVersionsInput, options: CallOptions) !list_environment_template_versions.ListEnvironmentTemplateVersionsOutput {
        return list_environment_template_versions.execute(self, allocator, input, options);
    }

    /// List environment templates.
    pub fn listEnvironmentTemplates(self: *Self, allocator: std.mem.Allocator, input: list_environment_templates.ListEnvironmentTemplatesInput, options: CallOptions) !list_environment_templates.ListEnvironmentTemplatesOutput {
        return list_environment_templates.execute(self, allocator, input, options);
    }

    /// List environments with detail data summaries.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: CallOptions) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// List linked repositories with detail data.
    pub fn listRepositories(self: *Self, allocator: std.mem.Allocator, input: list_repositories.ListRepositoriesInput, options: CallOptions) !list_repositories.ListRepositoriesOutput {
        return list_repositories.execute(self, allocator, input, options);
    }

    /// List repository sync definitions with detail data.
    pub fn listRepositorySyncDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_repository_sync_definitions.ListRepositorySyncDefinitionsInput, options: CallOptions) !list_repository_sync_definitions.ListRepositorySyncDefinitionsOutput {
        return list_repository_sync_definitions.execute(self, allocator, input, options);
    }

    /// Get a list service of instance Infrastructure as Code (IaC) outputs.
    pub fn listServiceInstanceOutputs(self: *Self, allocator: std.mem.Allocator, input: list_service_instance_outputs.ListServiceInstanceOutputsInput, options: CallOptions) !list_service_instance_outputs.ListServiceInstanceOutputsOutput {
        return list_service_instance_outputs.execute(self, allocator, input, options);
    }

    /// List provisioned resources for a service instance with details.
    pub fn listServiceInstanceProvisionedResources(self: *Self, allocator: std.mem.Allocator, input: list_service_instance_provisioned_resources.ListServiceInstanceProvisionedResourcesInput, options: CallOptions) !list_service_instance_provisioned_resources.ListServiceInstanceProvisionedResourcesOutput {
        return list_service_instance_provisioned_resources.execute(self, allocator, input, options);
    }

    /// List service instances with summary data. This action lists service
    /// instances of all
    /// services in the Amazon Web Services account.
    pub fn listServiceInstances(self: *Self, allocator: std.mem.Allocator, input: list_service_instances.ListServiceInstancesInput, options: CallOptions) !list_service_instances.ListServiceInstancesOutput {
        return list_service_instances.execute(self, allocator, input, options);
    }

    /// Get a list of service pipeline Infrastructure as Code (IaC) outputs.
    pub fn listServicePipelineOutputs(self: *Self, allocator: std.mem.Allocator, input: list_service_pipeline_outputs.ListServicePipelineOutputsInput, options: CallOptions) !list_service_pipeline_outputs.ListServicePipelineOutputsOutput {
        return list_service_pipeline_outputs.execute(self, allocator, input, options);
    }

    /// List provisioned resources for a service and pipeline with details.
    pub fn listServicePipelineProvisionedResources(self: *Self, allocator: std.mem.Allocator, input: list_service_pipeline_provisioned_resources.ListServicePipelineProvisionedResourcesInput, options: CallOptions) !list_service_pipeline_provisioned_resources.ListServicePipelineProvisionedResourcesOutput {
        return list_service_pipeline_provisioned_resources.execute(self, allocator, input, options);
    }

    /// List major or minor versions of a service template with detail data.
    pub fn listServiceTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: list_service_template_versions.ListServiceTemplateVersionsInput, options: CallOptions) !list_service_template_versions.ListServiceTemplateVersionsOutput {
        return list_service_template_versions.execute(self, allocator, input, options);
    }

    /// List service templates with detail data.
    pub fn listServiceTemplates(self: *Self, allocator: std.mem.Allocator, input: list_service_templates.ListServiceTemplatesInput, options: CallOptions) !list_service_templates.ListServiceTemplatesOutput {
        return list_service_templates.execute(self, allocator, input, options);
    }

    /// List services with summaries of detail data.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// List tags for a resource. For more information, see [Proton
    /// resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the *Proton User Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Notify Proton of status changes to a provisioned resource when you use
    /// self-managed provisioning.
    ///
    /// For more information, see [Self-managed
    /// provisioning](https://docs.aws.amazon.com/proton/latest/userguide/ag-works-prov-methods.html#ag-works-prov-methods-self) in the *Proton User Guide*.
    pub fn notifyResourceDeploymentStatusChange(self: *Self, allocator: std.mem.Allocator, input: notify_resource_deployment_status_change.NotifyResourceDeploymentStatusChangeInput, options: CallOptions) !notify_resource_deployment_status_change.NotifyResourceDeploymentStatusChangeOutput {
        return notify_resource_deployment_status_change.execute(self, allocator, input, options);
    }

    /// In a management account, reject an environment account connection from
    /// another environment account.
    ///
    /// After you reject an environment account connection request, you *can't*
    /// accept or use the rejected environment account
    /// connection.
    ///
    /// You *can’t* reject an environment account connection that's connected to an
    /// environment.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn rejectEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: reject_environment_account_connection.RejectEnvironmentAccountConnectionInput, options: CallOptions) !reject_environment_account_connection.RejectEnvironmentAccountConnectionOutput {
        return reject_environment_account_connection.execute(self, allocator, input, options);
    }

    /// Tag a resource. A tag is a key-value pair of metadata that you associate
    /// with an Proton resource.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in
    /// the *Proton User Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove a customer tag from a resource. A tag is a key-value pair of metadata
    /// associated with an Proton resource.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in
    /// the *Proton User Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update Proton settings that are used for multiple services in the Amazon Web
    /// Services account.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: CallOptions) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Update a component.
    ///
    /// There are a few modes for updating a component. The `deploymentType` field
    /// defines the mode.
    ///
    /// You can't update a component while its deployment status, or the deployment
    /// status of a service instance attached to it, is
    /// `IN_PROGRESS`.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn updateComponent(self: *Self, allocator: std.mem.Allocator, input: update_component.UpdateComponentInput, options: CallOptions) !update_component.UpdateComponentOutput {
        return update_component.execute(self, allocator, input, options);
    }

    /// Update an environment.
    ///
    /// If the environment is associated with an environment account connection,
    /// *don't* update or include the
    /// `protonServiceRoleArn` and `provisioningRepository` parameter to update or
    /// connect to an environment account connection.
    ///
    /// You can only update to a new environment account connection if that
    /// connection was created in the same environment account that the current
    /// environment account connection was created in. The account connection must
    /// also be associated with the current environment.
    ///
    /// If the environment *isn't* associated with an environment account
    /// connection, *don't* update or include the
    /// `environmentAccountConnectionId` parameter. You *can't* update or connect
    /// the environment to an environment account
    /// connection if it *isn't* already associated with an environment connection.
    ///
    /// You can update either the `environmentAccountConnectionId` or
    /// `protonServiceRoleArn` parameter and value. You can’t update
    /// both.
    ///
    /// If the environment was configured for Amazon Web Services-managed
    /// provisioning, omit the `provisioningRepository` parameter.
    ///
    /// If the environment was configured for self-managed provisioning, specify the
    /// `provisioningRepository` parameter and omit the
    /// `protonServiceRoleArn` and `environmentAccountConnectionId` parameters.
    ///
    /// For more information, see
    /// [Environments](https://docs.aws.amazon.com/proton/latest/userguide/ag-environments.html) and [Provisioning methods](https://docs.aws.amazon.com/proton/latest/userguide/ag-works-prov-methods.html) in the *Proton User
    /// Guide*.
    ///
    /// There are four modes for updating an environment. The `deploymentType` field
    /// defines the mode.
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested metadata
    /// parameters are updated.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the new spec that
    /// you provide. Only requested parameters are updated.
    /// *Don’t* include minor or major version parameters when you use this
    /// `deployment-type`.
    ///
    /// `MINOR_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the published,
    /// recommended (latest) minor version of the current major version in
    /// use, by default. You can also specify a different minor version of the
    /// current major version in use.
    ///
    /// `MAJOR_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the published,
    /// recommended (latest) major and minor version of the current template,
    /// by default. You can also specify a different major version that's higher
    /// than the major version in use and a minor version.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: CallOptions) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// In an environment account, update an environment account connection to use a
    /// new IAM role.
    ///
    /// For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    pub fn updateEnvironmentAccountConnection(self: *Self, allocator: std.mem.Allocator, input: update_environment_account_connection.UpdateEnvironmentAccountConnectionInput, options: CallOptions) !update_environment_account_connection.UpdateEnvironmentAccountConnectionOutput {
        return update_environment_account_connection.execute(self, allocator, input, options);
    }

    /// Update an environment template.
    pub fn updateEnvironmentTemplate(self: *Self, allocator: std.mem.Allocator, input: update_environment_template.UpdateEnvironmentTemplateInput, options: CallOptions) !update_environment_template.UpdateEnvironmentTemplateOutput {
        return update_environment_template.execute(self, allocator, input, options);
    }

    /// Update a major or minor version of an environment template.
    pub fn updateEnvironmentTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: update_environment_template_version.UpdateEnvironmentTemplateVersionInput, options: CallOptions) !update_environment_template_version.UpdateEnvironmentTemplateVersionOutput {
        return update_environment_template_version.execute(self, allocator, input, options);
    }

    /// Edit a service description or use a spec to add and delete service
    /// instances.
    ///
    /// Existing service instances and the service pipeline *can't* be edited
    /// using this API. They can only be deleted.
    ///
    /// Use the `description` parameter to modify the description.
    ///
    /// Edit the `spec` parameter to add or delete instances.
    ///
    /// You can't delete a service instance (remove it from the spec) if it has an
    /// attached
    /// component.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: CallOptions) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Update a service instance.
    ///
    /// There are a few modes for updating a service instance. The `deploymentType`
    /// field defines the mode.
    ///
    /// You can't update a service instance while its deployment status, or the
    /// deployment
    /// status of a component attached to it, is `IN_PROGRESS`.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    pub fn updateServiceInstance(self: *Self, allocator: std.mem.Allocator, input: update_service_instance.UpdateServiceInstanceInput, options: CallOptions) !update_service_instance.UpdateServiceInstanceOutput {
        return update_service_instance.execute(self, allocator, input, options);
    }

    /// Update the service pipeline.
    ///
    /// There are four modes for updating a service pipeline. The `deploymentType`
    /// field defines the mode.
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested
    /// metadata parameters are updated.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the service pipeline is deployed and updated with the new spec
    /// that
    /// you provide. Only requested parameters are updated. *Don’t* include
    /// major or minor version parameters when you use this `deployment-type`.
    ///
    /// `MINOR_VERSION`
    ///
    /// In this mode, the service pipeline is deployed and updated with the
    /// published,
    /// recommended (latest) minor version of the current major version in use, by
    /// default. You
    /// can specify a different minor version of the current major version in use.
    ///
    /// `MAJOR_VERSION`
    ///
    /// In this mode, the service pipeline is deployed and updated with the
    /// published,
    /// recommended (latest) major and minor version of the current template by
    /// default. You can
    /// specify a different major version that's higher than the major version in
    /// use and a
    /// minor version.
    pub fn updateServicePipeline(self: *Self, allocator: std.mem.Allocator, input: update_service_pipeline.UpdateServicePipelineInput, options: CallOptions) !update_service_pipeline.UpdateServicePipelineOutput {
        return update_service_pipeline.execute(self, allocator, input, options);
    }

    /// Update the service sync blocker by resolving it.
    pub fn updateServiceSyncBlocker(self: *Self, allocator: std.mem.Allocator, input: update_service_sync_blocker.UpdateServiceSyncBlockerInput, options: CallOptions) !update_service_sync_blocker.UpdateServiceSyncBlockerOutput {
        return update_service_sync_blocker.execute(self, allocator, input, options);
    }

    /// Update the Proton Ops config file.
    pub fn updateServiceSyncConfig(self: *Self, allocator: std.mem.Allocator, input: update_service_sync_config.UpdateServiceSyncConfigInput, options: CallOptions) !update_service_sync_config.UpdateServiceSyncConfigOutput {
        return update_service_sync_config.execute(self, allocator, input, options);
    }

    /// Update a service template.
    pub fn updateServiceTemplate(self: *Self, allocator: std.mem.Allocator, input: update_service_template.UpdateServiceTemplateInput, options: CallOptions) !update_service_template.UpdateServiceTemplateOutput {
        return update_service_template.execute(self, allocator, input, options);
    }

    /// Update a major or minor version of a service template.
    pub fn updateServiceTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: update_service_template_version.UpdateServiceTemplateVersionInput, options: CallOptions) !update_service_template_version.UpdateServiceTemplateVersionOutput {
        return update_service_template_version.execute(self, allocator, input, options);
    }

    /// Update template sync configuration parameters, except for the `templateName`
    /// and `templateType`. Repository details
    /// (branch, name, and provider) should be of a linked repository. A linked
    /// repository is a repository that has been registered with Proton. For
    /// more information, see CreateRepository.
    pub fn updateTemplateSyncConfig(self: *Self, allocator: std.mem.Allocator, input: update_template_sync_config.UpdateTemplateSyncConfigInput, options: CallOptions) !update_template_sync_config.UpdateTemplateSyncConfigOutput {
        return update_template_sync_config.execute(self, allocator, input, options);
    }

    pub fn listComponentOutputsPaginator(self: *Self, params: list_component_outputs.ListComponentOutputsInput) paginator.ListComponentOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentProvisionedResourcesPaginator(self: *Self, params: list_component_provisioned_resources.ListComponentProvisionedResourcesInput) paginator.ListComponentProvisionedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
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

    pub fn listEnvironmentAccountConnectionsPaginator(self: *Self, params: list_environment_account_connections.ListEnvironmentAccountConnectionsInput) paginator.ListEnvironmentAccountConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentOutputsPaginator(self: *Self, params: list_environment_outputs.ListEnvironmentOutputsInput) paginator.ListEnvironmentOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentProvisionedResourcesPaginator(self: *Self, params: list_environment_provisioned_resources.ListEnvironmentProvisionedResourcesInput) paginator.ListEnvironmentProvisionedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentTemplateVersionsPaginator(self: *Self, params: list_environment_template_versions.ListEnvironmentTemplateVersionsInput) paginator.ListEnvironmentTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentTemplatesPaginator(self: *Self, params: list_environment_templates.ListEnvironmentTemplatesInput) paginator.ListEnvironmentTemplatesPaginator {
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

    pub fn listRepositoriesPaginator(self: *Self, params: list_repositories.ListRepositoriesInput) paginator.ListRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRepositorySyncDefinitionsPaginator(self: *Self, params: list_repository_sync_definitions.ListRepositorySyncDefinitionsInput) paginator.ListRepositorySyncDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceInstanceOutputsPaginator(self: *Self, params: list_service_instance_outputs.ListServiceInstanceOutputsInput) paginator.ListServiceInstanceOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceInstanceProvisionedResourcesPaginator(self: *Self, params: list_service_instance_provisioned_resources.ListServiceInstanceProvisionedResourcesInput) paginator.ListServiceInstanceProvisionedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceInstancesPaginator(self: *Self, params: list_service_instances.ListServiceInstancesInput) paginator.ListServiceInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicePipelineOutputsPaginator(self: *Self, params: list_service_pipeline_outputs.ListServicePipelineOutputsInput) paginator.ListServicePipelineOutputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicePipelineProvisionedResourcesPaginator(self: *Self, params: list_service_pipeline_provisioned_resources.ListServicePipelineProvisionedResourcesInput) paginator.ListServicePipelineProvisionedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceTemplateVersionsPaginator(self: *Self, params: list_service_template_versions.ListServiceTemplateVersionsInput) paginator.ListServiceTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceTemplatesPaginator(self: *Self, params: list_service_templates.ListServiceTemplatesInput) paginator.ListServiceTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilComponentDeleted(self: *Self, params: get_component.GetComponentInput) aws.waiter.WaiterError!void {
        var w = waiters.ComponentDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilComponentDeployed(self: *Self, params: get_component.GetComponentInput) aws.waiter.WaiterError!void {
        var w = waiters.ComponentDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilEnvironmentDeployed(self: *Self, params: get_environment.GetEnvironmentInput) aws.waiter.WaiterError!void {
        var w = waiters.EnvironmentDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilEnvironmentTemplateVersionRegistered(self: *Self, params: get_environment_template_version.GetEnvironmentTemplateVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.EnvironmentTemplateVersionRegisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceCreated(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceDeleted(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceInstanceDeployed(self: *Self, params: get_service_instance.GetServiceInstanceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceInstanceDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServicePipelineDeployed(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServicePipelineDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceTemplateVersionRegistered(self: *Self, params: get_service_template_version.GetServiceTemplateVersionInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceTemplateVersionRegisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceUpdated(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceUpdatedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
