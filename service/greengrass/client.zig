const aws = @import("aws");
const std = @import("std");

const associate_role_to_group = @import("associate_role_to_group.zig");
const associate_service_role_to_account = @import("associate_service_role_to_account.zig");
const create_connector_definition = @import("create_connector_definition.zig");
const create_connector_definition_version = @import("create_connector_definition_version.zig");
const create_core_definition = @import("create_core_definition.zig");
const create_core_definition_version = @import("create_core_definition_version.zig");
const create_deployment = @import("create_deployment.zig");
const create_device_definition = @import("create_device_definition.zig");
const create_device_definition_version = @import("create_device_definition_version.zig");
const create_function_definition = @import("create_function_definition.zig");
const create_function_definition_version = @import("create_function_definition_version.zig");
const create_group = @import("create_group.zig");
const create_group_certificate_authority = @import("create_group_certificate_authority.zig");
const create_group_version = @import("create_group_version.zig");
const create_logger_definition = @import("create_logger_definition.zig");
const create_logger_definition_version = @import("create_logger_definition_version.zig");
const create_resource_definition = @import("create_resource_definition.zig");
const create_resource_definition_version = @import("create_resource_definition_version.zig");
const create_software_update_job = @import("create_software_update_job.zig");
const create_subscription_definition = @import("create_subscription_definition.zig");
const create_subscription_definition_version = @import("create_subscription_definition_version.zig");
const delete_connector_definition = @import("delete_connector_definition.zig");
const delete_core_definition = @import("delete_core_definition.zig");
const delete_device_definition = @import("delete_device_definition.zig");
const delete_function_definition = @import("delete_function_definition.zig");
const delete_group = @import("delete_group.zig");
const delete_logger_definition = @import("delete_logger_definition.zig");
const delete_resource_definition = @import("delete_resource_definition.zig");
const delete_subscription_definition = @import("delete_subscription_definition.zig");
const disassociate_role_from_group = @import("disassociate_role_from_group.zig");
const disassociate_service_role_from_account = @import("disassociate_service_role_from_account.zig");
const get_associated_role = @import("get_associated_role.zig");
const get_bulk_deployment_status = @import("get_bulk_deployment_status.zig");
const get_connectivity_info = @import("get_connectivity_info.zig");
const get_connector_definition = @import("get_connector_definition.zig");
const get_connector_definition_version = @import("get_connector_definition_version.zig");
const get_core_definition = @import("get_core_definition.zig");
const get_core_definition_version = @import("get_core_definition_version.zig");
const get_deployment_status = @import("get_deployment_status.zig");
const get_device_definition = @import("get_device_definition.zig");
const get_device_definition_version = @import("get_device_definition_version.zig");
const get_function_definition = @import("get_function_definition.zig");
const get_function_definition_version = @import("get_function_definition_version.zig");
const get_group = @import("get_group.zig");
const get_group_certificate_authority = @import("get_group_certificate_authority.zig");
const get_group_certificate_configuration = @import("get_group_certificate_configuration.zig");
const get_group_version = @import("get_group_version.zig");
const get_logger_definition = @import("get_logger_definition.zig");
const get_logger_definition_version = @import("get_logger_definition_version.zig");
const get_resource_definition = @import("get_resource_definition.zig");
const get_resource_definition_version = @import("get_resource_definition_version.zig");
const get_service_role_for_account = @import("get_service_role_for_account.zig");
const get_subscription_definition = @import("get_subscription_definition.zig");
const get_subscription_definition_version = @import("get_subscription_definition_version.zig");
const get_thing_runtime_configuration = @import("get_thing_runtime_configuration.zig");
const list_bulk_deployment_detailed_reports = @import("list_bulk_deployment_detailed_reports.zig");
const list_bulk_deployments = @import("list_bulk_deployments.zig");
const list_connector_definition_versions = @import("list_connector_definition_versions.zig");
const list_connector_definitions = @import("list_connector_definitions.zig");
const list_core_definition_versions = @import("list_core_definition_versions.zig");
const list_core_definitions = @import("list_core_definitions.zig");
const list_deployments = @import("list_deployments.zig");
const list_device_definition_versions = @import("list_device_definition_versions.zig");
const list_device_definitions = @import("list_device_definitions.zig");
const list_function_definition_versions = @import("list_function_definition_versions.zig");
const list_function_definitions = @import("list_function_definitions.zig");
const list_group_certificate_authorities = @import("list_group_certificate_authorities.zig");
const list_group_versions = @import("list_group_versions.zig");
const list_groups = @import("list_groups.zig");
const list_logger_definition_versions = @import("list_logger_definition_versions.zig");
const list_logger_definitions = @import("list_logger_definitions.zig");
const list_resource_definition_versions = @import("list_resource_definition_versions.zig");
const list_resource_definitions = @import("list_resource_definitions.zig");
const list_subscription_definition_versions = @import("list_subscription_definition_versions.zig");
const list_subscription_definitions = @import("list_subscription_definitions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reset_deployments = @import("reset_deployments.zig");
const start_bulk_deployment = @import("start_bulk_deployment.zig");
const stop_bulk_deployment = @import("stop_bulk_deployment.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connectivity_info = @import("update_connectivity_info.zig");
const update_connector_definition = @import("update_connector_definition.zig");
const update_core_definition = @import("update_core_definition.zig");
const update_device_definition = @import("update_device_definition.zig");
const update_function_definition = @import("update_function_definition.zig");
const update_group = @import("update_group.zig");
const update_group_certificate_configuration = @import("update_group_certificate_configuration.zig");
const update_logger_definition = @import("update_logger_definition.zig");
const update_resource_definition = @import("update_resource_definition.zig");
const update_subscription_definition = @import("update_subscription_definition.zig");
const update_thing_runtime_configuration = @import("update_thing_runtime_configuration.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Greengrass";

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

    /// Associates a role with a group. Your Greengrass core will use the role to
    /// access AWS cloud services. The role's permissions should allow Greengrass
    /// core Lambda functions to perform actions against the cloud.
    pub fn associateRoleToGroup(self: *Self, allocator: std.mem.Allocator, input: associate_role_to_group.AssociateRoleToGroupInput, options: associate_role_to_group.Options) !associate_role_to_group.AssociateRoleToGroupOutput {
        return associate_role_to_group.execute(self, allocator, input, options);
    }

    /// Associates a role with your account. AWS IoT Greengrass will use the role to
    /// access your Lambda functions and AWS IoT resources. This is necessary for
    /// deployments to succeed. The role must have at least minimum permissions in
    /// the policy ''AWSGreengrassResourceAccessRolePolicy''.
    pub fn associateServiceRoleToAccount(self: *Self, allocator: std.mem.Allocator, input: associate_service_role_to_account.AssociateServiceRoleToAccountInput, options: associate_service_role_to_account.Options) !associate_service_role_to_account.AssociateServiceRoleToAccountOutput {
        return associate_service_role_to_account.execute(self, allocator, input, options);
    }

    /// Creates a connector definition. You may provide the initial version of the
    /// connector definition now or use ''CreateConnectorDefinitionVersion'' at a
    /// later time.
    pub fn createConnectorDefinition(self: *Self, allocator: std.mem.Allocator, input: create_connector_definition.CreateConnectorDefinitionInput, options: create_connector_definition.Options) !create_connector_definition.CreateConnectorDefinitionOutput {
        return create_connector_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a connector definition which has already been defined.
    pub fn createConnectorDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_connector_definition_version.CreateConnectorDefinitionVersionInput, options: create_connector_definition_version.Options) !create_connector_definition_version.CreateConnectorDefinitionVersionOutput {
        return create_connector_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a core definition. You may provide the initial version of the core
    /// definition now or use ''CreateCoreDefinitionVersion'' at a later time.
    /// Greengrass groups must each contain exactly one Greengrass core.
    pub fn createCoreDefinition(self: *Self, allocator: std.mem.Allocator, input: create_core_definition.CreateCoreDefinitionInput, options: create_core_definition.Options) !create_core_definition.CreateCoreDefinitionOutput {
        return create_core_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a core definition that has already been defined.
    /// Greengrass groups must each contain exactly one Greengrass core.
    pub fn createCoreDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_core_definition_version.CreateCoreDefinitionVersionInput, options: create_core_definition_version.Options) !create_core_definition_version.CreateCoreDefinitionVersionOutput {
        return create_core_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a deployment. ''CreateDeployment'' requests are idempotent with
    /// respect to the ''X-Amzn-Client-Token'' token and the request parameters.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: create_deployment.Options) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Creates a device definition. You may provide the initial version of the
    /// device definition now or use ''CreateDeviceDefinitionVersion'' at a later
    /// time.
    pub fn createDeviceDefinition(self: *Self, allocator: std.mem.Allocator, input: create_device_definition.CreateDeviceDefinitionInput, options: create_device_definition.Options) !create_device_definition.CreateDeviceDefinitionOutput {
        return create_device_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a device definition that has already been defined.
    pub fn createDeviceDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_device_definition_version.CreateDeviceDefinitionVersionInput, options: create_device_definition_version.Options) !create_device_definition_version.CreateDeviceDefinitionVersionOutput {
        return create_device_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a Lambda function definition which contains a list of Lambda
    /// functions and their configurations to be used in a group. You can create an
    /// initial version of the definition by providing a list of Lambda functions
    /// and their configurations now, or use ''CreateFunctionDefinitionVersion''
    /// later.
    pub fn createFunctionDefinition(self: *Self, allocator: std.mem.Allocator, input: create_function_definition.CreateFunctionDefinitionInput, options: create_function_definition.Options) !create_function_definition.CreateFunctionDefinitionOutput {
        return create_function_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a Lambda function definition that has already been
    /// defined.
    pub fn createFunctionDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_function_definition_version.CreateFunctionDefinitionVersionInput, options: create_function_definition_version.Options) !create_function_definition_version.CreateFunctionDefinitionVersionOutput {
        return create_function_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a group. You may provide the initial version of the group or use
    /// ''CreateGroupVersion'' at a later time. Tip: You can use the
    /// ''gg_group_setup'' package
    /// (https://github.com/awslabs/aws-greengrass-group-setup) as a library or
    /// command-line application to create and deploy Greengrass groups.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates a CA for the group. If a CA already exists, it will rotate the
    /// existing CA.
    pub fn createGroupCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: create_group_certificate_authority.CreateGroupCertificateAuthorityInput, options: create_group_certificate_authority.Options) !create_group_certificate_authority.CreateGroupCertificateAuthorityOutput {
        return create_group_certificate_authority.execute(self, allocator, input, options);
    }

    /// Creates a version of a group which has already been defined.
    pub fn createGroupVersion(self: *Self, allocator: std.mem.Allocator, input: create_group_version.CreateGroupVersionInput, options: create_group_version.Options) !create_group_version.CreateGroupVersionOutput {
        return create_group_version.execute(self, allocator, input, options);
    }

    /// Creates a logger definition. You may provide the initial version of the
    /// logger definition now or use ''CreateLoggerDefinitionVersion'' at a later
    /// time.
    pub fn createLoggerDefinition(self: *Self, allocator: std.mem.Allocator, input: create_logger_definition.CreateLoggerDefinitionInput, options: create_logger_definition.Options) !create_logger_definition.CreateLoggerDefinitionOutput {
        return create_logger_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a logger definition that has already been defined.
    pub fn createLoggerDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_logger_definition_version.CreateLoggerDefinitionVersionInput, options: create_logger_definition_version.Options) !create_logger_definition_version.CreateLoggerDefinitionVersionOutput {
        return create_logger_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a resource definition which contains a list of resources to be used
    /// in a group. You can create an initial version of the definition by providing
    /// a list of resources now, or use ''CreateResourceDefinitionVersion'' later.
    pub fn createResourceDefinition(self: *Self, allocator: std.mem.Allocator, input: create_resource_definition.CreateResourceDefinitionInput, options: create_resource_definition.Options) !create_resource_definition.CreateResourceDefinitionOutput {
        return create_resource_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a resource definition that has already been defined.
    pub fn createResourceDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_resource_definition_version.CreateResourceDefinitionVersionInput, options: create_resource_definition_version.Options) !create_resource_definition_version.CreateResourceDefinitionVersionOutput {
        return create_resource_definition_version.execute(self, allocator, input, options);
    }

    /// Creates a software update for a core or group of cores (specified as an IoT
    /// thing group.) Use this to update the OTA Agent as well as the Greengrass
    /// core software. It makes use of the IoT Jobs feature which provides
    /// additional commands to manage a Greengrass core software update job.
    pub fn createSoftwareUpdateJob(self: *Self, allocator: std.mem.Allocator, input: create_software_update_job.CreateSoftwareUpdateJobInput, options: create_software_update_job.Options) !create_software_update_job.CreateSoftwareUpdateJobOutput {
        return create_software_update_job.execute(self, allocator, input, options);
    }

    /// Creates a subscription definition. You may provide the initial version of
    /// the subscription definition now or use
    /// ''CreateSubscriptionDefinitionVersion'' at a later time.
    pub fn createSubscriptionDefinition(self: *Self, allocator: std.mem.Allocator, input: create_subscription_definition.CreateSubscriptionDefinitionInput, options: create_subscription_definition.Options) !create_subscription_definition.CreateSubscriptionDefinitionOutput {
        return create_subscription_definition.execute(self, allocator, input, options);
    }

    /// Creates a version of a subscription definition which has already been
    /// defined.
    pub fn createSubscriptionDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: create_subscription_definition_version.CreateSubscriptionDefinitionVersionInput, options: create_subscription_definition_version.Options) !create_subscription_definition_version.CreateSubscriptionDefinitionVersionOutput {
        return create_subscription_definition_version.execute(self, allocator, input, options);
    }

    /// Deletes a connector definition.
    pub fn deleteConnectorDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_connector_definition.DeleteConnectorDefinitionInput, options: delete_connector_definition.Options) !delete_connector_definition.DeleteConnectorDefinitionOutput {
        return delete_connector_definition.execute(self, allocator, input, options);
    }

    /// Deletes a core definition.
    pub fn deleteCoreDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_core_definition.DeleteCoreDefinitionInput, options: delete_core_definition.Options) !delete_core_definition.DeleteCoreDefinitionOutput {
        return delete_core_definition.execute(self, allocator, input, options);
    }

    /// Deletes a device definition.
    pub fn deleteDeviceDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_device_definition.DeleteDeviceDefinitionInput, options: delete_device_definition.Options) !delete_device_definition.DeleteDeviceDefinitionOutput {
        return delete_device_definition.execute(self, allocator, input, options);
    }

    /// Deletes a Lambda function definition.
    pub fn deleteFunctionDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_function_definition.DeleteFunctionDefinitionInput, options: delete_function_definition.Options) !delete_function_definition.DeleteFunctionDefinitionOutput {
        return delete_function_definition.execute(self, allocator, input, options);
    }

    /// Deletes a group.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes a logger definition.
    pub fn deleteLoggerDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_logger_definition.DeleteLoggerDefinitionInput, options: delete_logger_definition.Options) !delete_logger_definition.DeleteLoggerDefinitionOutput {
        return delete_logger_definition.execute(self, allocator, input, options);
    }

    /// Deletes a resource definition.
    pub fn deleteResourceDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_resource_definition.DeleteResourceDefinitionInput, options: delete_resource_definition.Options) !delete_resource_definition.DeleteResourceDefinitionOutput {
        return delete_resource_definition.execute(self, allocator, input, options);
    }

    /// Deletes a subscription definition.
    pub fn deleteSubscriptionDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_subscription_definition.DeleteSubscriptionDefinitionInput, options: delete_subscription_definition.Options) !delete_subscription_definition.DeleteSubscriptionDefinitionOutput {
        return delete_subscription_definition.execute(self, allocator, input, options);
    }

    /// Disassociates the role from a group.
    pub fn disassociateRoleFromGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_role_from_group.DisassociateRoleFromGroupInput, options: disassociate_role_from_group.Options) !disassociate_role_from_group.DisassociateRoleFromGroupOutput {
        return disassociate_role_from_group.execute(self, allocator, input, options);
    }

    /// Disassociates the service role from your account. Without a service role,
    /// deployments will not work.
    pub fn disassociateServiceRoleFromAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_service_role_from_account.DisassociateServiceRoleFromAccountInput, options: disassociate_service_role_from_account.Options) !disassociate_service_role_from_account.DisassociateServiceRoleFromAccountOutput {
        return disassociate_service_role_from_account.execute(self, allocator, input, options);
    }

    /// Retrieves the role associated with a particular group.
    pub fn getAssociatedRole(self: *Self, allocator: std.mem.Allocator, input: get_associated_role.GetAssociatedRoleInput, options: get_associated_role.Options) !get_associated_role.GetAssociatedRoleOutput {
        return get_associated_role.execute(self, allocator, input, options);
    }

    /// Returns the status of a bulk deployment.
    pub fn getBulkDeploymentStatus(self: *Self, allocator: std.mem.Allocator, input: get_bulk_deployment_status.GetBulkDeploymentStatusInput, options: get_bulk_deployment_status.Options) !get_bulk_deployment_status.GetBulkDeploymentStatusOutput {
        return get_bulk_deployment_status.execute(self, allocator, input, options);
    }

    /// Retrieves the connectivity information for a core.
    pub fn getConnectivityInfo(self: *Self, allocator: std.mem.Allocator, input: get_connectivity_info.GetConnectivityInfoInput, options: get_connectivity_info.Options) !get_connectivity_info.GetConnectivityInfoOutput {
        return get_connectivity_info.execute(self, allocator, input, options);
    }

    /// Retrieves information about a connector definition.
    pub fn getConnectorDefinition(self: *Self, allocator: std.mem.Allocator, input: get_connector_definition.GetConnectorDefinitionInput, options: get_connector_definition.Options) !get_connector_definition.GetConnectorDefinitionOutput {
        return get_connector_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a connector definition version, including the
    /// connectors that the version contains. Connectors are prebuilt modules that
    /// interact with local infrastructure, device protocols, AWS, and other cloud
    /// services.
    pub fn getConnectorDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_connector_definition_version.GetConnectorDefinitionVersionInput, options: get_connector_definition_version.Options) !get_connector_definition_version.GetConnectorDefinitionVersionOutput {
        return get_connector_definition_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a core definition version.
    pub fn getCoreDefinition(self: *Self, allocator: std.mem.Allocator, input: get_core_definition.GetCoreDefinitionInput, options: get_core_definition.Options) !get_core_definition.GetCoreDefinitionOutput {
        return get_core_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a core definition version.
    pub fn getCoreDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_core_definition_version.GetCoreDefinitionVersionInput, options: get_core_definition_version.Options) !get_core_definition_version.GetCoreDefinitionVersionOutput {
        return get_core_definition_version.execute(self, allocator, input, options);
    }

    /// Returns the status of a deployment.
    pub fn getDeploymentStatus(self: *Self, allocator: std.mem.Allocator, input: get_deployment_status.GetDeploymentStatusInput, options: get_deployment_status.Options) !get_deployment_status.GetDeploymentStatusOutput {
        return get_deployment_status.execute(self, allocator, input, options);
    }

    /// Retrieves information about a device definition.
    pub fn getDeviceDefinition(self: *Self, allocator: std.mem.Allocator, input: get_device_definition.GetDeviceDefinitionInput, options: get_device_definition.Options) !get_device_definition.GetDeviceDefinitionOutput {
        return get_device_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a device definition version.
    pub fn getDeviceDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_device_definition_version.GetDeviceDefinitionVersionInput, options: get_device_definition_version.Options) !get_device_definition_version.GetDeviceDefinitionVersionOutput {
        return get_device_definition_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Lambda function definition, including its
    /// creation time and latest version.
    pub fn getFunctionDefinition(self: *Self, allocator: std.mem.Allocator, input: get_function_definition.GetFunctionDefinitionInput, options: get_function_definition.Options) !get_function_definition.GetFunctionDefinitionOutput {
        return get_function_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Lambda function definition version, including
    /// which Lambda functions are included in the version and their configurations.
    pub fn getFunctionDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_function_definition_version.GetFunctionDefinitionVersionInput, options: get_function_definition_version.Options) !get_function_definition_version.GetFunctionDefinitionVersionOutput {
        return get_function_definition_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a group.
    pub fn getGroup(self: *Self, allocator: std.mem.Allocator, input: get_group.GetGroupInput, options: get_group.Options) !get_group.GetGroupOutput {
        return get_group.execute(self, allocator, input, options);
    }

    /// Retreives the CA associated with a group. Returns the public key of the CA.
    pub fn getGroupCertificateAuthority(self: *Self, allocator: std.mem.Allocator, input: get_group_certificate_authority.GetGroupCertificateAuthorityInput, options: get_group_certificate_authority.Options) !get_group_certificate_authority.GetGroupCertificateAuthorityOutput {
        return get_group_certificate_authority.execute(self, allocator, input, options);
    }

    /// Retrieves the current configuration for the CA used by the group.
    pub fn getGroupCertificateConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_group_certificate_configuration.GetGroupCertificateConfigurationInput, options: get_group_certificate_configuration.Options) !get_group_certificate_configuration.GetGroupCertificateConfigurationOutput {
        return get_group_certificate_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a group version.
    pub fn getGroupVersion(self: *Self, allocator: std.mem.Allocator, input: get_group_version.GetGroupVersionInput, options: get_group_version.Options) !get_group_version.GetGroupVersionOutput {
        return get_group_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a logger definition.
    pub fn getLoggerDefinition(self: *Self, allocator: std.mem.Allocator, input: get_logger_definition.GetLoggerDefinitionInput, options: get_logger_definition.Options) !get_logger_definition.GetLoggerDefinitionOutput {
        return get_logger_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a logger definition version.
    pub fn getLoggerDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_logger_definition_version.GetLoggerDefinitionVersionInput, options: get_logger_definition_version.Options) !get_logger_definition_version.GetLoggerDefinitionVersionOutput {
        return get_logger_definition_version.execute(self, allocator, input, options);
    }

    /// Retrieves information about a resource definition, including its creation
    /// time and latest version.
    pub fn getResourceDefinition(self: *Self, allocator: std.mem.Allocator, input: get_resource_definition.GetResourceDefinitionInput, options: get_resource_definition.Options) !get_resource_definition.GetResourceDefinitionOutput {
        return get_resource_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a resource definition version, including which
    /// resources are included in the version.
    pub fn getResourceDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_resource_definition_version.GetResourceDefinitionVersionInput, options: get_resource_definition_version.Options) !get_resource_definition_version.GetResourceDefinitionVersionOutput {
        return get_resource_definition_version.execute(self, allocator, input, options);
    }

    /// Retrieves the service role that is attached to your account.
    pub fn getServiceRoleForAccount(self: *Self, allocator: std.mem.Allocator, input: get_service_role_for_account.GetServiceRoleForAccountInput, options: get_service_role_for_account.Options) !get_service_role_for_account.GetServiceRoleForAccountOutput {
        return get_service_role_for_account.execute(self, allocator, input, options);
    }

    /// Retrieves information about a subscription definition.
    pub fn getSubscriptionDefinition(self: *Self, allocator: std.mem.Allocator, input: get_subscription_definition.GetSubscriptionDefinitionInput, options: get_subscription_definition.Options) !get_subscription_definition.GetSubscriptionDefinitionOutput {
        return get_subscription_definition.execute(self, allocator, input, options);
    }

    /// Retrieves information about a subscription definition version.
    pub fn getSubscriptionDefinitionVersion(self: *Self, allocator: std.mem.Allocator, input: get_subscription_definition_version.GetSubscriptionDefinitionVersionInput, options: get_subscription_definition_version.Options) !get_subscription_definition_version.GetSubscriptionDefinitionVersionOutput {
        return get_subscription_definition_version.execute(self, allocator, input, options);
    }

    /// Get the runtime configuration of a thing.
    pub fn getThingRuntimeConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_thing_runtime_configuration.GetThingRuntimeConfigurationInput, options: get_thing_runtime_configuration.Options) !get_thing_runtime_configuration.GetThingRuntimeConfigurationOutput {
        return get_thing_runtime_configuration.execute(self, allocator, input, options);
    }

    /// Gets a paginated list of the deployments that have been started in a bulk
    /// deployment operation, and their current deployment status.
    pub fn listBulkDeploymentDetailedReports(self: *Self, allocator: std.mem.Allocator, input: list_bulk_deployment_detailed_reports.ListBulkDeploymentDetailedReportsInput, options: list_bulk_deployment_detailed_reports.Options) !list_bulk_deployment_detailed_reports.ListBulkDeploymentDetailedReportsOutput {
        return list_bulk_deployment_detailed_reports.execute(self, allocator, input, options);
    }

    /// Returns a list of bulk deployments.
    pub fn listBulkDeployments(self: *Self, allocator: std.mem.Allocator, input: list_bulk_deployments.ListBulkDeploymentsInput, options: list_bulk_deployments.Options) !list_bulk_deployments.ListBulkDeploymentsOutput {
        return list_bulk_deployments.execute(self, allocator, input, options);
    }

    /// Lists the versions of a connector definition, which are containers for
    /// connectors. Connectors run on the Greengrass core and contain built-in
    /// integration with local infrastructure, device protocols, AWS, and other
    /// cloud services.
    pub fn listConnectorDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_connector_definition_versions.ListConnectorDefinitionVersionsInput, options: list_connector_definition_versions.Options) !list_connector_definition_versions.ListConnectorDefinitionVersionsOutput {
        return list_connector_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of connector definitions.
    pub fn listConnectorDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_connector_definitions.ListConnectorDefinitionsInput, options: list_connector_definitions.Options) !list_connector_definitions.ListConnectorDefinitionsOutput {
        return list_connector_definitions.execute(self, allocator, input, options);
    }

    /// Lists the versions of a core definition.
    pub fn listCoreDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_core_definition_versions.ListCoreDefinitionVersionsInput, options: list_core_definition_versions.Options) !list_core_definition_versions.ListCoreDefinitionVersionsOutput {
        return list_core_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of core definitions.
    pub fn listCoreDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_core_definitions.ListCoreDefinitionsInput, options: list_core_definitions.Options) !list_core_definitions.ListCoreDefinitionsOutput {
        return list_core_definitions.execute(self, allocator, input, options);
    }

    /// Returns a history of deployments for the group.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: list_deployments.Options) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Lists the versions of a device definition.
    pub fn listDeviceDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_device_definition_versions.ListDeviceDefinitionVersionsInput, options: list_device_definition_versions.Options) !list_device_definition_versions.ListDeviceDefinitionVersionsOutput {
        return list_device_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of device definitions.
    pub fn listDeviceDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_device_definitions.ListDeviceDefinitionsInput, options: list_device_definitions.Options) !list_device_definitions.ListDeviceDefinitionsOutput {
        return list_device_definitions.execute(self, allocator, input, options);
    }

    /// Lists the versions of a Lambda function definition.
    pub fn listFunctionDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_function_definition_versions.ListFunctionDefinitionVersionsInput, options: list_function_definition_versions.Options) !list_function_definition_versions.ListFunctionDefinitionVersionsOutput {
        return list_function_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of Lambda function definitions.
    pub fn listFunctionDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_function_definitions.ListFunctionDefinitionsInput, options: list_function_definitions.Options) !list_function_definitions.ListFunctionDefinitionsOutput {
        return list_function_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves the current CAs for a group.
    pub fn listGroupCertificateAuthorities(self: *Self, allocator: std.mem.Allocator, input: list_group_certificate_authorities.ListGroupCertificateAuthoritiesInput, options: list_group_certificate_authorities.Options) !list_group_certificate_authorities.ListGroupCertificateAuthoritiesOutput {
        return list_group_certificate_authorities.execute(self, allocator, input, options);
    }

    /// Lists the versions of a group.
    pub fn listGroupVersions(self: *Self, allocator: std.mem.Allocator, input: list_group_versions.ListGroupVersionsInput, options: list_group_versions.Options) !list_group_versions.ListGroupVersionsOutput {
        return list_group_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of groups.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Lists the versions of a logger definition.
    pub fn listLoggerDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_logger_definition_versions.ListLoggerDefinitionVersionsInput, options: list_logger_definition_versions.Options) !list_logger_definition_versions.ListLoggerDefinitionVersionsOutput {
        return list_logger_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of logger definitions.
    pub fn listLoggerDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_logger_definitions.ListLoggerDefinitionsInput, options: list_logger_definitions.Options) !list_logger_definitions.ListLoggerDefinitionsOutput {
        return list_logger_definitions.execute(self, allocator, input, options);
    }

    /// Lists the versions of a resource definition.
    pub fn listResourceDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_resource_definition_versions.ListResourceDefinitionVersionsInput, options: list_resource_definition_versions.Options) !list_resource_definition_versions.ListResourceDefinitionVersionsOutput {
        return list_resource_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of resource definitions.
    pub fn listResourceDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_resource_definitions.ListResourceDefinitionsInput, options: list_resource_definitions.Options) !list_resource_definitions.ListResourceDefinitionsOutput {
        return list_resource_definitions.execute(self, allocator, input, options);
    }

    /// Lists the versions of a subscription definition.
    pub fn listSubscriptionDefinitionVersions(self: *Self, allocator: std.mem.Allocator, input: list_subscription_definition_versions.ListSubscriptionDefinitionVersionsInput, options: list_subscription_definition_versions.Options) !list_subscription_definition_versions.ListSubscriptionDefinitionVersionsOutput {
        return list_subscription_definition_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of subscription definitions.
    pub fn listSubscriptionDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_subscription_definitions.ListSubscriptionDefinitionsInput, options: list_subscription_definitions.Options) !list_subscription_definitions.ListSubscriptionDefinitionsOutput {
        return list_subscription_definitions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of resource tags for a resource arn.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Resets a group's deployments.
    pub fn resetDeployments(self: *Self, allocator: std.mem.Allocator, input: reset_deployments.ResetDeploymentsInput, options: reset_deployments.Options) !reset_deployments.ResetDeploymentsOutput {
        return reset_deployments.execute(self, allocator, input, options);
    }

    /// Deploys multiple groups in one operation. This action starts the bulk
    /// deployment of a specified set of group versions. Each group version
    /// deployment will be triggered with an adaptive rate that has a fixed upper
    /// limit. We recommend that you include an ''X-Amzn-Client-Token'' token in
    /// every ''StartBulkDeployment'' request. These requests are idempotent with
    /// respect to the token and the request parameters.
    pub fn startBulkDeployment(self: *Self, allocator: std.mem.Allocator, input: start_bulk_deployment.StartBulkDeploymentInput, options: start_bulk_deployment.Options) !start_bulk_deployment.StartBulkDeploymentOutput {
        return start_bulk_deployment.execute(self, allocator, input, options);
    }

    /// Stops the execution of a bulk deployment. This action returns a status of
    /// ''Stopping'' until the deployment is stopped. You cannot start a new bulk
    /// deployment while a previous deployment is in the ''Stopping'' state. This
    /// action doesn't rollback completed deployments or cancel pending deployments.
    pub fn stopBulkDeployment(self: *Self, allocator: std.mem.Allocator, input: stop_bulk_deployment.StopBulkDeploymentInput, options: stop_bulk_deployment.Options) !stop_bulk_deployment.StopBulkDeploymentOutput {
        return stop_bulk_deployment.execute(self, allocator, input, options);
    }

    /// Adds tags to a Greengrass resource. Valid resources are 'Group',
    /// 'ConnectorDefinition', 'CoreDefinition', 'DeviceDefinition',
    /// 'FunctionDefinition', 'LoggerDefinition', 'SubscriptionDefinition',
    /// 'ResourceDefinition', and 'BulkDeployment'.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove resource tags from a Greengrass Resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the connectivity information for the core. Any devices that belong
    /// to the group which has this core will receive this information in order to
    /// find the location of the core and connect to it.
    pub fn updateConnectivityInfo(self: *Self, allocator: std.mem.Allocator, input: update_connectivity_info.UpdateConnectivityInfoInput, options: update_connectivity_info.Options) !update_connectivity_info.UpdateConnectivityInfoOutput {
        return update_connectivity_info.execute(self, allocator, input, options);
    }

    /// Updates a connector definition.
    pub fn updateConnectorDefinition(self: *Self, allocator: std.mem.Allocator, input: update_connector_definition.UpdateConnectorDefinitionInput, options: update_connector_definition.Options) !update_connector_definition.UpdateConnectorDefinitionOutput {
        return update_connector_definition.execute(self, allocator, input, options);
    }

    /// Updates a core definition.
    pub fn updateCoreDefinition(self: *Self, allocator: std.mem.Allocator, input: update_core_definition.UpdateCoreDefinitionInput, options: update_core_definition.Options) !update_core_definition.UpdateCoreDefinitionOutput {
        return update_core_definition.execute(self, allocator, input, options);
    }

    /// Updates a device definition.
    pub fn updateDeviceDefinition(self: *Self, allocator: std.mem.Allocator, input: update_device_definition.UpdateDeviceDefinitionInput, options: update_device_definition.Options) !update_device_definition.UpdateDeviceDefinitionOutput {
        return update_device_definition.execute(self, allocator, input, options);
    }

    /// Updates a Lambda function definition.
    pub fn updateFunctionDefinition(self: *Self, allocator: std.mem.Allocator, input: update_function_definition.UpdateFunctionDefinitionInput, options: update_function_definition.Options) !update_function_definition.UpdateFunctionDefinitionOutput {
        return update_function_definition.execute(self, allocator, input, options);
    }

    /// Updates a group.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: update_group.Options) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates the Certificate expiry time for a group.
    pub fn updateGroupCertificateConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_group_certificate_configuration.UpdateGroupCertificateConfigurationInput, options: update_group_certificate_configuration.Options) !update_group_certificate_configuration.UpdateGroupCertificateConfigurationOutput {
        return update_group_certificate_configuration.execute(self, allocator, input, options);
    }

    /// Updates a logger definition.
    pub fn updateLoggerDefinition(self: *Self, allocator: std.mem.Allocator, input: update_logger_definition.UpdateLoggerDefinitionInput, options: update_logger_definition.Options) !update_logger_definition.UpdateLoggerDefinitionOutput {
        return update_logger_definition.execute(self, allocator, input, options);
    }

    /// Updates a resource definition.
    pub fn updateResourceDefinition(self: *Self, allocator: std.mem.Allocator, input: update_resource_definition.UpdateResourceDefinitionInput, options: update_resource_definition.Options) !update_resource_definition.UpdateResourceDefinitionOutput {
        return update_resource_definition.execute(self, allocator, input, options);
    }

    /// Updates a subscription definition.
    pub fn updateSubscriptionDefinition(self: *Self, allocator: std.mem.Allocator, input: update_subscription_definition.UpdateSubscriptionDefinitionInput, options: update_subscription_definition.Options) !update_subscription_definition.UpdateSubscriptionDefinitionOutput {
        return update_subscription_definition.execute(self, allocator, input, options);
    }

    /// Updates the runtime configuration of a thing.
    pub fn updateThingRuntimeConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_thing_runtime_configuration.UpdateThingRuntimeConfigurationInput, options: update_thing_runtime_configuration.Options) !update_thing_runtime_configuration.UpdateThingRuntimeConfigurationOutput {
        return update_thing_runtime_configuration.execute(self, allocator, input, options);
    }
};
