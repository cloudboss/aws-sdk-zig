const aws = @import("aws");
const std = @import("std");

const add_group_member = @import("add_group_member.zig");
const create_group = @import("create_group.zig");
const create_user = @import("create_user.zig");
const delete_group = @import("delete_group.zig");
const delete_user = @import("delete_user.zig");
const describe_group = @import("describe_group.zig");
const describe_user = @import("describe_user.zig");
const disable_user = @import("disable_user.zig");
const list_group_members = @import("list_group_members.zig");
const list_groups = @import("list_groups.zig");
const list_groups_for_member = @import("list_groups_for_member.zig");
const list_users = @import("list_users.zig");
const remove_group_member = @import("remove_group_member.zig");
const search_groups = @import("search_groups.zig");
const search_users = @import("search_users.zig");
const update_group = @import("update_group.zig");
const update_user = @import("update_user.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Directory Service Data";

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

    /// Adds an existing user, group, or computer as a group member.
    pub fn addGroupMember(self: *Self, allocator: std.mem.Allocator, input: add_group_member.AddGroupMemberInput, options: add_group_member.Options) !add_group_member.AddGroupMemberOutput {
        return add_group_member.execute(self, allocator, input, options);
    }

    /// Creates a new group.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: create_group.Options) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates a new user.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes a group.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: delete_group.Options) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Deletes a user.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Returns information about a specific group.
    pub fn describeGroup(self: *Self, allocator: std.mem.Allocator, input: describe_group.DescribeGroupInput, options: describe_group.Options) !describe_group.DescribeGroupOutput {
        return describe_group.execute(self, allocator, input, options);
    }

    /// Returns information about a specific user.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: describe_user.Options) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Deactivates an active user account. For information about how to enable an
    /// inactive user
    /// account, see
    /// [ResetUserPassword](https://docs.aws.amazon.com/directoryservice/latest/devguide/API_ResetUserPassword.html)
    /// in the *Directory Service API Reference*.
    pub fn disableUser(self: *Self, allocator: std.mem.Allocator, input: disable_user.DisableUserInput, options: disable_user.Options) !disable_user.DisableUserOutput {
        return disable_user.execute(self, allocator, input, options);
    }

    /// Returns member information for the specified group.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `ListGroupMembers.NextToken` member contains a token that you pass in the
    /// next
    /// call to `ListGroupMembers`. This retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn listGroupMembers(self: *Self, allocator: std.mem.Allocator, input: list_group_members.ListGroupMembersInput, options: list_group_members.Options) !list_group_members.ListGroupMembersOutput {
        return list_group_members.execute(self, allocator, input, options);
    }

    /// Returns group information for the specified directory.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `ListGroups.NextToken`
    /// member contains a token that you pass in the next call to `ListGroups`. This
    /// retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: list_groups.Options) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Returns group information for the specified member.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `ListGroupsForMember.NextToken` member contains a token that you pass in the
    /// next
    /// call to `ListGroupsForMember`. This retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn listGroupsForMember(self: *Self, allocator: std.mem.Allocator, input: list_groups_for_member.ListGroupsForMemberInput, options: list_groups_for_member.Options) !list_groups_for_member.ListGroupsForMemberOutput {
        return list_groups_for_member.execute(self, allocator, input, options);
    }

    /// Returns user information for the specified directory.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `ListUsers.NextToken`
    /// member contains a token that you pass in the next call to `ListUsers`. This
    /// retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Removes a member from a group.
    pub fn removeGroupMember(self: *Self, allocator: std.mem.Allocator, input: remove_group_member.RemoveGroupMemberInput, options: remove_group_member.Options) !remove_group_member.RemoveGroupMemberOutput {
        return remove_group_member.execute(self, allocator, input, options);
    }

    /// Searches the specified directory for a group. You can find groups that match
    /// the
    /// `SearchString` parameter with the value of their attributes included in the
    /// `SearchString` parameter.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `SearchGroups.NextToken`
    /// member contains a token that you pass in the next call to `SearchGroups`.
    /// This
    /// retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn searchGroups(self: *Self, allocator: std.mem.Allocator, input: search_groups.SearchGroupsInput, options: search_groups.Options) !search_groups.SearchGroupsOutput {
        return search_groups.execute(self, allocator, input, options);
    }

    /// Searches the specified directory for a user. You can find users that match
    /// the
    /// `SearchString` parameter with the value of their attributes included in the
    /// `SearchString` parameter.
    ///
    /// This operation supports pagination with the use of the `NextToken` request
    /// and
    /// response parameters. If more results are available, the
    /// `SearchUsers.NextToken`
    /// member contains a token that you pass in the next call to `SearchUsers`.
    /// This
    /// retrieves the next set of items.
    ///
    /// You can also specify a maximum number of return results with the
    /// `MaxResults`
    /// parameter.
    pub fn searchUsers(self: *Self, allocator: std.mem.Allocator, input: search_users.SearchUsersInput, options: search_users.Options) !search_users.SearchUsersOutput {
        return search_users.execute(self, allocator, input, options);
    }

    /// Updates group information.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: update_group.Options) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates user information.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listGroupMembersPaginator(self: *Self, params: list_group_members.ListGroupMembersInput) paginator.ListGroupMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroupsForMemberPaginator(self: *Self, params: list_groups_for_member.ListGroupsForMemberInput) paginator.ListGroupsForMemberPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchGroupsPaginator(self: *Self, params: search_groups.SearchGroupsInput) paginator.SearchGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchUsersPaginator(self: *Self, params: search_users.SearchUsersInput) paginator.SearchUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
