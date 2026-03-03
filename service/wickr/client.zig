const aws = @import("aws");
const std = @import("std");

const batch_create_user = @import("batch_create_user.zig");
const batch_delete_user = @import("batch_delete_user.zig");
const batch_lookup_user_uname = @import("batch_lookup_user_uname.zig");
const batch_reinvite_user = @import("batch_reinvite_user.zig");
const batch_reset_devices_for_user = @import("batch_reset_devices_for_user.zig");
const batch_toggle_user_suspend_status = @import("batch_toggle_user_suspend_status.zig");
const create_bot = @import("create_bot.zig");
const create_data_retention_bot = @import("create_data_retention_bot.zig");
const create_data_retention_bot_challenge = @import("create_data_retention_bot_challenge.zig");
const create_network = @import("create_network.zig");
const create_security_group = @import("create_security_group.zig");
const delete_bot = @import("delete_bot.zig");
const delete_data_retention_bot = @import("delete_data_retention_bot.zig");
const delete_network = @import("delete_network.zig");
const delete_security_group = @import("delete_security_group.zig");
const get_bot = @import("get_bot.zig");
const get_bots_count = @import("get_bots_count.zig");
const get_data_retention_bot = @import("get_data_retention_bot.zig");
const get_guest_user_history_count = @import("get_guest_user_history_count.zig");
const get_network = @import("get_network.zig");
const get_network_settings = @import("get_network_settings.zig");
const get_oidc_info = @import("get_oidc_info.zig");
const get_security_group = @import("get_security_group.zig");
const get_user = @import("get_user.zig");
const get_users_count = @import("get_users_count.zig");
const list_blocked_guest_users = @import("list_blocked_guest_users.zig");
const list_bots = @import("list_bots.zig");
const list_devices_for_user = @import("list_devices_for_user.zig");
const list_guest_users = @import("list_guest_users.zig");
const list_networks = @import("list_networks.zig");
const list_security_group_users = @import("list_security_group_users.zig");
const list_security_groups = @import("list_security_groups.zig");
const list_users = @import("list_users.zig");
const register_oidc_config = @import("register_oidc_config.zig");
const register_oidc_config_test = @import("register_oidc_config_test.zig");
const update_bot = @import("update_bot.zig");
const update_data_retention = @import("update_data_retention.zig");
const update_guest_user = @import("update_guest_user.zig");
const update_network = @import("update_network.zig");
const update_network_settings = @import("update_network_settings.zig");
const update_security_group = @import("update_security_group.zig");
const update_user = @import("update_user.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Wickr";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates multiple users in a specified Wickr network. This operation allows
    /// you to provision multiple user accounts simultaneously, optionally
    /// specifying security groups, and validation requirements for each user.
    ///
    /// `codeValidation`, `inviteCode`, and `inviteCodeTtl` are restricted to
    /// networks under preview only.
    pub fn batchCreateUser(self: *Self, allocator: std.mem.Allocator, input: batch_create_user.BatchCreateUserInput, options: batch_create_user.Options) !batch_create_user.BatchCreateUserOutput {
        return batch_create_user.execute(self, allocator, input, options);
    }

    /// Deletes multiple users from a specified Wickr network. This operation
    /// permanently removes user accounts and their associated data from the
    /// network.
    pub fn batchDeleteUser(self: *Self, allocator: std.mem.Allocator, input: batch_delete_user.BatchDeleteUserInput, options: batch_delete_user.Options) !batch_delete_user.BatchDeleteUserOutput {
        return batch_delete_user.execute(self, allocator, input, options);
    }

    /// Looks up multiple user usernames from their unique username hashes (unames).
    /// This operation allows you to retrieve the email addresses associated with a
    /// list of username hashes.
    pub fn batchLookupUserUname(self: *Self, allocator: std.mem.Allocator, input: batch_lookup_user_uname.BatchLookupUserUnameInput, options: batch_lookup_user_uname.Options) !batch_lookup_user_uname.BatchLookupUserUnameOutput {
        return batch_lookup_user_uname.execute(self, allocator, input, options);
    }

    /// Resends invitation codes to multiple users who have pending invitations in a
    /// Wickr network. This operation is useful when users haven't accepted their
    /// initial invitations or when invitations have expired.
    pub fn batchReinviteUser(self: *Self, allocator: std.mem.Allocator, input: batch_reinvite_user.BatchReinviteUserInput, options: batch_reinvite_user.Options) !batch_reinvite_user.BatchReinviteUserOutput {
        return batch_reinvite_user.execute(self, allocator, input, options);
    }

    /// Resets multiple devices for a specific user in a Wickr network. This
    /// operation forces the selected devices to log out and requires users to
    /// re-authenticate, which is useful for security purposes or when devices need
    /// to be revoked.
    pub fn batchResetDevicesForUser(self: *Self, allocator: std.mem.Allocator, input: batch_reset_devices_for_user.BatchResetDevicesForUserInput, options: batch_reset_devices_for_user.Options) !batch_reset_devices_for_user.BatchResetDevicesForUserOutput {
        return batch_reset_devices_for_user.execute(self, allocator, input, options);
    }

    /// Suspends or unsuspends multiple users in a Wickr network. Suspended users
    /// cannot access the network until they are unsuspended. This operation is
    /// useful for temporarily restricting access without deleting user accounts.
    pub fn batchToggleUserSuspendStatus(self: *Self, allocator: std.mem.Allocator, input: batch_toggle_user_suspend_status.BatchToggleUserSuspendStatusInput, options: batch_toggle_user_suspend_status.Options) !batch_toggle_user_suspend_status.BatchToggleUserSuspendStatusOutput {
        return batch_toggle_user_suspend_status.execute(self, allocator, input, options);
    }

    /// Creates a new bot in a specified Wickr network. Bots are automated accounts
    /// that can send and receive messages, enabling integration with external
    /// systems and automation of tasks.
    pub fn createBot(self: *Self, allocator: std.mem.Allocator, input: create_bot.CreateBotInput, options: create_bot.Options) !create_bot.CreateBotOutput {
        return create_bot.execute(self, allocator, input, options);
    }

    /// Creates a data retention bot in a Wickr network. Data retention bots are
    /// specialized bots that handle message archiving and compliance by capturing
    /// and storing messages for regulatory or organizational requirements.
    pub fn createDataRetentionBot(self: *Self, allocator: std.mem.Allocator, input: create_data_retention_bot.CreateDataRetentionBotInput, options: create_data_retention_bot.Options) !create_data_retention_bot.CreateDataRetentionBotOutput {
        return create_data_retention_bot.execute(self, allocator, input, options);
    }

    /// Creates a new challenge password for the data retention bot. This password
    /// is used for authentication when the bot connects to the network.
    pub fn createDataRetentionBotChallenge(self: *Self, allocator: std.mem.Allocator, input: create_data_retention_bot_challenge.CreateDataRetentionBotChallengeInput, options: create_data_retention_bot_challenge.Options) !create_data_retention_bot_challenge.CreateDataRetentionBotChallengeOutput {
        return create_data_retention_bot_challenge.execute(self, allocator, input, options);
    }

    /// Creates a new Wickr network with specified access level and configuration.
    /// This operation provisions a new communication network for your organization.
    pub fn createNetwork(self: *Self, allocator: std.mem.Allocator, input: create_network.CreateNetworkInput, options: create_network.Options) !create_network.CreateNetworkOutput {
        return create_network.execute(self, allocator, input, options);
    }

    /// Creates a new security group in a Wickr network. Security groups allow you
    /// to organize users and control their permissions, features, and security
    /// settings.
    pub fn createSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_security_group.CreateSecurityGroupInput, options: create_security_group.Options) !create_security_group.CreateSecurityGroupOutput {
        return create_security_group.execute(self, allocator, input, options);
    }

    /// Deletes a bot from a specified Wickr network. This operation permanently
    /// removes the bot account and its associated data from the network.
    pub fn deleteBot(self: *Self, allocator: std.mem.Allocator, input: delete_bot.DeleteBotInput, options: delete_bot.Options) !delete_bot.DeleteBotOutput {
        return delete_bot.execute(self, allocator, input, options);
    }

    /// Deletes the data retention bot from a Wickr network. This operation
    /// permanently removes the bot and all its associated data from the database.
    pub fn deleteDataRetentionBot(self: *Self, allocator: std.mem.Allocator, input: delete_data_retention_bot.DeleteDataRetentionBotInput, options: delete_data_retention_bot.Options) !delete_data_retention_bot.DeleteDataRetentionBotOutput {
        return delete_data_retention_bot.execute(self, allocator, input, options);
    }

    /// Deletes a Wickr network and all its associated resources, including users,
    /// bots, security groups, and settings. This operation is permanent and cannot
    /// be undone.
    pub fn deleteNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_network.DeleteNetworkInput, options: delete_network.Options) !delete_network.DeleteNetworkOutput {
        return delete_network.execute(self, allocator, input, options);
    }

    /// Deletes a security group from a Wickr network. This operation cannot be
    /// performed on the default security group.
    pub fn deleteSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_security_group.DeleteSecurityGroupInput, options: delete_security_group.Options) !delete_security_group.DeleteSecurityGroupOutput {
        return delete_security_group.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific bot in a Wickr network,
    /// including its status, group membership, and authentication details.
    pub fn getBot(self: *Self, allocator: std.mem.Allocator, input: get_bot.GetBotInput, options: get_bot.Options) !get_bot.GetBotOutput {
        return get_bot.execute(self, allocator, input, options);
    }

    /// Retrieves the count of bots in a Wickr network, categorized by their status
    /// (pending, active, and total).
    pub fn getBotsCount(self: *Self, allocator: std.mem.Allocator, input: get_bots_count.GetBotsCountInput, options: get_bots_count.Options) !get_bots_count.GetBotsCountOutput {
        return get_bots_count.execute(self, allocator, input, options);
    }

    /// Retrieves information about the data retention bot in a Wickr network,
    /// including its status and whether the data retention service is enabled.
    pub fn getDataRetentionBot(self: *Self, allocator: std.mem.Allocator, input: get_data_retention_bot.GetDataRetentionBotInput, options: get_data_retention_bot.Options) !get_data_retention_bot.GetDataRetentionBotOutput {
        return get_data_retention_bot.execute(self, allocator, input, options);
    }

    /// Retrieves historical guest user count data for a Wickr network, showing the
    /// number of guest users per billing period over the past 90 days.
    pub fn getGuestUserHistoryCount(self: *Self, allocator: std.mem.Allocator, input: get_guest_user_history_count.GetGuestUserHistoryCountInput, options: get_guest_user_history_count.Options) !get_guest_user_history_count.GetGuestUserHistoryCountOutput {
        return get_guest_user_history_count.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific Wickr network, including its
    /// configuration, access level, and status.
    pub fn getNetwork(self: *Self, allocator: std.mem.Allocator, input: get_network.GetNetworkInput, options: get_network.Options) !get_network.GetNetworkOutput {
        return get_network.execute(self, allocator, input, options);
    }

    /// Retrieves all network-level settings for a Wickr network, including client
    /// metrics, data retention, and other configuration options.
    pub fn getNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: get_network_settings.GetNetworkSettingsInput, options: get_network_settings.Options) !get_network_settings.GetNetworkSettingsOutput {
        return get_network_settings.execute(self, allocator, input, options);
    }

    /// Retrieves the OpenID Connect (OIDC) configuration for a Wickr network,
    /// including SSO settings and optional token information if access token
    /// parameters are provided.
    pub fn getOidcInfo(self: *Self, allocator: std.mem.Allocator, input: get_oidc_info.GetOidcInfoInput, options: get_oidc_info.Options) !get_oidc_info.GetOidcInfoOutput {
        return get_oidc_info.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific security group in a Wickr
    /// network, including its settings, member counts, and configuration.
    pub fn getSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: get_security_group.GetSecurityGroupInput, options: get_security_group.Options) !get_security_group.GetSecurityGroupOutput {
        return get_security_group.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific user in a Wickr network,
    /// including their profile, status, and activity history.
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: get_user.Options) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// Retrieves the count of users in a Wickr network, categorized by their status
    /// (pending, active, rejected) and showing how many users can still be added.
    pub fn getUsersCount(self: *Self, allocator: std.mem.Allocator, input: get_users_count.GetUsersCountInput, options: get_users_count.Options) !get_users_count.GetUsersCountOutput {
        return get_users_count.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of guest users who have been blocked from a Wickr
    /// network. You can filter and sort the results.
    pub fn listBlockedGuestUsers(self: *Self, allocator: std.mem.Allocator, input: list_blocked_guest_users.ListBlockedGuestUsersInput, options: list_blocked_guest_users.Options) !list_blocked_guest_users.ListBlockedGuestUsersOutput {
        return list_blocked_guest_users.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of bots in a specified Wickr network. You can
    /// filter and sort the results based on various criteria.
    pub fn listBots(self: *Self, allocator: std.mem.Allocator, input: list_bots.ListBotsInput, options: list_bots.Options) !list_bots.ListBotsOutput {
        return list_bots.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of devices associated with a specific user in a
    /// Wickr network. This operation returns information about all devices where
    /// the user has logged into Wickr.
    pub fn listDevicesForUser(self: *Self, allocator: std.mem.Allocator, input: list_devices_for_user.ListDevicesForUserInput, options: list_devices_for_user.Options) !list_devices_for_user.ListDevicesForUserOutput {
        return list_devices_for_user.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of guest users who have communicated with your
    /// Wickr network. Guest users are external users from federated networks who
    /// can communicate with network members.
    pub fn listGuestUsers(self: *Self, allocator: std.mem.Allocator, input: list_guest_users.ListGuestUsersInput, options: list_guest_users.Options) !list_guest_users.ListGuestUsersOutput {
        return list_guest_users.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of all Wickr networks associated with your Amazon
    /// Web Services account. You can sort the results by network ID or name.
    pub fn listNetworks(self: *Self, allocator: std.mem.Allocator, input: list_networks.ListNetworksInput, options: list_networks.Options) !list_networks.ListNetworksOutput {
        return list_networks.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of users who belong to a specific security group
    /// in a Wickr network.
    pub fn listSecurityGroupUsers(self: *Self, allocator: std.mem.Allocator, input: list_security_group_users.ListSecurityGroupUsersInput, options: list_security_group_users.Options) !list_security_group_users.ListSecurityGroupUsersOutput {
        return list_security_group_users.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of security groups in a specified Wickr network.
    /// You can sort the results by various criteria.
    pub fn listSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: list_security_groups.ListSecurityGroupsInput, options: list_security_groups.Options) !list_security_groups.ListSecurityGroupsOutput {
        return list_security_groups.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of users in a specified Wickr network. You can
    /// filter and sort the results based on various criteria such as name, status,
    /// or security group membership.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Registers and saves an OpenID Connect (OIDC) configuration for a Wickr
    /// network, enabling Single Sign-On (SSO) authentication through an identity
    /// provider.
    pub fn registerOidcConfig(self: *Self, allocator: std.mem.Allocator, input: register_oidc_config.RegisterOidcConfigInput, options: register_oidc_config.Options) !register_oidc_config.RegisterOidcConfigOutput {
        return register_oidc_config.execute(self, allocator, input, options);
    }

    /// Tests an OpenID Connect (OIDC) configuration for a Wickr network by
    /// validating the connection to the identity provider and retrieving its
    /// supported capabilities.
    pub fn registerOidcConfigTest(self: *Self, allocator: std.mem.Allocator, input: register_oidc_config_test.RegisterOidcConfigTestInput, options: register_oidc_config_test.Options) !register_oidc_config_test.RegisterOidcConfigTestOutput {
        return register_oidc_config_test.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing bot in a Wickr network. This operation
    /// allows you to modify the bot's display name, security group, password, or
    /// suspension status.
    pub fn updateBot(self: *Self, allocator: std.mem.Allocator, input: update_bot.UpdateBotInput, options: update_bot.Options) !update_bot.UpdateBotOutput {
        return update_bot.execute(self, allocator, input, options);
    }

    /// Updates the data retention bot settings, allowing you to enable or disable
    /// the data retention service, or acknowledge the public key message.
    pub fn updateDataRetention(self: *Self, allocator: std.mem.Allocator, input: update_data_retention.UpdateDataRetentionInput, options: update_data_retention.Options) !update_data_retention.UpdateDataRetentionOutput {
        return update_data_retention.execute(self, allocator, input, options);
    }

    /// Updates the block status of a guest user in a Wickr network. This operation
    /// allows you to block or unblock a guest user from accessing the network.
    pub fn updateGuestUser(self: *Self, allocator: std.mem.Allocator, input: update_guest_user.UpdateGuestUserInput, options: update_guest_user.Options) !update_guest_user.UpdateGuestUserOutput {
        return update_guest_user.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing Wickr network, such as its name or
    /// encryption key configuration.
    pub fn updateNetwork(self: *Self, allocator: std.mem.Allocator, input: update_network.UpdateNetworkInput, options: update_network.Options) !update_network.UpdateNetworkOutput {
        return update_network.execute(self, allocator, input, options);
    }

    /// Updates network-level settings for a Wickr network. You can modify settings
    /// such as client metrics, data retention, and other network-wide options.
    pub fn updateNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: update_network_settings.UpdateNetworkSettingsInput, options: update_network_settings.Options) !update_network_settings.UpdateNetworkSettingsOutput {
        return update_network_settings.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing security group in a Wickr network,
    /// such as its name or settings.
    pub fn updateSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: update_security_group.UpdateSecurityGroupInput, options: update_security_group.Options) !update_security_group.UpdateSecurityGroupOutput {
        return update_security_group.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing user in a Wickr network. This
    /// operation allows you to modify the user's name, password, security group
    /// membership, and invite code settings.
    ///
    /// `codeValidation`, `inviteCode`, and `inviteCodeTtl` are restricted to
    /// networks under preview only.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listBlockedGuestUsersPaginator(self: *Self, params: list_blocked_guest_users.ListBlockedGuestUsersInput) paginator.ListBlockedGuestUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBotsPaginator(self: *Self, params: list_bots.ListBotsInput) paginator.ListBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesForUserPaginator(self: *Self, params: list_devices_for_user.ListDevicesForUserInput) paginator.ListDevicesForUserPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGuestUsersPaginator(self: *Self, params: list_guest_users.ListGuestUsersInput) paginator.ListGuestUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNetworksPaginator(self: *Self, params: list_networks.ListNetworksInput) paginator.ListNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityGroupUsersPaginator(self: *Self, params: list_security_group_users.ListSecurityGroupUsersInput) paginator.ListSecurityGroupUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityGroupsPaginator(self: *Self, params: list_security_groups.ListSecurityGroupsInput) paginator.ListSecurityGroupsPaginator {
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
};
