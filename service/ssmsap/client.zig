const aws = @import("aws");
const std = @import("std");

const delete_resource_permission = @import("delete_resource_permission.zig");
const deregister_application = @import("deregister_application.zig");
const get_application = @import("get_application.zig");
const get_component = @import("get_component.zig");
const get_configuration_check_operation = @import("get_configuration_check_operation.zig");
const get_database = @import("get_database.zig");
const get_operation = @import("get_operation.zig");
const get_resource_permission = @import("get_resource_permission.zig");
const list_applications = @import("list_applications.zig");
const list_components = @import("list_components.zig");
const list_configuration_check_definitions = @import("list_configuration_check_definitions.zig");
const list_configuration_check_operations = @import("list_configuration_check_operations.zig");
const list_databases = @import("list_databases.zig");
const list_operation_events = @import("list_operation_events.zig");
const list_operations = @import("list_operations.zig");
const list_sub_check_results = @import("list_sub_check_results.zig");
const list_sub_check_rule_results = @import("list_sub_check_rule_results.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_permission = @import("put_resource_permission.zig");
const register_application = @import("register_application.zig");
const start_application = @import("start_application.zig");
const start_application_refresh = @import("start_application_refresh.zig");
const start_configuration_checks = @import("start_configuration_checks.zig");
const stop_application = @import("stop_application.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application_settings = @import("update_application_settings.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Ssm Sap";

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

    /// Removes permissions associated with the target database.
    pub fn deleteResourcePermission(self: *Self, allocator: std.mem.Allocator, input: delete_resource_permission.DeleteResourcePermissionInput, options: CallOptions) !delete_resource_permission.DeleteResourcePermissionOutput {
        return delete_resource_permission.execute(self, allocator, input, options);
    }

    /// Deregister an SAP application with AWS Systems Manager for SAP. This action
    /// does not aﬀect the existing setup of your SAP workloads on Amazon EC2.
    pub fn deregisterApplication(self: *Self, allocator: std.mem.Allocator, input: deregister_application.DeregisterApplicationInput, options: CallOptions) !deregister_application.DeregisterApplicationOutput {
        return deregister_application.execute(self, allocator, input, options);
    }

    /// Gets an application registered with AWS Systems Manager for SAP. It also
    /// returns the components of the application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Gets the component of an application registered with AWS Systems Manager for
    /// SAP.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: CallOptions) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Gets the details of a configuration check operation by specifying the
    /// operation ID.
    pub fn getConfigurationCheckOperation(self: *Self, allocator: std.mem.Allocator, input: get_configuration_check_operation.GetConfigurationCheckOperationInput, options: CallOptions) !get_configuration_check_operation.GetConfigurationCheckOperationOutput {
        return get_configuration_check_operation.execute(self, allocator, input, options);
    }

    /// Gets the SAP HANA database of an application registered with AWS Systems
    /// Manager for SAP.
    pub fn getDatabase(self: *Self, allocator: std.mem.Allocator, input: get_database.GetDatabaseInput, options: CallOptions) !get_database.GetDatabaseOutput {
        return get_database.execute(self, allocator, input, options);
    }

    /// Gets the details of an operation by specifying the operation ID.
    pub fn getOperation(self: *Self, allocator: std.mem.Allocator, input: get_operation.GetOperationInput, options: CallOptions) !get_operation.GetOperationOutput {
        return get_operation.execute(self, allocator, input, options);
    }

    /// Gets permissions associated with the target database.
    pub fn getResourcePermission(self: *Self, allocator: std.mem.Allocator, input: get_resource_permission.GetResourcePermissionInput, options: CallOptions) !get_resource_permission.GetResourcePermissionOutput {
        return get_resource_permission.execute(self, allocator, input, options);
    }

    /// Lists all the applications registered with AWS Systems Manager for SAP.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all the components registered with AWS Systems Manager for SAP.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: CallOptions) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Lists all configuration check types supported by AWS Systems Manager for
    /// SAP.
    pub fn listConfigurationCheckDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_configuration_check_definitions.ListConfigurationCheckDefinitionsInput, options: CallOptions) !list_configuration_check_definitions.ListConfigurationCheckDefinitionsOutput {
        return list_configuration_check_definitions.execute(self, allocator, input, options);
    }

    /// Lists the configuration check operations performed by AWS Systems Manager
    /// for SAP.
    pub fn listConfigurationCheckOperations(self: *Self, allocator: std.mem.Allocator, input: list_configuration_check_operations.ListConfigurationCheckOperationsInput, options: CallOptions) !list_configuration_check_operations.ListConfigurationCheckOperationsOutput {
        return list_configuration_check_operations.execute(self, allocator, input, options);
    }

    /// Lists the SAP HANA databases of an application registered with AWS Systems
    /// Manager for SAP.
    pub fn listDatabases(self: *Self, allocator: std.mem.Allocator, input: list_databases.ListDatabasesInput, options: CallOptions) !list_databases.ListDatabasesOutput {
        return list_databases.execute(self, allocator, input, options);
    }

    /// Returns a list of operations events.
    ///
    /// Available parameters include `OperationID`, as well as optional parameters
    /// `MaxResults`, `NextToken`, and `Filters`.
    pub fn listOperationEvents(self: *Self, allocator: std.mem.Allocator, input: list_operation_events.ListOperationEventsInput, options: CallOptions) !list_operation_events.ListOperationEventsOutput {
        return list_operation_events.execute(self, allocator, input, options);
    }

    /// Lists the operations performed by AWS Systems Manager for SAP.
    pub fn listOperations(self: *Self, allocator: std.mem.Allocator, input: list_operations.ListOperationsInput, options: CallOptions) !list_operations.ListOperationsOutput {
        return list_operations.execute(self, allocator, input, options);
    }

    /// Lists the sub-check results of a specified configuration check operation.
    pub fn listSubCheckResults(self: *Self, allocator: std.mem.Allocator, input: list_sub_check_results.ListSubCheckResultsInput, options: CallOptions) !list_sub_check_results.ListSubCheckResultsOutput {
        return list_sub_check_results.execute(self, allocator, input, options);
    }

    /// Lists the rules of a specified sub-check belonging to a configuration check
    /// operation.
    pub fn listSubCheckRuleResults(self: *Self, allocator: std.mem.Allocator, input: list_sub_check_rule_results.ListSubCheckRuleResultsInput, options: CallOptions) !list_sub_check_rule_results.ListSubCheckRuleResultsOutput {
        return list_sub_check_rule_results.execute(self, allocator, input, options);
    }

    /// Lists all tags on an SAP HANA application and/or database registered with
    /// AWS Systems Manager for SAP.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds permissions to the target database.
    pub fn putResourcePermission(self: *Self, allocator: std.mem.Allocator, input: put_resource_permission.PutResourcePermissionInput, options: CallOptions) !put_resource_permission.PutResourcePermissionOutput {
        return put_resource_permission.execute(self, allocator, input, options);
    }

    /// Register an SAP application with AWS Systems Manager for SAP. You must meet
    /// the following requirements before registering.
    ///
    /// The SAP application you want to register with AWS Systems Manager for SAP is
    /// running on Amazon EC2.
    ///
    /// AWS Systems Manager Agent must be setup on an Amazon EC2 instance along with
    /// the required IAM permissions.
    ///
    /// Amazon EC2 instance(s) must have access to the secrets created in AWS
    /// Secrets Manager to manage SAP applications and components.
    pub fn registerApplication(self: *Self, allocator: std.mem.Allocator, input: register_application.RegisterApplicationInput, options: CallOptions) !register_application.RegisterApplicationOutput {
        return register_application.execute(self, allocator, input, options);
    }

    /// Request is an operation which starts an application.
    ///
    /// Parameter `ApplicationId` is required.
    pub fn startApplication(self: *Self, allocator: std.mem.Allocator, input: start_application.StartApplicationInput, options: CallOptions) !start_application.StartApplicationOutput {
        return start_application.execute(self, allocator, input, options);
    }

    /// Refreshes a registered application.
    pub fn startApplicationRefresh(self: *Self, allocator: std.mem.Allocator, input: start_application_refresh.StartApplicationRefreshInput, options: CallOptions) !start_application_refresh.StartApplicationRefreshOutput {
        return start_application_refresh.execute(self, allocator, input, options);
    }

    /// Initiates configuration check operations against a specified application.
    pub fn startConfigurationChecks(self: *Self, allocator: std.mem.Allocator, input: start_configuration_checks.StartConfigurationChecksInput, options: CallOptions) !start_configuration_checks.StartConfigurationChecksOutput {
        return start_configuration_checks.execute(self, allocator, input, options);
    }

    /// Request is an operation to stop an application.
    ///
    /// Parameter `ApplicationId` is required. Parameters `StopConnectedEntity` and
    /// `IncludeEc2InstanceShutdown` are optional.
    pub fn stopApplication(self: *Self, allocator: std.mem.Allocator, input: stop_application.StopApplicationInput, options: CallOptions) !stop_application.StopApplicationOutput {
        return stop_application.execute(self, allocator, input, options);
    }

    /// Creates tag for a resource by specifying the ARN.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Delete the tags for a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the settings of an application registered with AWS Systems Manager
    /// for SAP.
    pub fn updateApplicationSettings(self: *Self, allocator: std.mem.Allocator, input: update_application_settings.UpdateApplicationSettingsInput, options: CallOptions) !update_application_settings.UpdateApplicationSettingsOutput {
        return update_application_settings.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfigurationCheckDefinitionsPaginator(self: *Self, params: list_configuration_check_definitions.ListConfigurationCheckDefinitionsInput) paginator.ListConfigurationCheckDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfigurationCheckOperationsPaginator(self: *Self, params: list_configuration_check_operations.ListConfigurationCheckOperationsInput) paginator.ListConfigurationCheckOperationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatabasesPaginator(self: *Self, params: list_databases.ListDatabasesInput) paginator.ListDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOperationEventsPaginator(self: *Self, params: list_operation_events.ListOperationEventsInput) paginator.ListOperationEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOperationsPaginator(self: *Self, params: list_operations.ListOperationsInput) paginator.ListOperationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubCheckResultsPaginator(self: *Self, params: list_sub_check_results.ListSubCheckResultsInput) paginator.ListSubCheckResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubCheckRuleResultsPaginator(self: *Self, params: list_sub_check_rule_results.ListSubCheckRuleResultsInput) paginator.ListSubCheckRuleResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
