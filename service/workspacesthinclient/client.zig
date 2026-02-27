const aws = @import("aws");
const std = @import("std");

const create_environment = @import("create_environment.zig");
const delete_device = @import("delete_device.zig");
const delete_environment = @import("delete_environment.zig");
const deregister_device = @import("deregister_device.zig");
const get_device = @import("get_device.zig");
const get_environment = @import("get_environment.zig");
const get_software_set = @import("get_software_set.zig");
const list_devices = @import("list_devices.zig");
const list_environments = @import("list_environments.zig");
const list_software_sets = @import("list_software_sets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_device = @import("update_device.zig");
const update_environment = @import("update_environment.zig");
const update_software_set = @import("update_software_set.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkSpaces Thin Client";

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

    /// Creates an environment for your thin client devices.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Deletes a thin client device.
    pub fn deleteDevice(self: *Self, allocator: std.mem.Allocator, input: delete_device.DeleteDeviceInput, options: delete_device.Options) !delete_device.DeleteDeviceOutput {
        return delete_device.execute(self, allocator, input, options);
    }

    /// Deletes an environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deregisters a thin client device.
    pub fn deregisterDevice(self: *Self, allocator: std.mem.Allocator, input: deregister_device.DeregisterDeviceInput, options: deregister_device.Options) !deregister_device.DeregisterDeviceOutput {
        return deregister_device.execute(self, allocator, input, options);
    }

    /// Returns information for a thin client device.
    pub fn getDevice(self: *Self, allocator: std.mem.Allocator, input: get_device.GetDeviceInput, options: get_device.Options) !get_device.GetDeviceOutput {
        return get_device.execute(self, allocator, input, options);
    }

    /// Returns information for an environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: get_environment.Options) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Returns information for a software set.
    pub fn getSoftwareSet(self: *Self, allocator: std.mem.Allocator, input: get_software_set.GetSoftwareSetInput, options: get_software_set.Options) !get_software_set.GetSoftwareSetOutput {
        return get_software_set.execute(self, allocator, input, options);
    }

    /// Returns a list of thin client devices.
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: list_devices.Options) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Returns a list of environments.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Returns a list of software sets.
    pub fn listSoftwareSets(self: *Self, allocator: std.mem.Allocator, input: list_software_sets.ListSoftwareSetsInput, options: list_software_sets.Options) !list_software_sets.ListSoftwareSetsOutput {
        return list_software_sets.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a thin client device.
    pub fn updateDevice(self: *Self, allocator: std.mem.Allocator, input: update_device.UpdateDeviceInput, options: update_device.Options) !update_device.UpdateDeviceOutput {
        return update_device.execute(self, allocator, input, options);
    }

    /// Updates an environment.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    /// Updates a software set.
    pub fn updateSoftwareSet(self: *Self, allocator: std.mem.Allocator, input: update_software_set.UpdateSoftwareSetInput, options: update_software_set.Options) !update_software_set.UpdateSoftwareSetOutput {
        return update_software_set.execute(self, allocator, input, options);
    }

    pub fn listDevicesPaginator(self: *Self, params: list_devices.ListDevicesInput) paginator.ListDevicesPaginator {
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

    pub fn listSoftwareSetsPaginator(self: *Self, params: list_software_sets.ListSoftwareSetsInput) paginator.ListSoftwareSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
