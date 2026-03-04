const aws = @import("aws");
const std = @import("std");

const batch_add_channel_role_to_accessors = @import("batch_add_channel_role_to_accessors.zig");
const batch_add_role = @import("batch_add_role.zig");
const batch_remove_channel_role_from_accessors = @import("batch_remove_channel_role_from_accessors.zig");
const batch_remove_role = @import("batch_remove_role.zig");
const create_channel = @import("create_channel.zig");
const create_space = @import("create_space.zig");
const delete_space = @import("delete_space.zig");
const deregister_admin = @import("deregister_admin.zig");
const get_channel = @import("get_channel.zig");
const get_space = @import("get_space.zig");
const list_channels = @import("list_channels.zig");
const list_spaces = @import("list_spaces.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_admin = @import("register_admin.zig");
const send_invites = @import("send_invites.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_space = @import("update_space.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "repostspace";

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

    /// Add role to multiple users or groups in a private re:Post channel.
    pub fn batchAddChannelRoleToAccessors(self: *Self, allocator: std.mem.Allocator, input: batch_add_channel_role_to_accessors.BatchAddChannelRoleToAccessorsInput, options: CallOptions) !batch_add_channel_role_to_accessors.BatchAddChannelRoleToAccessorsOutput {
        return batch_add_channel_role_to_accessors.execute(self, allocator, input, options);
    }

    /// Add a role to multiple users or groups in a private re:Post.
    pub fn batchAddRole(self: *Self, allocator: std.mem.Allocator, input: batch_add_role.BatchAddRoleInput, options: CallOptions) !batch_add_role.BatchAddRoleOutput {
        return batch_add_role.execute(self, allocator, input, options);
    }

    /// Remove a role from multiple users or groups in a private re:Post channel.
    pub fn batchRemoveChannelRoleFromAccessors(self: *Self, allocator: std.mem.Allocator, input: batch_remove_channel_role_from_accessors.BatchRemoveChannelRoleFromAccessorsInput, options: CallOptions) !batch_remove_channel_role_from_accessors.BatchRemoveChannelRoleFromAccessorsOutput {
        return batch_remove_channel_role_from_accessors.execute(self, allocator, input, options);
    }

    /// Remove a role from multiple users or groups in a private re:Post.
    pub fn batchRemoveRole(self: *Self, allocator: std.mem.Allocator, input: batch_remove_role.BatchRemoveRoleInput, options: CallOptions) !batch_remove_role.BatchRemoveRoleOutput {
        return batch_remove_role.execute(self, allocator, input, options);
    }

    /// Creates a channel in an AWS re:Post Private private re:Post.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: CallOptions) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Creates an AWS re:Post Private private re:Post.
    pub fn createSpace(self: *Self, allocator: std.mem.Allocator, input: create_space.CreateSpaceInput, options: CallOptions) !create_space.CreateSpaceOutput {
        return create_space.execute(self, allocator, input, options);
    }

    /// Deletes an AWS re:Post Private private re:Post.
    pub fn deleteSpace(self: *Self, allocator: std.mem.Allocator, input: delete_space.DeleteSpaceInput, options: CallOptions) !delete_space.DeleteSpaceOutput {
        return delete_space.execute(self, allocator, input, options);
    }

    /// Removes the user or group from the list of administrators of the private
    /// re:Post.
    pub fn deregisterAdmin(self: *Self, allocator: std.mem.Allocator, input: deregister_admin.DeregisterAdminInput, options: CallOptions) !deregister_admin.DeregisterAdminOutput {
        return deregister_admin.execute(self, allocator, input, options);
    }

    /// Displays information about a channel in a private re:Post.
    pub fn getChannel(self: *Self, allocator: std.mem.Allocator, input: get_channel.GetChannelInput, options: CallOptions) !get_channel.GetChannelOutput {
        return get_channel.execute(self, allocator, input, options);
    }

    /// Displays information about the AWS re:Post Private private re:Post.
    pub fn getSpace(self: *Self, allocator: std.mem.Allocator, input: get_space.GetSpaceInput, options: CallOptions) !get_space.GetSpaceOutput {
        return get_space.execute(self, allocator, input, options);
    }

    /// Returns the list of channel within a private re:Post with some information
    /// about each channel.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: CallOptions) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Returns a list of AWS re:Post Private private re:Posts in the account with
    /// some information about each private re:Post.
    pub fn listSpaces(self: *Self, allocator: std.mem.Allocator, input: list_spaces.ListSpacesInput, options: CallOptions) !list_spaces.ListSpacesOutput {
        return list_spaces.execute(self, allocator, input, options);
    }

    /// Returns the tags that are associated with the AWS re:Post Private resource
    /// specified by the resourceArn. The only resource that can be tagged is a
    /// private re:Post.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds a user or group to the list of administrators of the private re:Post.
    pub fn registerAdmin(self: *Self, allocator: std.mem.Allocator, input: register_admin.RegisterAdminInput, options: CallOptions) !register_admin.RegisterAdminOutput {
        return register_admin.execute(self, allocator, input, options);
    }

    /// Sends an invitation email to selected users and groups.
    pub fn sendInvites(self: *Self, allocator: std.mem.Allocator, input: send_invites.SendInvitesInput, options: CallOptions) !send_invites.SendInvitesOutput {
        return send_invites.execute(self, allocator, input, options);
    }

    /// Associates tags with an AWS re:Post Private resource. Currently, the only
    /// resource that can be tagged is the private re:Post. If you specify a new tag
    /// key for the resource, the tag is appended to the list of tags that are
    /// associated with the resource. If you specify a tag key that’s already
    /// associated with the resource, the new tag value that you specify replaces
    /// the previous value for that tag.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of the tag with the AWS re:Post Private resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies an existing channel.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: CallOptions) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Modifies an existing AWS re:Post Private private re:Post.
    pub fn updateSpace(self: *Self, allocator: std.mem.Allocator, input: update_space.UpdateSpaceInput, options: CallOptions) !update_space.UpdateSpaceOutput {
        return update_space.execute(self, allocator, input, options);
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSpacesPaginator(self: *Self, params: list_spaces.ListSpacesInput) paginator.ListSpacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilChannelCreated(self: *Self, params: get_channel.GetChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelDeleted(self: *Self, params: get_channel.GetChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSpaceCreated(self: *Self, params: get_space.GetSpaceInput) aws.waiter.WaiterError!void {
        var w = waiters.SpaceCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSpaceDeleted(self: *Self, params: get_space.GetSpaceInput) aws.waiter.WaiterError!void {
        var w = waiters.SpaceDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
