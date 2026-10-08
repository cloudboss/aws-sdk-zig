const aws = @import("aws");
const std = @import("std");

const create_access_point = @import("create_access_point.zig");
const create_file_system = @import("create_file_system.zig");
const create_mount_target = @import("create_mount_target.zig");
const delete_access_point = @import("delete_access_point.zig");
const delete_file_system = @import("delete_file_system.zig");
const delete_file_system_policy = @import("delete_file_system_policy.zig");
const delete_mount_target = @import("delete_mount_target.zig");
const get_access_point = @import("get_access_point.zig");
const get_file_system = @import("get_file_system.zig");
const get_file_system_policy = @import("get_file_system_policy.zig");
const get_mount_target = @import("get_mount_target.zig");
const get_synchronization_configuration = @import("get_synchronization_configuration.zig");
const list_access_points = @import("list_access_points.zig");
const list_file_systems = @import("list_file_systems.zig");
const list_mount_targets = @import("list_mount_targets.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_file_system_policy = @import("put_file_system_policy.zig");
const put_synchronization_configuration = @import("put_synchronization_configuration.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_mount_target = @import("update_mount_target.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "S3Files";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Creates an S3 File System Access Point for application-specific access with
    /// POSIX user identity and root directory enforcement. Access points provide a
    /// way to manage access to shared datasets in multi-tenant scenarios.
    pub fn createAccessPoint(self: *Self, allocator: std.mem.Allocator, input: create_access_point.CreateAccessPointInput, options: CallOptions) !create_access_point.CreateAccessPointOutput {
        return create_access_point.execute(self, allocator, input, options);
    }

    /// Creates an S3 File System resource scoped to a bucket or prefix within a
    /// bucket, enabling file system access to S3 data. To create a file system, you
    /// need an S3 bucket and an IAM role that grants the service permission to
    /// access the bucket.
    pub fn createFileSystem(self: *Self, allocator: std.mem.Allocator, input: create_file_system.CreateFileSystemInput, options: CallOptions) !create_file_system.CreateFileSystemOutput {
        return create_file_system.execute(self, allocator, input, options);
    }

    /// Creates a mount target resource as an endpoint for mounting the S3 File
    /// System from compute resources in a specific Availability Zone and VPC. Mount
    /// targets provide network access to the file system.
    pub fn createMountTarget(self: *Self, allocator: std.mem.Allocator, input: create_mount_target.CreateMountTargetInput, options: CallOptions) !create_mount_target.CreateMountTargetOutput {
        return create_mount_target.execute(self, allocator, input, options);
    }

    /// Deletes an S3 File System Access Point. This operation is irreversible.
    pub fn deleteAccessPoint(self: *Self, allocator: std.mem.Allocator, input: delete_access_point.DeleteAccessPointInput, options: CallOptions) !delete_access_point.DeleteAccessPointOutput {
        return delete_access_point.execute(self, allocator, input, options);
    }

    /// Deletes an S3 File System. You can optionally force deletion of a file
    /// system that has pending export data.
    pub fn deleteFileSystem(self: *Self, allocator: std.mem.Allocator, input: delete_file_system.DeleteFileSystemInput, options: CallOptions) !delete_file_system.DeleteFileSystemOutput {
        return delete_file_system.execute(self, allocator, input, options);
    }

    /// Deletes the IAM resource policy of an S3 File System.
    pub fn deleteFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_file_system_policy.DeleteFileSystemPolicyInput, options: CallOptions) !delete_file_system_policy.DeleteFileSystemPolicyOutput {
        return delete_file_system_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified mount target. This operation is irreversible.
    pub fn deleteMountTarget(self: *Self, allocator: std.mem.Allocator, input: delete_mount_target.DeleteMountTargetInput, options: CallOptions) !delete_mount_target.DeleteMountTargetOutput {
        return delete_mount_target.execute(self, allocator, input, options);
    }

    /// Returns resource information for an S3 File System Access Point.
    pub fn getAccessPoint(self: *Self, allocator: std.mem.Allocator, input: get_access_point.GetAccessPointInput, options: CallOptions) !get_access_point.GetAccessPointOutput {
        return get_access_point.execute(self, allocator, input, options);
    }

    /// Returns resource information for the specified S3 File System including
    /// status, configuration, and metadata.
    pub fn getFileSystem(self: *Self, allocator: std.mem.Allocator, input: get_file_system.GetFileSystemInput, options: CallOptions) !get_file_system.GetFileSystemOutput {
        return get_file_system.execute(self, allocator, input, options);
    }

    /// Returns the IAM resource policy of an S3 File System.
    pub fn getFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: get_file_system_policy.GetFileSystemPolicyInput, options: CallOptions) !get_file_system_policy.GetFileSystemPolicyOutput {
        return get_file_system_policy.execute(self, allocator, input, options);
    }

    /// Returns detailed resource information for the specified mount target
    /// including network configuration.
    pub fn getMountTarget(self: *Self, allocator: std.mem.Allocator, input: get_mount_target.GetMountTargetInput, options: CallOptions) !get_mount_target.GetMountTargetOutput {
        return get_mount_target.execute(self, allocator, input, options);
    }

    /// Returns the synchronization configuration for the specified S3 File System,
    /// including import data rules and expiration data rules.
    pub fn getSynchronizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_synchronization_configuration.GetSynchronizationConfigurationInput, options: CallOptions) !get_synchronization_configuration.GetSynchronizationConfigurationOutput {
        return get_synchronization_configuration.execute(self, allocator, input, options);
    }

    /// Returns resource information for all S3 File System Access Points associated
    /// with the specified S3 File System.
    pub fn listAccessPoints(self: *Self, allocator: std.mem.Allocator, input: list_access_points.ListAccessPointsInput, options: CallOptions) !list_access_points.ListAccessPointsOutput {
        return list_access_points.execute(self, allocator, input, options);
    }

    /// Returns a list of all S3 File Systems owned by the account with optional
    /// filtering by bucket.
    pub fn listFileSystems(self: *Self, allocator: std.mem.Allocator, input: list_file_systems.ListFileSystemsInput, options: CallOptions) !list_file_systems.ListFileSystemsOutput {
        return list_file_systems.execute(self, allocator, input, options);
    }

    /// Returns resource information for all mount targets with optional filtering
    /// by file system, access point, and VPC.
    pub fn listMountTargets(self: *Self, allocator: std.mem.Allocator, input: list_mount_targets.ListMountTargetsInput, options: CallOptions) !list_mount_targets.ListMountTargetsOutput {
        return list_mount_targets.execute(self, allocator, input, options);
    }

    /// Lists all tags for S3 Files resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or replaces the IAM resource policy for an S3 File System to control
    /// access permissions.
    pub fn putFileSystemPolicy(self: *Self, allocator: std.mem.Allocator, input: put_file_system_policy.PutFileSystemPolicyInput, options: CallOptions) !put_file_system_policy.PutFileSystemPolicyOutput {
        return put_file_system_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates the synchronization configuration for the specified S3
    /// File System, including import data rules and expiration data rules.
    pub fn putSynchronizationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_synchronization_configuration.PutSynchronizationConfigurationInput, options: CallOptions) !put_synchronization_configuration.PutSynchronizationConfigurationOutput {
        return put_synchronization_configuration.execute(self, allocator, input, options);
    }

    /// Creates tags for S3 Files resources using standard Amazon Web Services
    /// tagging APIs.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from S3 Files resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the mount target resource, specifically security group
    /// configurations.
    pub fn updateMountTarget(self: *Self, allocator: std.mem.Allocator, input: update_mount_target.UpdateMountTargetInput, options: CallOptions) !update_mount_target.UpdateMountTargetOutput {
        return update_mount_target.execute(self, allocator, input, options);
    }

    pub fn listAccessPointsPaginator(self: *Self, params: list_access_points.ListAccessPointsInput) paginator.ListAccessPointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFileSystemsPaginator(self: *Self, params: list_file_systems.ListFileSystemsInput) paginator.ListFileSystemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMountTargetsPaginator(self: *Self, params: list_mount_targets.ListMountTargetsInput) paginator.ListMountTargetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
