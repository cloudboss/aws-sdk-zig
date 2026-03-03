const aws = @import("aws");
const std = @import("std");

const create_slack_channel_configuration = @import("create_slack_channel_configuration.zig");
const delete_account_alias = @import("delete_account_alias.zig");
const delete_slack_channel_configuration = @import("delete_slack_channel_configuration.zig");
const delete_slack_workspace_configuration = @import("delete_slack_workspace_configuration.zig");
const get_account_alias = @import("get_account_alias.zig");
const list_slack_channel_configurations = @import("list_slack_channel_configurations.zig");
const list_slack_workspace_configurations = @import("list_slack_workspace_configurations.zig");
const put_account_alias = @import("put_account_alias.zig");
const register_slack_workspace_for_organization = @import("register_slack_workspace_for_organization.zig");
const update_slack_channel_configuration = @import("update_slack_channel_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Support App";

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

    /// Creates a Slack channel configuration for your Amazon Web Services account.
    ///
    /// * You can add up to 5 Slack workspaces for your account.
    ///
    /// * You can add up to 20 Slack channels for your account.
    ///
    /// A Slack channel can have up to 100 Amazon Web Services accounts. This means
    /// that only 100 accounts can
    /// add the same Slack channel to the Amazon Web Services Support App. We
    /// recommend that you only add the accounts that
    /// you need to manage support cases for your organization. This can reduce the
    /// notifications
    /// about case updates that you receive in the Slack channel.
    ///
    /// We recommend that you choose a private Slack channel so that only members in
    /// that
    /// channel have read and write access to your support cases. Anyone in your
    /// Slack channel can
    /// create, update, or resolve support cases for your account. Users require an
    /// invitation to
    /// join private channels.
    pub fn createSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_slack_channel_configuration.CreateSlackChannelConfigurationInput, options: create_slack_channel_configuration.Options) !create_slack_channel_configuration.CreateSlackChannelConfigurationOutput {
        return create_slack_channel_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an alias for an Amazon Web Services account ID. The alias appears in
    /// the Amazon Web Services Support App page of the
    /// Amazon Web Services Support Center. The alias also appears in Slack messages
    /// from the Amazon Web Services Support App.
    pub fn deleteAccountAlias(self: *Self, allocator: std.mem.Allocator, input: delete_account_alias.DeleteAccountAliasInput, options: delete_account_alias.Options) !delete_account_alias.DeleteAccountAliasOutput {
        return delete_account_alias.execute(self, allocator, input, options);
    }

    /// Deletes a Slack channel configuration from your Amazon Web Services account.
    /// This operation doesn't
    /// delete your Slack channel.
    pub fn deleteSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_slack_channel_configuration.DeleteSlackChannelConfigurationInput, options: delete_slack_channel_configuration.Options) !delete_slack_channel_configuration.DeleteSlackChannelConfigurationOutput {
        return delete_slack_channel_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a Slack workspace configuration from your Amazon Web Services
    /// account. This operation doesn't
    /// delete your Slack workspace.
    pub fn deleteSlackWorkspaceConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_slack_workspace_configuration.DeleteSlackWorkspaceConfigurationInput, options: delete_slack_workspace_configuration.Options) !delete_slack_workspace_configuration.DeleteSlackWorkspaceConfigurationOutput {
        return delete_slack_workspace_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the alias from an Amazon Web Services account ID. The alias
    /// appears in the Amazon Web Services Support App page of
    /// the Amazon Web Services Support Center. The alias also appears in Slack
    /// messages from the Amazon Web Services Support App.
    pub fn getAccountAlias(self: *Self, allocator: std.mem.Allocator, input: get_account_alias.GetAccountAliasInput, options: get_account_alias.Options) !get_account_alias.GetAccountAliasOutput {
        return get_account_alias.execute(self, allocator, input, options);
    }

    /// Lists the Slack channel configurations for an Amazon Web Services account.
    pub fn listSlackChannelConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_slack_channel_configurations.ListSlackChannelConfigurationsInput, options: list_slack_channel_configurations.Options) !list_slack_channel_configurations.ListSlackChannelConfigurationsOutput {
        return list_slack_channel_configurations.execute(self, allocator, input, options);
    }

    /// Lists the Slack workspace configurations for an Amazon Web Services account.
    pub fn listSlackWorkspaceConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_slack_workspace_configurations.ListSlackWorkspaceConfigurationsInput, options: list_slack_workspace_configurations.Options) !list_slack_workspace_configurations.ListSlackWorkspaceConfigurationsOutput {
        return list_slack_workspace_configurations.execute(self, allocator, input, options);
    }

    /// Creates or updates an individual alias for each Amazon Web Services account
    /// ID. The alias appears in the
    /// Amazon Web Services Support App page of the Amazon Web Services Support
    /// Center. The alias also appears in Slack messages from the
    /// Amazon Web Services Support App.
    pub fn putAccountAlias(self: *Self, allocator: std.mem.Allocator, input: put_account_alias.PutAccountAliasInput, options: put_account_alias.Options) !put_account_alias.PutAccountAliasOutput {
        return put_account_alias.execute(self, allocator, input, options);
    }

    /// Registers a Slack workspace for your Amazon Web Services account. To call
    /// this API, your account must be
    /// part of an organization in Organizations.
    ///
    /// If you're the *management account* and you want to register Slack
    /// workspaces for your organization, you must complete the following tasks:
    ///
    /// * Sign in to the [Amazon Web Services Support
    ///   Center](https://console.aws.amazon.com/support/app) and
    /// authorize the Slack workspaces where you want your organization to have
    /// access to. See
    /// [Authorize a Slack
    /// workspace](https://docs.aws.amazon.com/awssupport/latest/user/authorize-slack-workspace.html) in the *Amazon Web Services Support User
    /// Guide*.
    ///
    /// * Call the `RegisterSlackWorkspaceForOrganization` API to authorize each
    /// Slack workspace for the organization.
    ///
    /// After the management account authorizes the Slack workspace, member accounts
    /// can call this
    /// API to authorize the same Slack workspace for their individual accounts.
    /// Member accounts don't
    /// need to authorize the Slack workspace manually through the [Amazon Web
    /// Services Support Center](https://console.aws.amazon.com/support/app).
    ///
    /// To use the Amazon Web Services Support App, each account must then complete
    /// the following tasks:
    ///
    /// * Create an Identity and Access Management (IAM) role with the required
    ///   permission. For more information,
    /// see [Managing access to the Amazon Web Services Support
    /// App](https://docs.aws.amazon.com/awssupport/latest/user/support-app-permissions.html).
    ///
    /// * Configure a Slack channel to use the Amazon Web Services Support App for
    ///   support cases for that account. For
    /// more information, see [Configuring a Slack
    /// channel](https://docs.aws.amazon.com/awssupport/latest/user/add-your-slack-channel.html).
    pub fn registerSlackWorkspaceForOrganization(self: *Self, allocator: std.mem.Allocator, input: register_slack_workspace_for_organization.RegisterSlackWorkspaceForOrganizationInput, options: register_slack_workspace_for_organization.Options) !register_slack_workspace_for_organization.RegisterSlackWorkspaceForOrganizationOutput {
        return register_slack_workspace_for_organization.execute(self, allocator, input, options);
    }

    /// Updates the configuration for a Slack channel, such as case update
    /// notifications.
    pub fn updateSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_slack_channel_configuration.UpdateSlackChannelConfigurationInput, options: update_slack_channel_configuration.Options) !update_slack_channel_configuration.UpdateSlackChannelConfigurationOutput {
        return update_slack_channel_configuration.execute(self, allocator, input, options);
    }

    pub fn listSlackChannelConfigurationsPaginator(self: *Self, params: list_slack_channel_configurations.ListSlackChannelConfigurationsInput) paginator.ListSlackChannelConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSlackWorkspaceConfigurationsPaginator(self: *Self, params: list_slack_workspace_configurations.ListSlackWorkspaceConfigurationsInput) paginator.ListSlackWorkspaceConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
