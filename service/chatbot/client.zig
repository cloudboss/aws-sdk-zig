const aws = @import("aws");
const std = @import("std");

const associate_to_configuration = @import("associate_to_configuration.zig");
const create_chime_webhook_configuration = @import("create_chime_webhook_configuration.zig");
const create_custom_action = @import("create_custom_action.zig");
const create_microsoft_teams_channel_configuration = @import("create_microsoft_teams_channel_configuration.zig");
const create_slack_channel_configuration = @import("create_slack_channel_configuration.zig");
const delete_chime_webhook_configuration = @import("delete_chime_webhook_configuration.zig");
const delete_custom_action = @import("delete_custom_action.zig");
const delete_microsoft_teams_channel_configuration = @import("delete_microsoft_teams_channel_configuration.zig");
const delete_microsoft_teams_configured_team = @import("delete_microsoft_teams_configured_team.zig");
const delete_microsoft_teams_user_identity = @import("delete_microsoft_teams_user_identity.zig");
const delete_slack_channel_configuration = @import("delete_slack_channel_configuration.zig");
const delete_slack_user_identity = @import("delete_slack_user_identity.zig");
const delete_slack_workspace_authorization = @import("delete_slack_workspace_authorization.zig");
const describe_chime_webhook_configurations = @import("describe_chime_webhook_configurations.zig");
const describe_slack_channel_configurations = @import("describe_slack_channel_configurations.zig");
const describe_slack_user_identities = @import("describe_slack_user_identities.zig");
const describe_slack_workspaces = @import("describe_slack_workspaces.zig");
const disassociate_from_configuration = @import("disassociate_from_configuration.zig");
const get_account_preferences = @import("get_account_preferences.zig");
const get_custom_action = @import("get_custom_action.zig");
const get_microsoft_teams_channel_configuration = @import("get_microsoft_teams_channel_configuration.zig");
const list_associations = @import("list_associations.zig");
const list_custom_actions = @import("list_custom_actions.zig");
const list_microsoft_teams_channel_configurations = @import("list_microsoft_teams_channel_configurations.zig");
const list_microsoft_teams_configured_teams = @import("list_microsoft_teams_configured_teams.zig");
const list_microsoft_teams_user_identities = @import("list_microsoft_teams_user_identities.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_account_preferences = @import("update_account_preferences.zig");
const update_chime_webhook_configuration = @import("update_chime_webhook_configuration.zig");
const update_custom_action = @import("update_custom_action.zig");
const update_microsoft_teams_channel_configuration = @import("update_microsoft_teams_channel_configuration.zig");
const update_slack_channel_configuration = @import("update_slack_channel_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "chatbot";

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

    /// Links a resource (for example, a custom action) to a channel configuration.
    pub fn associateToConfiguration(self: *Self, allocator: std.mem.Allocator, input: associate_to_configuration.AssociateToConfigurationInput, options: associate_to_configuration.Options) !associate_to_configuration.AssociateToConfigurationOutput {
        return associate_to_configuration.execute(self, allocator, input, options);
    }

    /// Creates an AWS Chatbot configuration for Amazon Chime.
    pub fn createChimeWebhookConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_chime_webhook_configuration.CreateChimeWebhookConfigurationInput, options: create_chime_webhook_configuration.Options) !create_chime_webhook_configuration.CreateChimeWebhookConfigurationOutput {
        return create_chime_webhook_configuration.execute(self, allocator, input, options);
    }

    /// Creates a custom action that can be invoked as an alias or as a button on a
    /// notification.
    pub fn createCustomAction(self: *Self, allocator: std.mem.Allocator, input: create_custom_action.CreateCustomActionInput, options: create_custom_action.Options) !create_custom_action.CreateCustomActionOutput {
        return create_custom_action.execute(self, allocator, input, options);
    }

    /// Creates an AWS Chatbot configuration for Microsoft Teams.
    pub fn createMicrosoftTeamsChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_microsoft_teams_channel_configuration.CreateMicrosoftTeamsChannelConfigurationInput, options: create_microsoft_teams_channel_configuration.Options) !create_microsoft_teams_channel_configuration.CreateMicrosoftTeamsChannelConfigurationOutput {
        return create_microsoft_teams_channel_configuration.execute(self, allocator, input, options);
    }

    /// Creates an AWS Chatbot confugration for Slack.
    pub fn createSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_slack_channel_configuration.CreateSlackChannelConfigurationInput, options: create_slack_channel_configuration.Options) !create_slack_channel_configuration.CreateSlackChannelConfigurationOutput {
        return create_slack_channel_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a Amazon Chime webhook configuration for AWS Chatbot.
    pub fn deleteChimeWebhookConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_chime_webhook_configuration.DeleteChimeWebhookConfigurationInput, options: delete_chime_webhook_configuration.Options) !delete_chime_webhook_configuration.DeleteChimeWebhookConfigurationOutput {
        return delete_chime_webhook_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a custom action.
    pub fn deleteCustomAction(self: *Self, allocator: std.mem.Allocator, input: delete_custom_action.DeleteCustomActionInput, options: delete_custom_action.Options) !delete_custom_action.DeleteCustomActionOutput {
        return delete_custom_action.execute(self, allocator, input, options);
    }

    /// Deletes a Microsoft Teams channel configuration for AWS Chatbot
    pub fn deleteMicrosoftTeamsChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_microsoft_teams_channel_configuration.DeleteMicrosoftTeamsChannelConfigurationInput, options: delete_microsoft_teams_channel_configuration.Options) !delete_microsoft_teams_channel_configuration.DeleteMicrosoftTeamsChannelConfigurationOutput {
        return delete_microsoft_teams_channel_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the Microsoft Teams team authorization allowing for channels to be
    /// configured in that Microsoft Teams team. Note that the Microsoft Teams team
    /// must have no channels configured to remove it.
    pub fn deleteMicrosoftTeamsConfiguredTeam(self: *Self, allocator: std.mem.Allocator, input: delete_microsoft_teams_configured_team.DeleteMicrosoftTeamsConfiguredTeamInput, options: delete_microsoft_teams_configured_team.Options) !delete_microsoft_teams_configured_team.DeleteMicrosoftTeamsConfiguredTeamOutput {
        return delete_microsoft_teams_configured_team.execute(self, allocator, input, options);
    }

    /// Identifes a user level permission for a channel configuration.
    pub fn deleteMicrosoftTeamsUserIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_microsoft_teams_user_identity.DeleteMicrosoftTeamsUserIdentityInput, options: delete_microsoft_teams_user_identity.Options) !delete_microsoft_teams_user_identity.DeleteMicrosoftTeamsUserIdentityOutput {
        return delete_microsoft_teams_user_identity.execute(self, allocator, input, options);
    }

    /// Deletes a Slack channel configuration for AWS Chatbot
    pub fn deleteSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_slack_channel_configuration.DeleteSlackChannelConfigurationInput, options: delete_slack_channel_configuration.Options) !delete_slack_channel_configuration.DeleteSlackChannelConfigurationOutput {
        return delete_slack_channel_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a user level permission for a Slack channel configuration.
    pub fn deleteSlackUserIdentity(self: *Self, allocator: std.mem.Allocator, input: delete_slack_user_identity.DeleteSlackUserIdentityInput, options: delete_slack_user_identity.Options) !delete_slack_user_identity.DeleteSlackUserIdentityOutput {
        return delete_slack_user_identity.execute(self, allocator, input, options);
    }

    /// Deletes the Slack workspace authorization that allows channels to be
    /// configured in that workspace. This requires all configured channels in the
    /// workspace to be deleted.
    pub fn deleteSlackWorkspaceAuthorization(self: *Self, allocator: std.mem.Allocator, input: delete_slack_workspace_authorization.DeleteSlackWorkspaceAuthorizationInput, options: delete_slack_workspace_authorization.Options) !delete_slack_workspace_authorization.DeleteSlackWorkspaceAuthorizationOutput {
        return delete_slack_workspace_authorization.execute(self, allocator, input, options);
    }

    /// Lists Amazon Chime webhook configurations optionally filtered by
    /// ChatConfigurationArn
    pub fn describeChimeWebhookConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_chime_webhook_configurations.DescribeChimeWebhookConfigurationsInput, options: describe_chime_webhook_configurations.Options) !describe_chime_webhook_configurations.DescribeChimeWebhookConfigurationsOutput {
        return describe_chime_webhook_configurations.execute(self, allocator, input, options);
    }

    /// Lists Slack channel configurations optionally filtered by
    /// ChatConfigurationArn
    pub fn describeSlackChannelConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_slack_channel_configurations.DescribeSlackChannelConfigurationsInput, options: describe_slack_channel_configurations.Options) !describe_slack_channel_configurations.DescribeSlackChannelConfigurationsOutput {
        return describe_slack_channel_configurations.execute(self, allocator, input, options);
    }

    /// Lists all Slack user identities with a mapped role.
    pub fn describeSlackUserIdentities(self: *Self, allocator: std.mem.Allocator, input: describe_slack_user_identities.DescribeSlackUserIdentitiesInput, options: describe_slack_user_identities.Options) !describe_slack_user_identities.DescribeSlackUserIdentitiesOutput {
        return describe_slack_user_identities.execute(self, allocator, input, options);
    }

    /// List all authorized Slack workspaces connected to the AWS Account onboarded
    /// with AWS Chatbot.
    pub fn describeSlackWorkspaces(self: *Self, allocator: std.mem.Allocator, input: describe_slack_workspaces.DescribeSlackWorkspacesInput, options: describe_slack_workspaces.Options) !describe_slack_workspaces.DescribeSlackWorkspacesOutput {
        return describe_slack_workspaces.execute(self, allocator, input, options);
    }

    /// Unlink a resource, for example a custom action, from a channel
    /// configuration.
    pub fn disassociateFromConfiguration(self: *Self, allocator: std.mem.Allocator, input: disassociate_from_configuration.DisassociateFromConfigurationInput, options: disassociate_from_configuration.Options) !disassociate_from_configuration.DisassociateFromConfigurationOutput {
        return disassociate_from_configuration.execute(self, allocator, input, options);
    }

    /// Returns AWS Chatbot account preferences.
    pub fn getAccountPreferences(self: *Self, allocator: std.mem.Allocator, input: get_account_preferences.GetAccountPreferencesInput, options: get_account_preferences.Options) !get_account_preferences.GetAccountPreferencesOutput {
        return get_account_preferences.execute(self, allocator, input, options);
    }

    /// Returns a custom action.
    pub fn getCustomAction(self: *Self, allocator: std.mem.Allocator, input: get_custom_action.GetCustomActionInput, options: get_custom_action.Options) !get_custom_action.GetCustomActionOutput {
        return get_custom_action.execute(self, allocator, input, options);
    }

    /// Returns a Microsoft Teams channel configuration in an AWS account.
    pub fn getMicrosoftTeamsChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_microsoft_teams_channel_configuration.GetMicrosoftTeamsChannelConfigurationInput, options: get_microsoft_teams_channel_configuration.Options) !get_microsoft_teams_channel_configuration.GetMicrosoftTeamsChannelConfigurationOutput {
        return get_microsoft_teams_channel_configuration.execute(self, allocator, input, options);
    }

    /// Lists resources associated with a channel configuration.
    pub fn listAssociations(self: *Self, allocator: std.mem.Allocator, input: list_associations.ListAssociationsInput, options: list_associations.Options) !list_associations.ListAssociationsOutput {
        return list_associations.execute(self, allocator, input, options);
    }

    /// Lists custom actions defined in this account.
    pub fn listCustomActions(self: *Self, allocator: std.mem.Allocator, input: list_custom_actions.ListCustomActionsInput, options: list_custom_actions.Options) !list_custom_actions.ListCustomActionsOutput {
        return list_custom_actions.execute(self, allocator, input, options);
    }

    /// Lists all AWS Chatbot Microsoft Teams channel configurations in an AWS
    /// account.
    pub fn listMicrosoftTeamsChannelConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_microsoft_teams_channel_configurations.ListMicrosoftTeamsChannelConfigurationsInput, options: list_microsoft_teams_channel_configurations.Options) !list_microsoft_teams_channel_configurations.ListMicrosoftTeamsChannelConfigurationsOutput {
        return list_microsoft_teams_channel_configurations.execute(self, allocator, input, options);
    }

    /// Lists all authorized Microsoft Teams for an AWS Account
    pub fn listMicrosoftTeamsConfiguredTeams(self: *Self, allocator: std.mem.Allocator, input: list_microsoft_teams_configured_teams.ListMicrosoftTeamsConfiguredTeamsInput, options: list_microsoft_teams_configured_teams.Options) !list_microsoft_teams_configured_teams.ListMicrosoftTeamsConfiguredTeamsOutput {
        return list_microsoft_teams_configured_teams.execute(self, allocator, input, options);
    }

    /// A list all Microsoft Teams user identities with a mapped role.
    pub fn listMicrosoftTeamsUserIdentities(self: *Self, allocator: std.mem.Allocator, input: list_microsoft_teams_user_identities.ListMicrosoftTeamsUserIdentitiesInput, options: list_microsoft_teams_user_identities.Options) !list_microsoft_teams_user_identities.ListMicrosoftTeamsUserIdentitiesOutput {
        return list_microsoft_teams_user_identities.execute(self, allocator, input, options);
    }

    /// Lists all of the tags associated with the Amazon Resource Name (ARN) that
    /// you specify. The resource can be a user, server, or role.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a key-value pair to a resource, as identified by its Amazon
    /// Resource Name (ARN). Resources are users, servers, roles, and other
    /// entities.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Detaches a key-value pair from a resource, as identified by its Amazon
    /// Resource Name (ARN). Resources are users, servers, roles, and other
    /// entities.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates AWS Chatbot account preferences.
    pub fn updateAccountPreferences(self: *Self, allocator: std.mem.Allocator, input: update_account_preferences.UpdateAccountPreferencesInput, options: update_account_preferences.Options) !update_account_preferences.UpdateAccountPreferencesOutput {
        return update_account_preferences.execute(self, allocator, input, options);
    }

    /// Updates a Amazon Chime webhook configuration.
    pub fn updateChimeWebhookConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_chime_webhook_configuration.UpdateChimeWebhookConfigurationInput, options: update_chime_webhook_configuration.Options) !update_chime_webhook_configuration.UpdateChimeWebhookConfigurationOutput {
        return update_chime_webhook_configuration.execute(self, allocator, input, options);
    }

    /// Updates a custom action.
    pub fn updateCustomAction(self: *Self, allocator: std.mem.Allocator, input: update_custom_action.UpdateCustomActionInput, options: update_custom_action.Options) !update_custom_action.UpdateCustomActionOutput {
        return update_custom_action.execute(self, allocator, input, options);
    }

    /// Updates an Microsoft Teams channel configuration.
    pub fn updateMicrosoftTeamsChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_microsoft_teams_channel_configuration.UpdateMicrosoftTeamsChannelConfigurationInput, options: update_microsoft_teams_channel_configuration.Options) !update_microsoft_teams_channel_configuration.UpdateMicrosoftTeamsChannelConfigurationOutput {
        return update_microsoft_teams_channel_configuration.execute(self, allocator, input, options);
    }

    /// Updates a Slack channel configuration.
    pub fn updateSlackChannelConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_slack_channel_configuration.UpdateSlackChannelConfigurationInput, options: update_slack_channel_configuration.Options) !update_slack_channel_configuration.UpdateSlackChannelConfigurationOutput {
        return update_slack_channel_configuration.execute(self, allocator, input, options);
    }

    pub fn describeChimeWebhookConfigurationsPaginator(self: *Self, params: describe_chime_webhook_configurations.DescribeChimeWebhookConfigurationsInput) paginator.DescribeChimeWebhookConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSlackChannelConfigurationsPaginator(self: *Self, params: describe_slack_channel_configurations.DescribeSlackChannelConfigurationsInput) paginator.DescribeSlackChannelConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSlackUserIdentitiesPaginator(self: *Self, params: describe_slack_user_identities.DescribeSlackUserIdentitiesInput) paginator.DescribeSlackUserIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSlackWorkspacesPaginator(self: *Self, params: describe_slack_workspaces.DescribeSlackWorkspacesInput) paginator.DescribeSlackWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociationsPaginator(self: *Self, params: list_associations.ListAssociationsInput) paginator.ListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCustomActionsPaginator(self: *Self, params: list_custom_actions.ListCustomActionsInput) paginator.ListCustomActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMicrosoftTeamsChannelConfigurationsPaginator(self: *Self, params: list_microsoft_teams_channel_configurations.ListMicrosoftTeamsChannelConfigurationsInput) paginator.ListMicrosoftTeamsChannelConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMicrosoftTeamsConfiguredTeamsPaginator(self: *Self, params: list_microsoft_teams_configured_teams.ListMicrosoftTeamsConfiguredTeamsInput) paginator.ListMicrosoftTeamsConfiguredTeamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMicrosoftTeamsUserIdentitiesPaginator(self: *Self, params: list_microsoft_teams_user_identities.ListMicrosoftTeamsUserIdentitiesInput) paginator.ListMicrosoftTeamsUserIdentitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
