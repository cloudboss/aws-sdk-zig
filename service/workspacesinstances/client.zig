const aws = @import("aws");
const std = @import("std");

const associate_volume = @import("associate_volume.zig");
const create_volume = @import("create_volume.zig");
const create_workspace_instance = @import("create_workspace_instance.zig");
const delete_volume = @import("delete_volume.zig");
const delete_workspace_instance = @import("delete_workspace_instance.zig");
const disassociate_volume = @import("disassociate_volume.zig");
const get_workspace_instance = @import("get_workspace_instance.zig");
const list_instance_types = @import("list_instance_types.zig");
const list_regions = @import("list_regions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workspace_instances = @import("list_workspace_instances.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Workspaces Instances";

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

    /// Attaches a volume to a WorkSpace Instance.
    pub fn associateVolume(self: *Self, allocator: std.mem.Allocator, input: associate_volume.AssociateVolumeInput, options: CallOptions) !associate_volume.AssociateVolumeOutput {
        return associate_volume.execute(self, allocator, input, options);
    }

    /// Creates a new volume for WorkSpace Instances.
    pub fn createVolume(self: *Self, allocator: std.mem.Allocator, input: create_volume.CreateVolumeInput, options: CallOptions) !create_volume.CreateVolumeOutput {
        return create_volume.execute(self, allocator, input, options);
    }

    /// Launches a new WorkSpace Instance with specified configuration parameters,
    /// enabling programmatic workspace deployment.
    pub fn createWorkspaceInstance(self: *Self, allocator: std.mem.Allocator, input: create_workspace_instance.CreateWorkspaceInstanceInput, options: CallOptions) !create_workspace_instance.CreateWorkspaceInstanceOutput {
        return create_workspace_instance.execute(self, allocator, input, options);
    }

    /// Deletes a specified volume.
    pub fn deleteVolume(self: *Self, allocator: std.mem.Allocator, input: delete_volume.DeleteVolumeInput, options: CallOptions) !delete_volume.DeleteVolumeOutput {
        return delete_volume.execute(self, allocator, input, options);
    }

    /// Deletes the specified WorkSpace
    ///
    /// Usage of this API will result in deletion of the resource in question.
    pub fn deleteWorkspaceInstance(self: *Self, allocator: std.mem.Allocator, input: delete_workspace_instance.DeleteWorkspaceInstanceInput, options: CallOptions) !delete_workspace_instance.DeleteWorkspaceInstanceOutput {
        return delete_workspace_instance.execute(self, allocator, input, options);
    }

    /// Detaches a volume from a WorkSpace Instance.
    pub fn disassociateVolume(self: *Self, allocator: std.mem.Allocator, input: disassociate_volume.DisassociateVolumeInput, options: CallOptions) !disassociate_volume.DisassociateVolumeOutput {
        return disassociate_volume.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific WorkSpace Instance.
    pub fn getWorkspaceInstance(self: *Self, allocator: std.mem.Allocator, input: get_workspace_instance.GetWorkspaceInstanceInput, options: CallOptions) !get_workspace_instance.GetWorkspaceInstanceOutput {
        return get_workspace_instance.execute(self, allocator, input, options);
    }

    /// Retrieves a list of instance types supported by Amazon WorkSpaces Instances,
    /// enabling precise workspace infrastructure configuration.
    pub fn listInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: list_instance_types.ListInstanceTypesInput, options: CallOptions) !list_instance_types.ListInstanceTypesOutput {
        return list_instance_types.execute(self, allocator, input, options);
    }

    /// Retrieves a list of AWS regions supported by Amazon WorkSpaces Instances,
    /// enabling region discovery for workspace deployments.
    pub fn listRegions(self: *Self, allocator: std.mem.Allocator, input: list_regions.ListRegionsInput, options: CallOptions) !list_regions.ListRegionsOutput {
        return list_regions.execute(self, allocator, input, options);
    }

    /// Retrieves tags for a WorkSpace Instance.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a collection of WorkSpaces Instances based on specified filters.
    pub fn listWorkspaceInstances(self: *Self, allocator: std.mem.Allocator, input: list_workspace_instances.ListWorkspaceInstancesInput, options: CallOptions) !list_workspace_instances.ListWorkspaceInstancesOutput {
        return list_workspace_instances.execute(self, allocator, input, options);
    }

    /// Adds tags to a WorkSpace Instance.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a WorkSpace Instance.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listInstanceTypesPaginator(self: *Self, params: list_instance_types.ListInstanceTypesInput) paginator.ListInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRegionsPaginator(self: *Self, params: list_regions.ListRegionsInput) paginator.ListRegionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspaceInstancesPaginator(self: *Self, params: list_workspace_instances.ListWorkspaceInstancesInput) paginator.ListWorkspaceInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
