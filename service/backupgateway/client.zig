const aws = @import("aws");
const std = @import("std");

const associate_gateway_to_server = @import("associate_gateway_to_server.zig");
const create_gateway = @import("create_gateway.zig");
const delete_gateway = @import("delete_gateway.zig");
const delete_hypervisor = @import("delete_hypervisor.zig");
const disassociate_gateway_from_server = @import("disassociate_gateway_from_server.zig");
const get_bandwidth_rate_limit_schedule = @import("get_bandwidth_rate_limit_schedule.zig");
const get_gateway = @import("get_gateway.zig");
const get_hypervisor = @import("get_hypervisor.zig");
const get_hypervisor_property_mappings = @import("get_hypervisor_property_mappings.zig");
const get_virtual_machine = @import("get_virtual_machine.zig");
const import_hypervisor_configuration = @import("import_hypervisor_configuration.zig");
const list_gateways = @import("list_gateways.zig");
const list_hypervisors = @import("list_hypervisors.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_virtual_machines = @import("list_virtual_machines.zig");
const put_bandwidth_rate_limit_schedule = @import("put_bandwidth_rate_limit_schedule.zig");
const put_hypervisor_property_mappings = @import("put_hypervisor_property_mappings.zig");
const put_maintenance_start_time = @import("put_maintenance_start_time.zig");
const start_virtual_machines_metadata_sync = @import("start_virtual_machines_metadata_sync.zig");
const tag_resource = @import("tag_resource.zig");
const test_hypervisor_configuration = @import("test_hypervisor_configuration.zig");
const untag_resource = @import("untag_resource.zig");
const update_gateway_information = @import("update_gateway_information.zig");
const update_gateway_software_now = @import("update_gateway_software_now.zig");
const update_hypervisor = @import("update_hypervisor.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Backup Gateway";

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

    /// Associates a backup gateway with your server. After you complete the
    /// association process,
    /// you can back up and restore your VMs through the gateway.
    pub fn associateGatewayToServer(self: *Self, allocator: std.mem.Allocator, input: associate_gateway_to_server.AssociateGatewayToServerInput, options: CallOptions) !associate_gateway_to_server.AssociateGatewayToServerOutput {
        return associate_gateway_to_server.execute(self, allocator, input, options);
    }

    /// Creates a backup gateway. After you create a gateway, you can associate it
    /// with a server
    /// using the `AssociateGatewayToServer` operation.
    pub fn createGateway(self: *Self, allocator: std.mem.Allocator, input: create_gateway.CreateGatewayInput, options: CallOptions) !create_gateway.CreateGatewayOutput {
        return create_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a backup gateway.
    pub fn deleteGateway(self: *Self, allocator: std.mem.Allocator, input: delete_gateway.DeleteGatewayInput, options: CallOptions) !delete_gateway.DeleteGatewayOutput {
        return delete_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a hypervisor.
    pub fn deleteHypervisor(self: *Self, allocator: std.mem.Allocator, input: delete_hypervisor.DeleteHypervisorInput, options: CallOptions) !delete_hypervisor.DeleteHypervisorOutput {
        return delete_hypervisor.execute(self, allocator, input, options);
    }

    /// Disassociates a backup gateway from the specified server. After the
    /// disassociation process
    /// finishes, the gateway can no longer access the virtual machines on the
    /// server.
    pub fn disassociateGatewayFromServer(self: *Self, allocator: std.mem.Allocator, input: disassociate_gateway_from_server.DisassociateGatewayFromServerInput, options: CallOptions) !disassociate_gateway_from_server.DisassociateGatewayFromServerOutput {
        return disassociate_gateway_from_server.execute(self, allocator, input, options);
    }

    /// Retrieves the bandwidth rate limit schedule for a specified gateway.
    /// By default, gateways do not have bandwidth rate limit schedules, which means
    /// no bandwidth rate limiting is in effect. Use this to get a gateway's
    /// bandwidth rate limit schedule.
    pub fn getBandwidthRateLimitSchedule(self: *Self, allocator: std.mem.Allocator, input: get_bandwidth_rate_limit_schedule.GetBandwidthRateLimitScheduleInput, options: CallOptions) !get_bandwidth_rate_limit_schedule.GetBandwidthRateLimitScheduleOutput {
        return get_bandwidth_rate_limit_schedule.execute(self, allocator, input, options);
    }

    /// By providing the ARN (Amazon Resource Name), this
    /// API returns the gateway.
    pub fn getGateway(self: *Self, allocator: std.mem.Allocator, input: get_gateway.GetGatewayInput, options: CallOptions) !get_gateway.GetGatewayOutput {
        return get_gateway.execute(self, allocator, input, options);
    }

    /// This action requests information about the specified hypervisor to which the
    /// gateway will connect.
    /// A hypervisor is hardware, software, or firmware that creates and manages
    /// virtual machines,
    /// and allocates resources to them.
    pub fn getHypervisor(self: *Self, allocator: std.mem.Allocator, input: get_hypervisor.GetHypervisorInput, options: CallOptions) !get_hypervisor.GetHypervisorOutput {
        return get_hypervisor.execute(self, allocator, input, options);
    }

    /// This action retrieves the property mappings for the specified hypervisor.
    /// A hypervisor property mapping displays the relationship of entity properties
    /// available from the hypervisor to the properties available in Amazon Web
    /// Services.
    pub fn getHypervisorPropertyMappings(self: *Self, allocator: std.mem.Allocator, input: get_hypervisor_property_mappings.GetHypervisorPropertyMappingsInput, options: CallOptions) !get_hypervisor_property_mappings.GetHypervisorPropertyMappingsOutput {
        return get_hypervisor_property_mappings.execute(self, allocator, input, options);
    }

    /// By providing the ARN (Amazon Resource Name), this API returns the virtual
    /// machine.
    pub fn getVirtualMachine(self: *Self, allocator: std.mem.Allocator, input: get_virtual_machine.GetVirtualMachineInput, options: CallOptions) !get_virtual_machine.GetVirtualMachineOutput {
        return get_virtual_machine.execute(self, allocator, input, options);
    }

    /// Connect to a hypervisor by importing its configuration.
    pub fn importHypervisorConfiguration(self: *Self, allocator: std.mem.Allocator, input: import_hypervisor_configuration.ImportHypervisorConfigurationInput, options: CallOptions) !import_hypervisor_configuration.ImportHypervisorConfigurationOutput {
        return import_hypervisor_configuration.execute(self, allocator, input, options);
    }

    /// Lists backup gateways owned by an Amazon Web Services account in an Amazon
    /// Web Services Region. The returned list is ordered by gateway Amazon Resource
    /// Name (ARN).
    pub fn listGateways(self: *Self, allocator: std.mem.Allocator, input: list_gateways.ListGatewaysInput, options: CallOptions) !list_gateways.ListGatewaysOutput {
        return list_gateways.execute(self, allocator, input, options);
    }

    /// Lists your hypervisors.
    pub fn listHypervisors(self: *Self, allocator: std.mem.Allocator, input: list_hypervisors.ListHypervisorsInput, options: CallOptions) !list_hypervisors.ListHypervisorsOutput {
        return list_hypervisors.execute(self, allocator, input, options);
    }

    /// Lists the tags applied to the resource identified by its Amazon Resource
    /// Name
    /// (ARN).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists your virtual machines.
    pub fn listVirtualMachines(self: *Self, allocator: std.mem.Allocator, input: list_virtual_machines.ListVirtualMachinesInput, options: CallOptions) !list_virtual_machines.ListVirtualMachinesOutput {
        return list_virtual_machines.execute(self, allocator, input, options);
    }

    /// This action sets the bandwidth rate limit schedule for a specified gateway.
    /// By default, gateways do not have a bandwidth rate limit schedule, which
    /// means
    /// no bandwidth rate limiting is in effect. Use this to initiate a
    /// gateway's bandwidth rate limit schedule.
    pub fn putBandwidthRateLimitSchedule(self: *Self, allocator: std.mem.Allocator, input: put_bandwidth_rate_limit_schedule.PutBandwidthRateLimitScheduleInput, options: CallOptions) !put_bandwidth_rate_limit_schedule.PutBandwidthRateLimitScheduleOutput {
        return put_bandwidth_rate_limit_schedule.execute(self, allocator, input, options);
    }

    /// This action sets the property mappings for the specified hypervisor.
    /// A hypervisor property mapping displays the relationship of entity properties
    /// available from the hypervisor to the properties available in Amazon Web
    /// Services.
    pub fn putHypervisorPropertyMappings(self: *Self, allocator: std.mem.Allocator, input: put_hypervisor_property_mappings.PutHypervisorPropertyMappingsInput, options: CallOptions) !put_hypervisor_property_mappings.PutHypervisorPropertyMappingsOutput {
        return put_hypervisor_property_mappings.execute(self, allocator, input, options);
    }

    /// Set the maintenance start time for a gateway.
    pub fn putMaintenanceStartTime(self: *Self, allocator: std.mem.Allocator, input: put_maintenance_start_time.PutMaintenanceStartTimeInput, options: CallOptions) !put_maintenance_start_time.PutMaintenanceStartTimeOutput {
        return put_maintenance_start_time.execute(self, allocator, input, options);
    }

    /// This action sends a request to sync metadata across the specified virtual
    /// machines.
    pub fn startVirtualMachinesMetadataSync(self: *Self, allocator: std.mem.Allocator, input: start_virtual_machines_metadata_sync.StartVirtualMachinesMetadataSyncInput, options: CallOptions) !start_virtual_machines_metadata_sync.StartVirtualMachinesMetadataSyncOutput {
        return start_virtual_machines_metadata_sync.execute(self, allocator, input, options);
    }

    /// Tag the resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests your hypervisor configuration to validate that backup gateway can
    /// connect with the
    /// hypervisor and its resources.
    pub fn testHypervisorConfiguration(self: *Self, allocator: std.mem.Allocator, input: test_hypervisor_configuration.TestHypervisorConfigurationInput, options: CallOptions) !test_hypervisor_configuration.TestHypervisorConfigurationOutput {
        return test_hypervisor_configuration.execute(self, allocator, input, options);
    }

    /// Removes tags from the resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a gateway's name. Specify which gateway to update using the Amazon
    /// Resource Name
    /// (ARN) of the gateway in your request.
    pub fn updateGatewayInformation(self: *Self, allocator: std.mem.Allocator, input: update_gateway_information.UpdateGatewayInformationInput, options: CallOptions) !update_gateway_information.UpdateGatewayInformationOutput {
        return update_gateway_information.execute(self, allocator, input, options);
    }

    /// Updates the gateway virtual machine (VM) software.
    /// The request immediately triggers the software update.
    ///
    /// When you make this request, you get a `200 OK`
    /// success response immediately. However, it might take some
    /// time for the update to complete.
    pub fn updateGatewaySoftwareNow(self: *Self, allocator: std.mem.Allocator, input: update_gateway_software_now.UpdateGatewaySoftwareNowInput, options: CallOptions) !update_gateway_software_now.UpdateGatewaySoftwareNowOutput {
        return update_gateway_software_now.execute(self, allocator, input, options);
    }

    /// Updates a hypervisor metadata, including its host, username, and password.
    /// Specify which
    /// hypervisor to update using the Amazon Resource Name (ARN) of the hypervisor
    /// in your
    /// request.
    pub fn updateHypervisor(self: *Self, allocator: std.mem.Allocator, input: update_hypervisor.UpdateHypervisorInput, options: CallOptions) !update_hypervisor.UpdateHypervisorOutput {
        return update_hypervisor.execute(self, allocator, input, options);
    }

    pub fn listGatewaysPaginator(self: *Self, params: list_gateways.ListGatewaysInput) paginator.ListGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listHypervisorsPaginator(self: *Self, params: list_hypervisors.ListHypervisorsInput) paginator.ListHypervisorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listVirtualMachinesPaginator(self: *Self, params: list_virtual_machines.ListVirtualMachinesInput) paginator.ListVirtualMachinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
