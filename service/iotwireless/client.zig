const aws = @import("aws");
const std = @import("std");

const associate_aws_account_with_partner_account = @import("associate_aws_account_with_partner_account.zig");
const associate_multicast_group_with_fuota_task = @import("associate_multicast_group_with_fuota_task.zig");
const associate_wireless_device_with_fuota_task = @import("associate_wireless_device_with_fuota_task.zig");
const associate_wireless_device_with_multicast_group = @import("associate_wireless_device_with_multicast_group.zig");
const associate_wireless_device_with_thing = @import("associate_wireless_device_with_thing.zig");
const associate_wireless_gateway_with_certificate = @import("associate_wireless_gateway_with_certificate.zig");
const associate_wireless_gateway_with_thing = @import("associate_wireless_gateway_with_thing.zig");
const cancel_multicast_group_session = @import("cancel_multicast_group_session.zig");
const create_destination = @import("create_destination.zig");
const create_device_profile = @import("create_device_profile.zig");
const create_fuota_task = @import("create_fuota_task.zig");
const create_multicast_group = @import("create_multicast_group.zig");
const create_network_analyzer_configuration = @import("create_network_analyzer_configuration.zig");
const create_service_profile = @import("create_service_profile.zig");
const create_wireless_device = @import("create_wireless_device.zig");
const create_wireless_gateway = @import("create_wireless_gateway.zig");
const create_wireless_gateway_task = @import("create_wireless_gateway_task.zig");
const create_wireless_gateway_task_definition = @import("create_wireless_gateway_task_definition.zig");
const delete_destination = @import("delete_destination.zig");
const delete_device_profile = @import("delete_device_profile.zig");
const delete_fuota_task = @import("delete_fuota_task.zig");
const delete_multicast_group = @import("delete_multicast_group.zig");
const delete_network_analyzer_configuration = @import("delete_network_analyzer_configuration.zig");
const delete_queued_messages = @import("delete_queued_messages.zig");
const delete_service_profile = @import("delete_service_profile.zig");
const delete_wireless_device = @import("delete_wireless_device.zig");
const delete_wireless_device_import_task = @import("delete_wireless_device_import_task.zig");
const delete_wireless_gateway = @import("delete_wireless_gateway.zig");
const delete_wireless_gateway_task = @import("delete_wireless_gateway_task.zig");
const delete_wireless_gateway_task_definition = @import("delete_wireless_gateway_task_definition.zig");
const deregister_wireless_device = @import("deregister_wireless_device.zig");
const disassociate_aws_account_from_partner_account = @import("disassociate_aws_account_from_partner_account.zig");
const disassociate_multicast_group_from_fuota_task = @import("disassociate_multicast_group_from_fuota_task.zig");
const disassociate_wireless_device_from_fuota_task = @import("disassociate_wireless_device_from_fuota_task.zig");
const disassociate_wireless_device_from_multicast_group = @import("disassociate_wireless_device_from_multicast_group.zig");
const disassociate_wireless_device_from_thing = @import("disassociate_wireless_device_from_thing.zig");
const disassociate_wireless_gateway_from_certificate = @import("disassociate_wireless_gateway_from_certificate.zig");
const disassociate_wireless_gateway_from_thing = @import("disassociate_wireless_gateway_from_thing.zig");
const get_destination = @import("get_destination.zig");
const get_device_profile = @import("get_device_profile.zig");
const get_event_configuration_by_resource_types = @import("get_event_configuration_by_resource_types.zig");
const get_fuota_task = @import("get_fuota_task.zig");
const get_log_levels_by_resource_types = @import("get_log_levels_by_resource_types.zig");
const get_metric_configuration = @import("get_metric_configuration.zig");
const get_metrics = @import("get_metrics.zig");
const get_multicast_group = @import("get_multicast_group.zig");
const get_multicast_group_session = @import("get_multicast_group_session.zig");
const get_network_analyzer_configuration = @import("get_network_analyzer_configuration.zig");
const get_partner_account = @import("get_partner_account.zig");
const get_position = @import("get_position.zig");
const get_position_configuration = @import("get_position_configuration.zig");
const get_position_estimate = @import("get_position_estimate.zig");
const get_resource_event_configuration = @import("get_resource_event_configuration.zig");
const get_resource_log_level = @import("get_resource_log_level.zig");
const get_resource_position = @import("get_resource_position.zig");
const get_service_endpoint = @import("get_service_endpoint.zig");
const get_service_profile = @import("get_service_profile.zig");
const get_wireless_device = @import("get_wireless_device.zig");
const get_wireless_device_import_task = @import("get_wireless_device_import_task.zig");
const get_wireless_device_statistics = @import("get_wireless_device_statistics.zig");
const get_wireless_gateway = @import("get_wireless_gateway.zig");
const get_wireless_gateway_certificate = @import("get_wireless_gateway_certificate.zig");
const get_wireless_gateway_firmware_information = @import("get_wireless_gateway_firmware_information.zig");
const get_wireless_gateway_statistics = @import("get_wireless_gateway_statistics.zig");
const get_wireless_gateway_task = @import("get_wireless_gateway_task.zig");
const get_wireless_gateway_task_definition = @import("get_wireless_gateway_task_definition.zig");
const list_destinations = @import("list_destinations.zig");
const list_device_profiles = @import("list_device_profiles.zig");
const list_devices_for_wireless_device_import_task = @import("list_devices_for_wireless_device_import_task.zig");
const list_event_configurations = @import("list_event_configurations.zig");
const list_fuota_tasks = @import("list_fuota_tasks.zig");
const list_multicast_groups = @import("list_multicast_groups.zig");
const list_multicast_groups_by_fuota_task = @import("list_multicast_groups_by_fuota_task.zig");
const list_network_analyzer_configurations = @import("list_network_analyzer_configurations.zig");
const list_partner_accounts = @import("list_partner_accounts.zig");
const list_position_configurations = @import("list_position_configurations.zig");
const list_queued_messages = @import("list_queued_messages.zig");
const list_service_profiles = @import("list_service_profiles.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_wireless_device_import_tasks = @import("list_wireless_device_import_tasks.zig");
const list_wireless_devices = @import("list_wireless_devices.zig");
const list_wireless_gateway_task_definitions = @import("list_wireless_gateway_task_definitions.zig");
const list_wireless_gateways = @import("list_wireless_gateways.zig");
const put_position_configuration = @import("put_position_configuration.zig");
const put_resource_log_level = @import("put_resource_log_level.zig");
const reset_all_resource_log_levels = @import("reset_all_resource_log_levels.zig");
const reset_resource_log_level = @import("reset_resource_log_level.zig");
const send_data_to_multicast_group = @import("send_data_to_multicast_group.zig");
const send_data_to_wireless_device = @import("send_data_to_wireless_device.zig");
const start_bulk_associate_wireless_device_with_multicast_group = @import("start_bulk_associate_wireless_device_with_multicast_group.zig");
const start_bulk_disassociate_wireless_device_from_multicast_group = @import("start_bulk_disassociate_wireless_device_from_multicast_group.zig");
const start_fuota_task = @import("start_fuota_task.zig");
const start_multicast_group_session = @import("start_multicast_group_session.zig");
const start_single_wireless_device_import_task = @import("start_single_wireless_device_import_task.zig");
const start_wireless_device_import_task = @import("start_wireless_device_import_task.zig");
const tag_resource = @import("tag_resource.zig");
const test_wireless_device = @import("test_wireless_device.zig");
const untag_resource = @import("untag_resource.zig");
const update_destination = @import("update_destination.zig");
const update_event_configuration_by_resource_types = @import("update_event_configuration_by_resource_types.zig");
const update_fuota_task = @import("update_fuota_task.zig");
const update_log_levels_by_resource_types = @import("update_log_levels_by_resource_types.zig");
const update_metric_configuration = @import("update_metric_configuration.zig");
const update_multicast_group = @import("update_multicast_group.zig");
const update_network_analyzer_configuration = @import("update_network_analyzer_configuration.zig");
const update_partner_account = @import("update_partner_account.zig");
const update_position = @import("update_position.zig");
const update_resource_event_configuration = @import("update_resource_event_configuration.zig");
const update_resource_position = @import("update_resource_position.zig");
const update_wireless_device = @import("update_wireless_device.zig");
const update_wireless_device_import_task = @import("update_wireless_device_import_task.zig");
const update_wireless_gateway = @import("update_wireless_gateway.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Wireless";

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

    /// Associates a partner account with your AWS account.
    pub fn associateAwsAccountWithPartnerAccount(self: *Self, allocator: std.mem.Allocator, input: associate_aws_account_with_partner_account.AssociateAwsAccountWithPartnerAccountInput, options: associate_aws_account_with_partner_account.Options) !associate_aws_account_with_partner_account.AssociateAwsAccountWithPartnerAccountOutput {
        return associate_aws_account_with_partner_account.execute(self, allocator, input, options);
    }

    /// Associate a multicast group with a FUOTA task.
    pub fn associateMulticastGroupWithFuotaTask(self: *Self, allocator: std.mem.Allocator, input: associate_multicast_group_with_fuota_task.AssociateMulticastGroupWithFuotaTaskInput, options: associate_multicast_group_with_fuota_task.Options) !associate_multicast_group_with_fuota_task.AssociateMulticastGroupWithFuotaTaskOutput {
        return associate_multicast_group_with_fuota_task.execute(self, allocator, input, options);
    }

    /// Associate a wireless device with a FUOTA task.
    pub fn associateWirelessDeviceWithFuotaTask(self: *Self, allocator: std.mem.Allocator, input: associate_wireless_device_with_fuota_task.AssociateWirelessDeviceWithFuotaTaskInput, options: associate_wireless_device_with_fuota_task.Options) !associate_wireless_device_with_fuota_task.AssociateWirelessDeviceWithFuotaTaskOutput {
        return associate_wireless_device_with_fuota_task.execute(self, allocator, input, options);
    }

    /// Associates a wireless device with a multicast group.
    pub fn associateWirelessDeviceWithMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: associate_wireless_device_with_multicast_group.AssociateWirelessDeviceWithMulticastGroupInput, options: associate_wireless_device_with_multicast_group.Options) !associate_wireless_device_with_multicast_group.AssociateWirelessDeviceWithMulticastGroupOutput {
        return associate_wireless_device_with_multicast_group.execute(self, allocator, input, options);
    }

    /// Associates a wireless device with a thing.
    pub fn associateWirelessDeviceWithThing(self: *Self, allocator: std.mem.Allocator, input: associate_wireless_device_with_thing.AssociateWirelessDeviceWithThingInput, options: associate_wireless_device_with_thing.Options) !associate_wireless_device_with_thing.AssociateWirelessDeviceWithThingOutput {
        return associate_wireless_device_with_thing.execute(self, allocator, input, options);
    }

    /// Associates a wireless gateway with a certificate.
    pub fn associateWirelessGatewayWithCertificate(self: *Self, allocator: std.mem.Allocator, input: associate_wireless_gateway_with_certificate.AssociateWirelessGatewayWithCertificateInput, options: associate_wireless_gateway_with_certificate.Options) !associate_wireless_gateway_with_certificate.AssociateWirelessGatewayWithCertificateOutput {
        return associate_wireless_gateway_with_certificate.execute(self, allocator, input, options);
    }

    /// Associates a wireless gateway with a thing.
    pub fn associateWirelessGatewayWithThing(self: *Self, allocator: std.mem.Allocator, input: associate_wireless_gateway_with_thing.AssociateWirelessGatewayWithThingInput, options: associate_wireless_gateway_with_thing.Options) !associate_wireless_gateway_with_thing.AssociateWirelessGatewayWithThingOutput {
        return associate_wireless_gateway_with_thing.execute(self, allocator, input, options);
    }

    /// Cancels an existing multicast group session.
    pub fn cancelMulticastGroupSession(self: *Self, allocator: std.mem.Allocator, input: cancel_multicast_group_session.CancelMulticastGroupSessionInput, options: cancel_multicast_group_session.Options) !cancel_multicast_group_session.CancelMulticastGroupSessionOutput {
        return cancel_multicast_group_session.execute(self, allocator, input, options);
    }

    /// Creates a new destination that maps a device message to an AWS IoT rule.
    pub fn createDestination(self: *Self, allocator: std.mem.Allocator, input: create_destination.CreateDestinationInput, options: create_destination.Options) !create_destination.CreateDestinationOutput {
        return create_destination.execute(self, allocator, input, options);
    }

    /// Creates a new device profile.
    pub fn createDeviceProfile(self: *Self, allocator: std.mem.Allocator, input: create_device_profile.CreateDeviceProfileInput, options: create_device_profile.Options) !create_device_profile.CreateDeviceProfileOutput {
        return create_device_profile.execute(self, allocator, input, options);
    }

    /// Creates a FUOTA task.
    pub fn createFuotaTask(self: *Self, allocator: std.mem.Allocator, input: create_fuota_task.CreateFuotaTaskInput, options: create_fuota_task.Options) !create_fuota_task.CreateFuotaTaskOutput {
        return create_fuota_task.execute(self, allocator, input, options);
    }

    /// Creates a multicast group.
    pub fn createMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: create_multicast_group.CreateMulticastGroupInput, options: create_multicast_group.Options) !create_multicast_group.CreateMulticastGroupOutput {
        return create_multicast_group.execute(self, allocator, input, options);
    }

    /// Creates a new network analyzer configuration.
    pub fn createNetworkAnalyzerConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_network_analyzer_configuration.CreateNetworkAnalyzerConfigurationInput, options: create_network_analyzer_configuration.Options) !create_network_analyzer_configuration.CreateNetworkAnalyzerConfigurationOutput {
        return create_network_analyzer_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new service profile.
    pub fn createServiceProfile(self: *Self, allocator: std.mem.Allocator, input: create_service_profile.CreateServiceProfileInput, options: create_service_profile.Options) !create_service_profile.CreateServiceProfileOutput {
        return create_service_profile.execute(self, allocator, input, options);
    }

    /// Provisions a wireless device.
    pub fn createWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: create_wireless_device.CreateWirelessDeviceInput, options: create_wireless_device.Options) !create_wireless_device.CreateWirelessDeviceOutput {
        return create_wireless_device.execute(self, allocator, input, options);
    }

    /// Provisions a wireless gateway.
    ///
    /// When provisioning a wireless gateway, you might run into duplication errors
    /// for
    /// the following reasons.
    ///
    /// * If you specify a `GatewayEui` value that already exists.
    ///
    /// * If you used a `ClientRequestToken` with the same parameters
    /// within the last 10 minutes.
    ///
    /// To avoid this error, make sure that you use unique identifiers and
    /// parameters for
    /// each request within the specified time period.
    pub fn createWirelessGateway(self: *Self, allocator: std.mem.Allocator, input: create_wireless_gateway.CreateWirelessGatewayInput, options: create_wireless_gateway.Options) !create_wireless_gateway.CreateWirelessGatewayOutput {
        return create_wireless_gateway.execute(self, allocator, input, options);
    }

    /// Creates a task for a wireless gateway.
    pub fn createWirelessGatewayTask(self: *Self, allocator: std.mem.Allocator, input: create_wireless_gateway_task.CreateWirelessGatewayTaskInput, options: create_wireless_gateway_task.Options) !create_wireless_gateway_task.CreateWirelessGatewayTaskOutput {
        return create_wireless_gateway_task.execute(self, allocator, input, options);
    }

    /// Creates a gateway task definition.
    pub fn createWirelessGatewayTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: create_wireless_gateway_task_definition.CreateWirelessGatewayTaskDefinitionInput, options: create_wireless_gateway_task_definition.Options) !create_wireless_gateway_task_definition.CreateWirelessGatewayTaskDefinitionOutput {
        return create_wireless_gateway_task_definition.execute(self, allocator, input, options);
    }

    /// Deletes a destination.
    pub fn deleteDestination(self: *Self, allocator: std.mem.Allocator, input: delete_destination.DeleteDestinationInput, options: delete_destination.Options) !delete_destination.DeleteDestinationOutput {
        return delete_destination.execute(self, allocator, input, options);
    }

    /// Deletes a device profile.
    pub fn deleteDeviceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_device_profile.DeleteDeviceProfileInput, options: delete_device_profile.Options) !delete_device_profile.DeleteDeviceProfileOutput {
        return delete_device_profile.execute(self, allocator, input, options);
    }

    /// Deletes a FUOTA task.
    pub fn deleteFuotaTask(self: *Self, allocator: std.mem.Allocator, input: delete_fuota_task.DeleteFuotaTaskInput, options: delete_fuota_task.Options) !delete_fuota_task.DeleteFuotaTaskOutput {
        return delete_fuota_task.execute(self, allocator, input, options);
    }

    /// Deletes a multicast group if it is not in use by a FUOTA task.
    pub fn deleteMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: delete_multicast_group.DeleteMulticastGroupInput, options: delete_multicast_group.Options) !delete_multicast_group.DeleteMulticastGroupOutput {
        return delete_multicast_group.execute(self, allocator, input, options);
    }

    /// Deletes a network analyzer configuration.
    pub fn deleteNetworkAnalyzerConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_network_analyzer_configuration.DeleteNetworkAnalyzerConfigurationInput, options: delete_network_analyzer_configuration.Options) !delete_network_analyzer_configuration.DeleteNetworkAnalyzerConfigurationOutput {
        return delete_network_analyzer_configuration.execute(self, allocator, input, options);
    }

    /// Remove queued messages from the downlink queue.
    pub fn deleteQueuedMessages(self: *Self, allocator: std.mem.Allocator, input: delete_queued_messages.DeleteQueuedMessagesInput, options: delete_queued_messages.Options) !delete_queued_messages.DeleteQueuedMessagesOutput {
        return delete_queued_messages.execute(self, allocator, input, options);
    }

    /// Deletes a service profile.
    pub fn deleteServiceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_service_profile.DeleteServiceProfileInput, options: delete_service_profile.Options) !delete_service_profile.DeleteServiceProfileOutput {
        return delete_service_profile.execute(self, allocator, input, options);
    }

    /// Deletes a wireless device.
    pub fn deleteWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: delete_wireless_device.DeleteWirelessDeviceInput, options: delete_wireless_device.Options) !delete_wireless_device.DeleteWirelessDeviceOutput {
        return delete_wireless_device.execute(self, allocator, input, options);
    }

    /// Delete an import task.
    pub fn deleteWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: delete_wireless_device_import_task.DeleteWirelessDeviceImportTaskInput, options: delete_wireless_device_import_task.Options) !delete_wireless_device_import_task.DeleteWirelessDeviceImportTaskOutput {
        return delete_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// Deletes a wireless gateway.
    ///
    /// When deleting a wireless gateway, you might run into duplication errors for
    /// the
    /// following reasons.
    ///
    /// * If you specify a `GatewayEui` value that already exists.
    ///
    /// * If you used a `ClientRequestToken` with the same parameters
    /// within the last 10 minutes.
    ///
    /// To avoid this error, make sure that you use unique identifiers and
    /// parameters for
    /// each request within the specified time period.
    pub fn deleteWirelessGateway(self: *Self, allocator: std.mem.Allocator, input: delete_wireless_gateway.DeleteWirelessGatewayInput, options: delete_wireless_gateway.Options) !delete_wireless_gateway.DeleteWirelessGatewayOutput {
        return delete_wireless_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a wireless gateway task.
    pub fn deleteWirelessGatewayTask(self: *Self, allocator: std.mem.Allocator, input: delete_wireless_gateway_task.DeleteWirelessGatewayTaskInput, options: delete_wireless_gateway_task.Options) !delete_wireless_gateway_task.DeleteWirelessGatewayTaskOutput {
        return delete_wireless_gateway_task.execute(self, allocator, input, options);
    }

    /// Deletes a wireless gateway task definition. Deleting this task definition
    /// does not
    /// affect tasks that are currently in progress.
    pub fn deleteWirelessGatewayTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_wireless_gateway_task_definition.DeleteWirelessGatewayTaskDefinitionInput, options: delete_wireless_gateway_task_definition.Options) !delete_wireless_gateway_task_definition.DeleteWirelessGatewayTaskDefinitionOutput {
        return delete_wireless_gateway_task_definition.execute(self, allocator, input, options);
    }

    /// Deregister a wireless device from AWS IoT Wireless.
    pub fn deregisterWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: deregister_wireless_device.DeregisterWirelessDeviceInput, options: deregister_wireless_device.Options) !deregister_wireless_device.DeregisterWirelessDeviceOutput {
        return deregister_wireless_device.execute(self, allocator, input, options);
    }

    /// Disassociates your AWS account from a partner account. If
    /// `PartnerAccountId` and `PartnerType` are `null`,
    /// disassociates your AWS account from all partner accounts.
    pub fn disassociateAwsAccountFromPartnerAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_aws_account_from_partner_account.DisassociateAwsAccountFromPartnerAccountInput, options: disassociate_aws_account_from_partner_account.Options) !disassociate_aws_account_from_partner_account.DisassociateAwsAccountFromPartnerAccountOutput {
        return disassociate_aws_account_from_partner_account.execute(self, allocator, input, options);
    }

    /// Disassociates a multicast group from a FUOTA task.
    pub fn disassociateMulticastGroupFromFuotaTask(self: *Self, allocator: std.mem.Allocator, input: disassociate_multicast_group_from_fuota_task.DisassociateMulticastGroupFromFuotaTaskInput, options: disassociate_multicast_group_from_fuota_task.Options) !disassociate_multicast_group_from_fuota_task.DisassociateMulticastGroupFromFuotaTaskOutput {
        return disassociate_multicast_group_from_fuota_task.execute(self, allocator, input, options);
    }

    /// Disassociates a wireless device from a FUOTA task.
    pub fn disassociateWirelessDeviceFromFuotaTask(self: *Self, allocator: std.mem.Allocator, input: disassociate_wireless_device_from_fuota_task.DisassociateWirelessDeviceFromFuotaTaskInput, options: disassociate_wireless_device_from_fuota_task.Options) !disassociate_wireless_device_from_fuota_task.DisassociateWirelessDeviceFromFuotaTaskOutput {
        return disassociate_wireless_device_from_fuota_task.execute(self, allocator, input, options);
    }

    /// Disassociates a wireless device from a multicast group.
    pub fn disassociateWirelessDeviceFromMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_wireless_device_from_multicast_group.DisassociateWirelessDeviceFromMulticastGroupInput, options: disassociate_wireless_device_from_multicast_group.Options) !disassociate_wireless_device_from_multicast_group.DisassociateWirelessDeviceFromMulticastGroupOutput {
        return disassociate_wireless_device_from_multicast_group.execute(self, allocator, input, options);
    }

    /// Disassociates a wireless device from its currently associated thing.
    pub fn disassociateWirelessDeviceFromThing(self: *Self, allocator: std.mem.Allocator, input: disassociate_wireless_device_from_thing.DisassociateWirelessDeviceFromThingInput, options: disassociate_wireless_device_from_thing.Options) !disassociate_wireless_device_from_thing.DisassociateWirelessDeviceFromThingOutput {
        return disassociate_wireless_device_from_thing.execute(self, allocator, input, options);
    }

    /// Disassociates a wireless gateway from its currently associated certificate.
    pub fn disassociateWirelessGatewayFromCertificate(self: *Self, allocator: std.mem.Allocator, input: disassociate_wireless_gateway_from_certificate.DisassociateWirelessGatewayFromCertificateInput, options: disassociate_wireless_gateway_from_certificate.Options) !disassociate_wireless_gateway_from_certificate.DisassociateWirelessGatewayFromCertificateOutput {
        return disassociate_wireless_gateway_from_certificate.execute(self, allocator, input, options);
    }

    /// Disassociates a wireless gateway from its currently associated thing.
    pub fn disassociateWirelessGatewayFromThing(self: *Self, allocator: std.mem.Allocator, input: disassociate_wireless_gateway_from_thing.DisassociateWirelessGatewayFromThingInput, options: disassociate_wireless_gateway_from_thing.Options) !disassociate_wireless_gateway_from_thing.DisassociateWirelessGatewayFromThingOutput {
        return disassociate_wireless_gateway_from_thing.execute(self, allocator, input, options);
    }

    /// Gets information about a destination.
    pub fn getDestination(self: *Self, allocator: std.mem.Allocator, input: get_destination.GetDestinationInput, options: get_destination.Options) !get_destination.GetDestinationOutput {
        return get_destination.execute(self, allocator, input, options);
    }

    /// Gets information about a device profile.
    pub fn getDeviceProfile(self: *Self, allocator: std.mem.Allocator, input: get_device_profile.GetDeviceProfileInput, options: get_device_profile.Options) !get_device_profile.GetDeviceProfileOutput {
        return get_device_profile.execute(self, allocator, input, options);
    }

    /// Get the event configuration based on resource types.
    pub fn getEventConfigurationByResourceTypes(self: *Self, allocator: std.mem.Allocator, input: get_event_configuration_by_resource_types.GetEventConfigurationByResourceTypesInput, options: get_event_configuration_by_resource_types.Options) !get_event_configuration_by_resource_types.GetEventConfigurationByResourceTypesOutput {
        return get_event_configuration_by_resource_types.execute(self, allocator, input, options);
    }

    /// Gets information about a FUOTA task.
    pub fn getFuotaTask(self: *Self, allocator: std.mem.Allocator, input: get_fuota_task.GetFuotaTaskInput, options: get_fuota_task.Options) !get_fuota_task.GetFuotaTaskOutput {
        return get_fuota_task.execute(self, allocator, input, options);
    }

    /// Returns current default log levels or log levels by resource types. Based on
    /// the
    /// resource type, log levels can be returned for wireless device, wireless
    /// gateway, or
    /// FUOTA task log options.
    pub fn getLogLevelsByResourceTypes(self: *Self, allocator: std.mem.Allocator, input: get_log_levels_by_resource_types.GetLogLevelsByResourceTypesInput, options: get_log_levels_by_resource_types.Options) !get_log_levels_by_resource_types.GetLogLevelsByResourceTypesOutput {
        return get_log_levels_by_resource_types.execute(self, allocator, input, options);
    }

    /// Get the metric configuration status for this AWS account.
    pub fn getMetricConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_metric_configuration.GetMetricConfigurationInput, options: get_metric_configuration.Options) !get_metric_configuration.GetMetricConfigurationOutput {
        return get_metric_configuration.execute(self, allocator, input, options);
    }

    /// Get the summary metrics for this AWS account.
    pub fn getMetrics(self: *Self, allocator: std.mem.Allocator, input: get_metrics.GetMetricsInput, options: get_metrics.Options) !get_metrics.GetMetricsOutput {
        return get_metrics.execute(self, allocator, input, options);
    }

    /// Gets information about a multicast group.
    pub fn getMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: get_multicast_group.GetMulticastGroupInput, options: get_multicast_group.Options) !get_multicast_group.GetMulticastGroupOutput {
        return get_multicast_group.execute(self, allocator, input, options);
    }

    /// Gets information about a multicast group session.
    pub fn getMulticastGroupSession(self: *Self, allocator: std.mem.Allocator, input: get_multicast_group_session.GetMulticastGroupSessionInput, options: get_multicast_group_session.Options) !get_multicast_group_session.GetMulticastGroupSessionOutput {
        return get_multicast_group_session.execute(self, allocator, input, options);
    }

    /// Get network analyzer configuration.
    pub fn getNetworkAnalyzerConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_network_analyzer_configuration.GetNetworkAnalyzerConfigurationInput, options: get_network_analyzer_configuration.Options) !get_network_analyzer_configuration.GetNetworkAnalyzerConfigurationOutput {
        return get_network_analyzer_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about a partner account. If `PartnerAccountId` and
    /// `PartnerType` are `null`, returns all partner accounts.
    pub fn getPartnerAccount(self: *Self, allocator: std.mem.Allocator, input: get_partner_account.GetPartnerAccountInput, options: get_partner_account.Options) !get_partner_account.GetPartnerAccountOutput {
        return get_partner_account.execute(self, allocator, input, options);
    }

    /// Get the position information for a given resource.
    ///
    /// This action is no longer supported. Calls to retrieve the position
    /// information
    /// should use the
    /// [GetResourcePosition](https://docs.aws.amazon.com/iot-wireless/latest/apireference/API_GetResourcePosition.html) API operation instead.
    pub fn getPosition(self: *Self, allocator: std.mem.Allocator, input: get_position.GetPositionInput, options: get_position.Options) !get_position.GetPositionOutput {
        return get_position.execute(self, allocator, input, options);
    }

    /// Get position configuration for a given resource.
    ///
    /// This action is no longer supported. Calls to retrieve the position
    /// configuration
    /// should use the
    /// [GetResourcePosition](https://docs.aws.amazon.com/iot-wireless/latest/apireference/API_GetResourcePosition.html) API operation instead.
    pub fn getPositionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_position_configuration.GetPositionConfigurationInput, options: get_position_configuration.Options) !get_position_configuration.GetPositionConfigurationOutput {
        return get_position_configuration.execute(self, allocator, input, options);
    }

    /// Get estimated position information as a payload in GeoJSON format. The
    /// payload
    /// measurement data is resolved using solvers that are provided by third-party
    /// vendors.
    pub fn getPositionEstimate(self: *Self, allocator: std.mem.Allocator, input: get_position_estimate.GetPositionEstimateInput, options: get_position_estimate.Options) !get_position_estimate.GetPositionEstimateOutput {
        return get_position_estimate.execute(self, allocator, input, options);
    }

    /// Get the event configuration for a particular resource identifier.
    pub fn getResourceEventConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_resource_event_configuration.GetResourceEventConfigurationInput, options: get_resource_event_configuration.Options) !get_resource_event_configuration.GetResourceEventConfigurationOutput {
        return get_resource_event_configuration.execute(self, allocator, input, options);
    }

    /// Fetches the log-level override, if any, for a given resource ID and resource
    /// type..
    pub fn getResourceLogLevel(self: *Self, allocator: std.mem.Allocator, input: get_resource_log_level.GetResourceLogLevelInput, options: get_resource_log_level.Options) !get_resource_log_level.GetResourceLogLevelOutput {
        return get_resource_log_level.execute(self, allocator, input, options);
    }

    /// Get the position information for a given wireless device or a wireless
    /// gateway
    /// resource. The position information uses the [ World Geodetic System
    /// (WGS84)](https://gisgeography.com/wgs84-world-geodetic-system/).
    pub fn getResourcePosition(self: *Self, allocator: std.mem.Allocator, input: get_resource_position.GetResourcePositionInput, options: get_resource_position.Options) !get_resource_position.GetResourcePositionOutput {
        return get_resource_position.execute(self, allocator, input, options);
    }

    /// Gets the account-specific endpoint for Configuration and Update Server
    /// (CUPS) protocol
    /// or LoRaWAN Network Server (LNS) connections.
    pub fn getServiceEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_service_endpoint.GetServiceEndpointInput, options: get_service_endpoint.Options) !get_service_endpoint.GetServiceEndpointOutput {
        return get_service_endpoint.execute(self, allocator, input, options);
    }

    /// Gets information about a service profile.
    pub fn getServiceProfile(self: *Self, allocator: std.mem.Allocator, input: get_service_profile.GetServiceProfileInput, options: get_service_profile.Options) !get_service_profile.GetServiceProfileOutput {
        return get_service_profile.execute(self, allocator, input, options);
    }

    /// Gets information about a wireless device.
    pub fn getWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: get_wireless_device.GetWirelessDeviceInput, options: get_wireless_device.Options) !get_wireless_device.GetWirelessDeviceOutput {
        return get_wireless_device.execute(self, allocator, input, options);
    }

    /// Get information about an import task and count of device onboarding summary
    /// information for the import task.
    pub fn getWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: get_wireless_device_import_task.GetWirelessDeviceImportTaskInput, options: get_wireless_device_import_task.Options) !get_wireless_device_import_task.GetWirelessDeviceImportTaskOutput {
        return get_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// Gets operating information about a wireless device.
    pub fn getWirelessDeviceStatistics(self: *Self, allocator: std.mem.Allocator, input: get_wireless_device_statistics.GetWirelessDeviceStatisticsInput, options: get_wireless_device_statistics.Options) !get_wireless_device_statistics.GetWirelessDeviceStatisticsOutput {
        return get_wireless_device_statistics.execute(self, allocator, input, options);
    }

    /// Gets information about a wireless gateway.
    pub fn getWirelessGateway(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway.GetWirelessGatewayInput, options: get_wireless_gateway.Options) !get_wireless_gateway.GetWirelessGatewayOutput {
        return get_wireless_gateway.execute(self, allocator, input, options);
    }

    /// Gets the ID of the certificate that is currently associated with a wireless
    /// gateway.
    pub fn getWirelessGatewayCertificate(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway_certificate.GetWirelessGatewayCertificateInput, options: get_wireless_gateway_certificate.Options) !get_wireless_gateway_certificate.GetWirelessGatewayCertificateOutput {
        return get_wireless_gateway_certificate.execute(self, allocator, input, options);
    }

    /// Gets the firmware version and other information about a wireless gateway.
    pub fn getWirelessGatewayFirmwareInformation(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway_firmware_information.GetWirelessGatewayFirmwareInformationInput, options: get_wireless_gateway_firmware_information.Options) !get_wireless_gateway_firmware_information.GetWirelessGatewayFirmwareInformationOutput {
        return get_wireless_gateway_firmware_information.execute(self, allocator, input, options);
    }

    /// Gets operating information about a wireless gateway.
    pub fn getWirelessGatewayStatistics(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway_statistics.GetWirelessGatewayStatisticsInput, options: get_wireless_gateway_statistics.Options) !get_wireless_gateway_statistics.GetWirelessGatewayStatisticsOutput {
        return get_wireless_gateway_statistics.execute(self, allocator, input, options);
    }

    /// Gets information about a wireless gateway task.
    pub fn getWirelessGatewayTask(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway_task.GetWirelessGatewayTaskInput, options: get_wireless_gateway_task.Options) !get_wireless_gateway_task.GetWirelessGatewayTaskOutput {
        return get_wireless_gateway_task.execute(self, allocator, input, options);
    }

    /// Gets information about a wireless gateway task definition.
    pub fn getWirelessGatewayTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: get_wireless_gateway_task_definition.GetWirelessGatewayTaskDefinitionInput, options: get_wireless_gateway_task_definition.Options) !get_wireless_gateway_task_definition.GetWirelessGatewayTaskDefinitionOutput {
        return get_wireless_gateway_task_definition.execute(self, allocator, input, options);
    }

    /// Lists the destinations registered to your AWS account.
    pub fn listDestinations(self: *Self, allocator: std.mem.Allocator, input: list_destinations.ListDestinationsInput, options: list_destinations.Options) !list_destinations.ListDestinationsOutput {
        return list_destinations.execute(self, allocator, input, options);
    }

    /// Lists the device profiles registered to your AWS account.
    pub fn listDeviceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_device_profiles.ListDeviceProfilesInput, options: list_device_profiles.Options) !list_device_profiles.ListDeviceProfilesOutput {
        return list_device_profiles.execute(self, allocator, input, options);
    }

    /// List the Sidewalk devices in an import task and their onboarding status.
    pub fn listDevicesForWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: list_devices_for_wireless_device_import_task.ListDevicesForWirelessDeviceImportTaskInput, options: list_devices_for_wireless_device_import_task.Options) !list_devices_for_wireless_device_import_task.ListDevicesForWirelessDeviceImportTaskOutput {
        return list_devices_for_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// List event configurations where at least one event topic has been enabled.
    pub fn listEventConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_event_configurations.ListEventConfigurationsInput, options: list_event_configurations.Options) !list_event_configurations.ListEventConfigurationsOutput {
        return list_event_configurations.execute(self, allocator, input, options);
    }

    /// Lists the FUOTA tasks registered to your AWS account.
    pub fn listFuotaTasks(self: *Self, allocator: std.mem.Allocator, input: list_fuota_tasks.ListFuotaTasksInput, options: list_fuota_tasks.Options) !list_fuota_tasks.ListFuotaTasksOutput {
        return list_fuota_tasks.execute(self, allocator, input, options);
    }

    /// Lists the multicast groups registered to your AWS account.
    pub fn listMulticastGroups(self: *Self, allocator: std.mem.Allocator, input: list_multicast_groups.ListMulticastGroupsInput, options: list_multicast_groups.Options) !list_multicast_groups.ListMulticastGroupsOutput {
        return list_multicast_groups.execute(self, allocator, input, options);
    }

    /// List all multicast groups associated with a FUOTA task.
    pub fn listMulticastGroupsByFuotaTask(self: *Self, allocator: std.mem.Allocator, input: list_multicast_groups_by_fuota_task.ListMulticastGroupsByFuotaTaskInput, options: list_multicast_groups_by_fuota_task.Options) !list_multicast_groups_by_fuota_task.ListMulticastGroupsByFuotaTaskOutput {
        return list_multicast_groups_by_fuota_task.execute(self, allocator, input, options);
    }

    /// Lists the network analyzer configurations.
    pub fn listNetworkAnalyzerConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_network_analyzer_configurations.ListNetworkAnalyzerConfigurationsInput, options: list_network_analyzer_configurations.Options) !list_network_analyzer_configurations.ListNetworkAnalyzerConfigurationsOutput {
        return list_network_analyzer_configurations.execute(self, allocator, input, options);
    }

    /// Lists the partner accounts associated with your AWS account.
    pub fn listPartnerAccounts(self: *Self, allocator: std.mem.Allocator, input: list_partner_accounts.ListPartnerAccountsInput, options: list_partner_accounts.Options) !list_partner_accounts.ListPartnerAccountsOutput {
        return list_partner_accounts.execute(self, allocator, input, options);
    }

    /// List position configurations for a given resource, such as positioning
    /// solvers.
    ///
    /// This action is no longer supported. Calls to retrieve position information
    /// should
    /// use the
    /// [GetResourcePosition](https://docs.aws.amazon.com/iot-wireless/latest/apireference/API_GetResourcePosition.html) API operation instead.
    pub fn listPositionConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_position_configurations.ListPositionConfigurationsInput, options: list_position_configurations.Options) !list_position_configurations.ListPositionConfigurationsOutput {
        return list_position_configurations.execute(self, allocator, input, options);
    }

    /// List queued messages in the downlink queue.
    pub fn listQueuedMessages(self: *Self, allocator: std.mem.Allocator, input: list_queued_messages.ListQueuedMessagesInput, options: list_queued_messages.Options) !list_queued_messages.ListQueuedMessagesOutput {
        return list_queued_messages.execute(self, allocator, input, options);
    }

    /// Lists the service profiles registered to your AWS account.
    pub fn listServiceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_service_profiles.ListServiceProfilesInput, options: list_service_profiles.Options) !list_service_profiles.ListServiceProfilesOutput {
        return list_service_profiles.execute(self, allocator, input, options);
    }

    /// Lists the tags (metadata) you have assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List of import tasks and summary information of onboarding status of devices
    /// in each
    /// import task.
    pub fn listWirelessDeviceImportTasks(self: *Self, allocator: std.mem.Allocator, input: list_wireless_device_import_tasks.ListWirelessDeviceImportTasksInput, options: list_wireless_device_import_tasks.Options) !list_wireless_device_import_tasks.ListWirelessDeviceImportTasksOutput {
        return list_wireless_device_import_tasks.execute(self, allocator, input, options);
    }

    /// Lists the wireless devices registered to your AWS account.
    pub fn listWirelessDevices(self: *Self, allocator: std.mem.Allocator, input: list_wireless_devices.ListWirelessDevicesInput, options: list_wireless_devices.Options) !list_wireless_devices.ListWirelessDevicesOutput {
        return list_wireless_devices.execute(self, allocator, input, options);
    }

    /// List the wireless gateway tasks definitions registered to your AWS account.
    pub fn listWirelessGatewayTaskDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_wireless_gateway_task_definitions.ListWirelessGatewayTaskDefinitionsInput, options: list_wireless_gateway_task_definitions.Options) !list_wireless_gateway_task_definitions.ListWirelessGatewayTaskDefinitionsOutput {
        return list_wireless_gateway_task_definitions.execute(self, allocator, input, options);
    }

    /// Lists the wireless gateways registered to your AWS account.
    pub fn listWirelessGateways(self: *Self, allocator: std.mem.Allocator, input: list_wireless_gateways.ListWirelessGatewaysInput, options: list_wireless_gateways.Options) !list_wireless_gateways.ListWirelessGatewaysOutput {
        return list_wireless_gateways.execute(self, allocator, input, options);
    }

    /// Put position configuration for a given resource.
    ///
    /// This action is no longer supported. Calls to update the position
    /// configuration
    /// should use the
    /// [UpdateResourcePosition](https://docs.aws.amazon.com/iot-wireless/latest/apireference/API_UpdateResourcePosition.html) API operation instead.
    pub fn putPositionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_position_configuration.PutPositionConfigurationInput, options: put_position_configuration.Options) !put_position_configuration.PutPositionConfigurationOutput {
        return put_position_configuration.execute(self, allocator, input, options);
    }

    /// Sets the log-level override for a resource ID and resource type. A limit of
    /// 200 log
    /// level override can be set per account.
    pub fn putResourceLogLevel(self: *Self, allocator: std.mem.Allocator, input: put_resource_log_level.PutResourceLogLevelInput, options: put_resource_log_level.Options) !put_resource_log_level.PutResourceLogLevelOutput {
        return put_resource_log_level.execute(self, allocator, input, options);
    }

    /// Removes the log-level overrides for all resources; wireless devices,
    /// wireless
    /// gateways, and FUOTA tasks.
    pub fn resetAllResourceLogLevels(self: *Self, allocator: std.mem.Allocator, input: reset_all_resource_log_levels.ResetAllResourceLogLevelsInput, options: reset_all_resource_log_levels.Options) !reset_all_resource_log_levels.ResetAllResourceLogLevelsOutput {
        return reset_all_resource_log_levels.execute(self, allocator, input, options);
    }

    /// Removes the log-level override, if any, for a specific resource ID and
    /// resource type.
    /// It can be used for a wireless device, a wireless gateway, or a FUOTA task.
    pub fn resetResourceLogLevel(self: *Self, allocator: std.mem.Allocator, input: reset_resource_log_level.ResetResourceLogLevelInput, options: reset_resource_log_level.Options) !reset_resource_log_level.ResetResourceLogLevelOutput {
        return reset_resource_log_level.execute(self, allocator, input, options);
    }

    /// Sends the specified data to a multicast group.
    pub fn sendDataToMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: send_data_to_multicast_group.SendDataToMulticastGroupInput, options: send_data_to_multicast_group.Options) !send_data_to_multicast_group.SendDataToMulticastGroupOutput {
        return send_data_to_multicast_group.execute(self, allocator, input, options);
    }

    /// Sends a decrypted application data frame to a device.
    pub fn sendDataToWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: send_data_to_wireless_device.SendDataToWirelessDeviceInput, options: send_data_to_wireless_device.Options) !send_data_to_wireless_device.SendDataToWirelessDeviceOutput {
        return send_data_to_wireless_device.execute(self, allocator, input, options);
    }

    /// Starts a bulk association of all qualifying wireless devices with a
    /// multicast
    /// group.
    pub fn startBulkAssociateWirelessDeviceWithMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: start_bulk_associate_wireless_device_with_multicast_group.StartBulkAssociateWirelessDeviceWithMulticastGroupInput, options: start_bulk_associate_wireless_device_with_multicast_group.Options) !start_bulk_associate_wireless_device_with_multicast_group.StartBulkAssociateWirelessDeviceWithMulticastGroupOutput {
        return start_bulk_associate_wireless_device_with_multicast_group.execute(self, allocator, input, options);
    }

    /// Starts a bulk disassociatin of all qualifying wireless devices from a
    /// multicast
    /// group.
    pub fn startBulkDisassociateWirelessDeviceFromMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: start_bulk_disassociate_wireless_device_from_multicast_group.StartBulkDisassociateWirelessDeviceFromMulticastGroupInput, options: start_bulk_disassociate_wireless_device_from_multicast_group.Options) !start_bulk_disassociate_wireless_device_from_multicast_group.StartBulkDisassociateWirelessDeviceFromMulticastGroupOutput {
        return start_bulk_disassociate_wireless_device_from_multicast_group.execute(self, allocator, input, options);
    }

    /// Starts a FUOTA task.
    pub fn startFuotaTask(self: *Self, allocator: std.mem.Allocator, input: start_fuota_task.StartFuotaTaskInput, options: start_fuota_task.Options) !start_fuota_task.StartFuotaTaskOutput {
        return start_fuota_task.execute(self, allocator, input, options);
    }

    /// Starts a multicast group session.
    pub fn startMulticastGroupSession(self: *Self, allocator: std.mem.Allocator, input: start_multicast_group_session.StartMulticastGroupSessionInput, options: start_multicast_group_session.Options) !start_multicast_group_session.StartMulticastGroupSessionOutput {
        return start_multicast_group_session.execute(self, allocator, input, options);
    }

    /// Start import task for a single wireless device.
    pub fn startSingleWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: start_single_wireless_device_import_task.StartSingleWirelessDeviceImportTaskInput, options: start_single_wireless_device_import_task.Options) !start_single_wireless_device_import_task.StartSingleWirelessDeviceImportTaskOutput {
        return start_single_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// Start import task for provisioning Sidewalk devices in bulk using an S3 CSV
    /// file.
    pub fn startWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: start_wireless_device_import_task.StartWirelessDeviceImportTaskInput, options: start_wireless_device_import_task.Options) !start_wireless_device_import_task.StartWirelessDeviceImportTaskOutput {
        return start_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Simulates a provisioned device by sending an uplink data payload of
    /// `Hello`.
    pub fn testWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: test_wireless_device.TestWirelessDeviceInput, options: test_wireless_device.Options) !test_wireless_device.TestWirelessDeviceOutput {
        return test_wireless_device.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates properties of a destination.
    pub fn updateDestination(self: *Self, allocator: std.mem.Allocator, input: update_destination.UpdateDestinationInput, options: update_destination.Options) !update_destination.UpdateDestinationOutput {
        return update_destination.execute(self, allocator, input, options);
    }

    /// Update the event configuration based on resource types.
    pub fn updateEventConfigurationByResourceTypes(self: *Self, allocator: std.mem.Allocator, input: update_event_configuration_by_resource_types.UpdateEventConfigurationByResourceTypesInput, options: update_event_configuration_by_resource_types.Options) !update_event_configuration_by_resource_types.UpdateEventConfigurationByResourceTypesOutput {
        return update_event_configuration_by_resource_types.execute(self, allocator, input, options);
    }

    /// Updates properties of a FUOTA task.
    pub fn updateFuotaTask(self: *Self, allocator: std.mem.Allocator, input: update_fuota_task.UpdateFuotaTaskInput, options: update_fuota_task.Options) !update_fuota_task.UpdateFuotaTaskOutput {
        return update_fuota_task.execute(self, allocator, input, options);
    }

    /// Set default log level, or log levels by resource types. This can be for
    /// wireless
    /// device, wireless gateway, or FUOTA task log options, and is used to control
    /// the log
    /// messages that'll be displayed in CloudWatch.
    pub fn updateLogLevelsByResourceTypes(self: *Self, allocator: std.mem.Allocator, input: update_log_levels_by_resource_types.UpdateLogLevelsByResourceTypesInput, options: update_log_levels_by_resource_types.Options) !update_log_levels_by_resource_types.UpdateLogLevelsByResourceTypesOutput {
        return update_log_levels_by_resource_types.execute(self, allocator, input, options);
    }

    /// Update the summary metric configuration.
    pub fn updateMetricConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_metric_configuration.UpdateMetricConfigurationInput, options: update_metric_configuration.Options) !update_metric_configuration.UpdateMetricConfigurationOutput {
        return update_metric_configuration.execute(self, allocator, input, options);
    }

    /// Updates properties of a multicast group session.
    pub fn updateMulticastGroup(self: *Self, allocator: std.mem.Allocator, input: update_multicast_group.UpdateMulticastGroupInput, options: update_multicast_group.Options) !update_multicast_group.UpdateMulticastGroupOutput {
        return update_multicast_group.execute(self, allocator, input, options);
    }

    /// Update network analyzer configuration.
    pub fn updateNetworkAnalyzerConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_network_analyzer_configuration.UpdateNetworkAnalyzerConfigurationInput, options: update_network_analyzer_configuration.Options) !update_network_analyzer_configuration.UpdateNetworkAnalyzerConfigurationOutput {
        return update_network_analyzer_configuration.execute(self, allocator, input, options);
    }

    /// Updates properties of a partner account.
    pub fn updatePartnerAccount(self: *Self, allocator: std.mem.Allocator, input: update_partner_account.UpdatePartnerAccountInput, options: update_partner_account.Options) !update_partner_account.UpdatePartnerAccountOutput {
        return update_partner_account.execute(self, allocator, input, options);
    }

    /// Update the position information of a resource.
    ///
    /// This action is no longer supported. Calls to update the position information
    /// should use the
    /// [UpdateResourcePosition](https://docs.aws.amazon.com/iot-wireless/latest/apireference/API_UpdateResourcePosition.html) API operation instead.
    pub fn updatePosition(self: *Self, allocator: std.mem.Allocator, input: update_position.UpdatePositionInput, options: update_position.Options) !update_position.UpdatePositionOutput {
        return update_position.execute(self, allocator, input, options);
    }

    /// Update the event configuration for a particular resource identifier.
    pub fn updateResourceEventConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_resource_event_configuration.UpdateResourceEventConfigurationInput, options: update_resource_event_configuration.Options) !update_resource_event_configuration.UpdateResourceEventConfigurationOutput {
        return update_resource_event_configuration.execute(self, allocator, input, options);
    }

    /// Update the position information of a given wireless device or a wireless
    /// gateway
    /// resource. The position coordinates are based on the [ World Geodetic System
    /// (WGS84)](https://gisgeography.com/wgs84-world-geodetic-system/).
    pub fn updateResourcePosition(self: *Self, allocator: std.mem.Allocator, input: update_resource_position.UpdateResourcePositionInput, options: update_resource_position.Options) !update_resource_position.UpdateResourcePositionOutput {
        return update_resource_position.execute(self, allocator, input, options);
    }

    /// Updates properties of a wireless device.
    pub fn updateWirelessDevice(self: *Self, allocator: std.mem.Allocator, input: update_wireless_device.UpdateWirelessDeviceInput, options: update_wireless_device.Options) !update_wireless_device.UpdateWirelessDeviceOutput {
        return update_wireless_device.execute(self, allocator, input, options);
    }

    /// Update an import task to add more devices to the task.
    pub fn updateWirelessDeviceImportTask(self: *Self, allocator: std.mem.Allocator, input: update_wireless_device_import_task.UpdateWirelessDeviceImportTaskInput, options: update_wireless_device_import_task.Options) !update_wireless_device_import_task.UpdateWirelessDeviceImportTaskOutput {
        return update_wireless_device_import_task.execute(self, allocator, input, options);
    }

    /// Updates properties of a wireless gateway.
    pub fn updateWirelessGateway(self: *Self, allocator: std.mem.Allocator, input: update_wireless_gateway.UpdateWirelessGatewayInput, options: update_wireless_gateway.Options) !update_wireless_gateway.UpdateWirelessGatewayOutput {
        return update_wireless_gateway.execute(self, allocator, input, options);
    }

    pub fn listDestinationsPaginator(self: *Self, params: list_destinations.ListDestinationsInput) paginator.ListDestinationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeviceProfilesPaginator(self: *Self, params: list_device_profiles.ListDeviceProfilesInput) paginator.ListDeviceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFuotaTasksPaginator(self: *Self, params: list_fuota_tasks.ListFuotaTasksInput) paginator.ListFuotaTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMulticastGroupsPaginator(self: *Self, params: list_multicast_groups.ListMulticastGroupsInput) paginator.ListMulticastGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMulticastGroupsByFuotaTaskPaginator(self: *Self, params: list_multicast_groups_by_fuota_task.ListMulticastGroupsByFuotaTaskInput) paginator.ListMulticastGroupsByFuotaTaskPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNetworkAnalyzerConfigurationsPaginator(self: *Self, params: list_network_analyzer_configurations.ListNetworkAnalyzerConfigurationsInput) paginator.ListNetworkAnalyzerConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPositionConfigurationsPaginator(self: *Self, params: list_position_configurations.ListPositionConfigurationsInput) paginator.ListPositionConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueuedMessagesPaginator(self: *Self, params: list_queued_messages.ListQueuedMessagesInput) paginator.ListQueuedMessagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceProfilesPaginator(self: *Self, params: list_service_profiles.ListServiceProfilesInput) paginator.ListServiceProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWirelessDevicesPaginator(self: *Self, params: list_wireless_devices.ListWirelessDevicesInput) paginator.ListWirelessDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWirelessGatewaysPaginator(self: *Self, params: list_wireless_gateways.ListWirelessGatewaysInput) paginator.ListWirelessGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
