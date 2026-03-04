const aws = @import("aws");
const std = @import("std");

const create_group = @import("create_group.zig");
const create_group_membership = @import("create_group_membership.zig");
const create_user = @import("create_user.zig");
const delete_group = @import("delete_group.zig");
const delete_group_membership = @import("delete_group_membership.zig");
const delete_user = @import("delete_user.zig");
const describe_group = @import("describe_group.zig");
const describe_group_membership = @import("describe_group_membership.zig");
const describe_user = @import("describe_user.zig");
const get_group_id = @import("get_group_id.zig");
const get_group_membership_id = @import("get_group_membership_id.zig");
const get_user_id = @import("get_user_id.zig");
const is_member_in_groups = @import("is_member_in_groups.zig");
const list_group_memberships = @import("list_group_memberships.zig");
const list_group_memberships_for_member = @import("list_group_memberships_for_member.zig");
const list_groups = @import("list_groups.zig");
const list_users = @import("list_users.zig");
const update_group = @import("update_group.zig");
const update_user = @import("update_user.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "identitystore";

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

    /// Creates a group within the specified identity store.
    pub fn createGroup(self: *Self, allocator: std.mem.Allocator, input: create_group.CreateGroupInput, options: CallOptions) !create_group.CreateGroupOutput {
        return create_group.execute(self, allocator, input, options);
    }

    /// Creates a relationship between a member and a group. The following
    /// identifiers must be specified: `GroupId`, `IdentityStoreId`, and `MemberId`.
    pub fn createGroupMembership(self: *Self, allocator: std.mem.Allocator, input: create_group_membership.CreateGroupMembershipInput, options: CallOptions) !create_group_membership.CreateGroupMembershipOutput {
        return create_group_membership.execute(self, allocator, input, options);
    }

    /// Creates a user within the specified identity store.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: CallOptions) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Delete a group within an identity store given `GroupId`.
    pub fn deleteGroup(self: *Self, allocator: std.mem.Allocator, input: delete_group.DeleteGroupInput, options: CallOptions) !delete_group.DeleteGroupOutput {
        return delete_group.execute(self, allocator, input, options);
    }

    /// Delete a membership within a group given `MembershipId`.
    pub fn deleteGroupMembership(self: *Self, allocator: std.mem.Allocator, input: delete_group_membership.DeleteGroupMembershipInput, options: CallOptions) !delete_group_membership.DeleteGroupMembershipOutput {
        return delete_group_membership.execute(self, allocator, input, options);
    }

    /// Deletes a user within an identity store given `UserId`.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: CallOptions) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Retrieves the group metadata and attributes from `GroupId` in an identity
    /// store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn describeGroup(self: *Self, allocator: std.mem.Allocator, input: describe_group.DescribeGroupInput, options: CallOptions) !describe_group.DescribeGroupOutput {
        return describe_group.execute(self, allocator, input, options);
    }

    /// Retrieves membership metadata and attributes from `MembershipId` in an
    /// identity store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn describeGroupMembership(self: *Self, allocator: std.mem.Allocator, input: describe_group_membership.DescribeGroupMembershipInput, options: CallOptions) !describe_group_membership.DescribeGroupMembershipOutput {
        return describe_group_membership.execute(self, allocator, input, options);
    }

    /// Retrieves the user metadata and attributes from the `UserId` in an identity
    /// store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: CallOptions) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Retrieves `GroupId` in an identity store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn getGroupId(self: *Self, allocator: std.mem.Allocator, input: get_group_id.GetGroupIdInput, options: CallOptions) !get_group_id.GetGroupIdOutput {
        return get_group_id.execute(self, allocator, input, options);
    }

    /// Retrieves the `MembershipId` in an identity store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn getGroupMembershipId(self: *Self, allocator: std.mem.Allocator, input: get_group_membership_id.GetGroupMembershipIdInput, options: CallOptions) !get_group_membership_id.GetGroupMembershipIdOutput {
        return get_group_membership_id.execute(self, allocator, input, options);
    }

    /// Retrieves the `UserId` in an identity store.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn getUserId(self: *Self, allocator: std.mem.Allocator, input: get_user_id.GetUserIdInput, options: CallOptions) !get_user_id.GetUserIdOutput {
        return get_user_id.execute(self, allocator, input, options);
    }

    /// Checks the user's membership in all requested groups and returns if the
    /// member exists in all queried groups.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn isMemberInGroups(self: *Self, allocator: std.mem.Allocator, input: is_member_in_groups.IsMemberInGroupsInput, options: CallOptions) !is_member_in_groups.IsMemberInGroupsOutput {
        return is_member_in_groups.execute(self, allocator, input, options);
    }

    /// For the specified group in the specified identity store, returns the list of
    /// all ` GroupMembership` objects and returns results in paginated form.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn listGroupMemberships(self: *Self, allocator: std.mem.Allocator, input: list_group_memberships.ListGroupMembershipsInput, options: CallOptions) !list_group_memberships.ListGroupMembershipsOutput {
        return list_group_memberships.execute(self, allocator, input, options);
    }

    /// For the specified member in the specified identity store, returns the list
    /// of all ` GroupMembership` objects and returns results in paginated form.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn listGroupMembershipsForMember(self: *Self, allocator: std.mem.Allocator, input: list_group_memberships_for_member.ListGroupMembershipsForMemberInput, options: CallOptions) !list_group_memberships_for_member.ListGroupMembershipsForMemberOutput {
        return list_group_memberships_for_member.execute(self, allocator, input, options);
    }

    /// Lists all groups in the identity store. Returns a paginated list of complete
    /// `Group` objects. Filtering for a `Group` by the `DisplayName` attribute is
    /// deprecated. Instead, use the `GetGroupId` API action.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn listGroups(self: *Self, allocator: std.mem.Allocator, input: list_groups.ListGroupsInput, options: CallOptions) !list_groups.ListGroupsOutput {
        return list_groups.execute(self, allocator, input, options);
    }

    /// Lists all users in the identity store. Returns a paginated list of complete
    /// `User` objects. Filtering for a `User` by the `UserName` attribute is
    /// deprecated. Instead, use the `GetUserId` API action.
    ///
    /// If you have access to a member account, you can use this API operation from
    /// the member account. For more information, see [Limiting access to the
    /// identity store from member
    /// accounts](https://docs.aws.amazon.com/singlesignon/latest/userguide/manage-your-accounts.html#limiting-access-from-member-accounts) in the * IAM Identity Center User Guide*.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: CallOptions) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Updates the specified group metadata and attributes in the specified
    /// identity store.
    pub fn updateGroup(self: *Self, allocator: std.mem.Allocator, input: update_group.UpdateGroupInput, options: CallOptions) !update_group.UpdateGroupOutput {
        return update_group.execute(self, allocator, input, options);
    }

    /// Updates the specified user metadata and attributes in the specified identity
    /// store.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: CallOptions) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listGroupMembershipsPaginator(self: *Self, params: list_group_memberships.ListGroupMembershipsInput) paginator.ListGroupMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGroupMembershipsForMemberPaginator(self: *Self, params: list_group_memberships_for_member.ListGroupMembershipsForMemberInput) paginator.ListGroupMembershipsForMemberPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGroupsPaginator(self: *Self, params: list_groups.ListGroupsInput) paginator.ListGroupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
