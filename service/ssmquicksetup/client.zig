const aws = @import("aws");
const std = @import("std");

const create_configuration_manager = @import("create_configuration_manager.zig");
const delete_configuration_manager = @import("delete_configuration_manager.zig");
const get_configuration = @import("get_configuration.zig");
const get_configuration_manager = @import("get_configuration_manager.zig");
const get_service_settings = @import("get_service_settings.zig");
const list_configuration_managers = @import("list_configuration_managers.zig");
const list_configurations = @import("list_configurations.zig");
const list_quick_setup_types = @import("list_quick_setup_types.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_configuration_definition = @import("update_configuration_definition.zig");
const update_configuration_manager = @import("update_configuration_manager.zig");
const update_service_settings = @import("update_service_settings.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSM QuickSetup";

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

    /// Creates a Quick Setup configuration manager resource. This object is a
    /// collection
    /// of desired state configurations for multiple configuration definitions and
    /// summaries describing the deployments of those definitions.
    pub fn createConfigurationManager(self: *Self, allocator: std.mem.Allocator, input: create_configuration_manager.CreateConfigurationManagerInput, options: CallOptions) !create_configuration_manager.CreateConfigurationManagerOutput {
        return create_configuration_manager.execute(self, allocator, input, options);
    }

    /// Deletes a configuration manager.
    pub fn deleteConfigurationManager(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_manager.DeleteConfigurationManagerInput, options: CallOptions) !delete_configuration_manager.DeleteConfigurationManagerOutput {
        return delete_configuration_manager.execute(self, allocator, input, options);
    }

    /// Returns details about the specified configuration.
    pub fn getConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_configuration.GetConfigurationInput, options: CallOptions) !get_configuration.GetConfigurationOutput {
        return get_configuration.execute(self, allocator, input, options);
    }

    /// Returns a configuration manager.
    pub fn getConfigurationManager(self: *Self, allocator: std.mem.Allocator, input: get_configuration_manager.GetConfigurationManagerInput, options: CallOptions) !get_configuration_manager.GetConfigurationManagerOutput {
        return get_configuration_manager.execute(self, allocator, input, options);
    }

    /// Returns settings configured for Quick Setup in the requesting Amazon Web
    /// Services account and Amazon Web Services Region.
    pub fn getServiceSettings(self: *Self, allocator: std.mem.Allocator, input: get_service_settings.GetServiceSettingsInput, options: CallOptions) !get_service_settings.GetServiceSettingsOutput {
        return get_service_settings.execute(self, allocator, input, options);
    }

    /// Returns Quick Setup configuration managers.
    pub fn listConfigurationManagers(self: *Self, allocator: std.mem.Allocator, input: list_configuration_managers.ListConfigurationManagersInput, options: CallOptions) !list_configuration_managers.ListConfigurationManagersOutput {
        return list_configuration_managers.execute(self, allocator, input, options);
    }

    /// Returns configurations deployed by Quick Setup in the requesting Amazon Web
    /// Services account and Amazon Web Services Region.
    pub fn listConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_configurations.ListConfigurationsInput, options: CallOptions) !list_configurations.ListConfigurationsOutput {
        return list_configurations.execute(self, allocator, input, options);
    }

    /// Returns the available Quick Setup types.
    pub fn listQuickSetupTypes(self: *Self, allocator: std.mem.Allocator, input: list_quick_setup_types.ListQuickSetupTypesInput, options: CallOptions) !list_quick_setup_types.ListQuickSetupTypesOutput {
        return list_quick_setup_types.execute(self, allocator, input, options);
    }

    /// Returns tags assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Assigns key-value pairs of metadata to Amazon Web Services resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a Quick Setup configuration definition.
    pub fn updateConfigurationDefinition(self: *Self, allocator: std.mem.Allocator, input: update_configuration_definition.UpdateConfigurationDefinitionInput, options: CallOptions) !update_configuration_definition.UpdateConfigurationDefinitionOutput {
        return update_configuration_definition.execute(self, allocator, input, options);
    }

    /// Updates a Quick Setup configuration manager.
    pub fn updateConfigurationManager(self: *Self, allocator: std.mem.Allocator, input: update_configuration_manager.UpdateConfigurationManagerInput, options: CallOptions) !update_configuration_manager.UpdateConfigurationManagerOutput {
        return update_configuration_manager.execute(self, allocator, input, options);
    }

    /// Updates settings configured for Quick Setup.
    pub fn updateServiceSettings(self: *Self, allocator: std.mem.Allocator, input: update_service_settings.UpdateServiceSettingsInput, options: CallOptions) !update_service_settings.UpdateServiceSettingsOutput {
        return update_service_settings.execute(self, allocator, input, options);
    }

    pub fn listConfigurationManagersPaginator(self: *Self, params: list_configuration_managers.ListConfigurationManagersInput) paginator.ListConfigurationManagersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfigurationsPaginator(self: *Self, params: list_configurations.ListConfigurationsInput) paginator.ListConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
