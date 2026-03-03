const aws = @import("aws");
const std = @import("std");

const associate_channel = @import("associate_channel.zig");
const associate_managed_notification_account_contact = @import("associate_managed_notification_account_contact.zig");
const associate_managed_notification_additional_channel = @import("associate_managed_notification_additional_channel.zig");
const associate_organizational_unit = @import("associate_organizational_unit.zig");
const create_event_rule = @import("create_event_rule.zig");
const create_notification_configuration = @import("create_notification_configuration.zig");
const delete_event_rule = @import("delete_event_rule.zig");
const delete_notification_configuration = @import("delete_notification_configuration.zig");
const deregister_notification_hub = @import("deregister_notification_hub.zig");
const disable_notifications_access_for_organization = @import("disable_notifications_access_for_organization.zig");
const disassociate_channel = @import("disassociate_channel.zig");
const disassociate_managed_notification_account_contact = @import("disassociate_managed_notification_account_contact.zig");
const disassociate_managed_notification_additional_channel = @import("disassociate_managed_notification_additional_channel.zig");
const disassociate_organizational_unit = @import("disassociate_organizational_unit.zig");
const enable_notifications_access_for_organization = @import("enable_notifications_access_for_organization.zig");
const get_event_rule = @import("get_event_rule.zig");
const get_managed_notification_child_event = @import("get_managed_notification_child_event.zig");
const get_managed_notification_configuration = @import("get_managed_notification_configuration.zig");
const get_managed_notification_event = @import("get_managed_notification_event.zig");
const get_notification_configuration = @import("get_notification_configuration.zig");
const get_notification_event = @import("get_notification_event.zig");
const get_notifications_access_for_organization = @import("get_notifications_access_for_organization.zig");
const list_channels = @import("list_channels.zig");
const list_event_rules = @import("list_event_rules.zig");
const list_managed_notification_channel_associations = @import("list_managed_notification_channel_associations.zig");
const list_managed_notification_child_events = @import("list_managed_notification_child_events.zig");
const list_managed_notification_configurations = @import("list_managed_notification_configurations.zig");
const list_managed_notification_events = @import("list_managed_notification_events.zig");
const list_member_accounts = @import("list_member_accounts.zig");
const list_notification_configurations = @import("list_notification_configurations.zig");
const list_notification_events = @import("list_notification_events.zig");
const list_notification_hubs = @import("list_notification_hubs.zig");
const list_organizational_units = @import("list_organizational_units.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_notification_hub = @import("register_notification_hub.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_event_rule = @import("update_event_rule.zig");
const update_notification_configuration = @import("update_notification_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Notifications";

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

    /// Associates a delivery
    /// [Channel](https://docs.aws.amazon.com/notifications/latest/userguide/managing-delivery-channels.html) with a particular `NotificationConfiguration`. Supported Channels include Amazon Q Developer in chat applications, the Console Mobile Application, and emails (notifications-contacts).
    pub fn associateChannel(self: *Self, allocator: std.mem.Allocator, input: associate_channel.AssociateChannelInput, options: associate_channel.Options) !associate_channel.AssociateChannelOutput {
        return associate_channel.execute(self, allocator, input, options);
    }

    /// Associates an Account Contact with a particular
    /// `ManagedNotificationConfiguration`.
    pub fn associateManagedNotificationAccountContact(self: *Self, allocator: std.mem.Allocator, input: associate_managed_notification_account_contact.AssociateManagedNotificationAccountContactInput, options: associate_managed_notification_account_contact.Options) !associate_managed_notification_account_contact.AssociateManagedNotificationAccountContactOutput {
        return associate_managed_notification_account_contact.execute(self, allocator, input, options);
    }

    /// Associates an additional Channel with a particular
    /// `ManagedNotificationConfiguration`.
    ///
    /// Supported Channels include Amazon Q Developer in chat applications, the
    /// Console Mobile Application, and emails (notifications-contacts).
    pub fn associateManagedNotificationAdditionalChannel(self: *Self, allocator: std.mem.Allocator, input: associate_managed_notification_additional_channel.AssociateManagedNotificationAdditionalChannelInput, options: associate_managed_notification_additional_channel.Options) !associate_managed_notification_additional_channel.AssociateManagedNotificationAdditionalChannelOutput {
        return associate_managed_notification_additional_channel.execute(self, allocator, input, options);
    }

    /// Associates an organizational unit with a notification configuration.
    pub fn associateOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: associate_organizational_unit.AssociateOrganizationalUnitInput, options: associate_organizational_unit.Options) !associate_organizational_unit.AssociateOrganizationalUnitOutput {
        return associate_organizational_unit.execute(self, allocator, input, options);
    }

    /// Creates an [ `EventRule`
    /// ](https://docs.aws.amazon.com/notifications/latest/userguide/glossary.html)
    /// that is associated with a specified `NotificationConfiguration`.
    pub fn createEventRule(self: *Self, allocator: std.mem.Allocator, input: create_event_rule.CreateEventRuleInput, options: create_event_rule.Options) !create_event_rule.CreateEventRuleOutput {
        return create_event_rule.execute(self, allocator, input, options);
    }

    /// Creates a new `NotificationConfiguration`.
    pub fn createNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_notification_configuration.CreateNotificationConfigurationInput, options: create_notification_configuration.Options) !create_notification_configuration.CreateNotificationConfigurationOutput {
        return create_notification_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an `EventRule`.
    pub fn deleteEventRule(self: *Self, allocator: std.mem.Allocator, input: delete_event_rule.DeleteEventRuleInput, options: delete_event_rule.Options) !delete_event_rule.DeleteEventRuleOutput {
        return delete_event_rule.execute(self, allocator, input, options);
    }

    /// Deletes a `NotificationConfiguration`.
    pub fn deleteNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_notification_configuration.DeleteNotificationConfigurationInput, options: delete_notification_configuration.Options) !delete_notification_configuration.DeleteNotificationConfigurationOutput {
        return delete_notification_configuration.execute(self, allocator, input, options);
    }

    /// Deregisters a `NotificationConfiguration` in the specified Region.
    ///
    /// You can't deregister the last `NotificationHub` in the account.
    /// `NotificationEvents` stored in the deregistered `NotificationConfiguration`
    /// are no longer be visible. Recreating a new `NotificationConfiguration` in
    /// the same Region restores access to those `NotificationEvents`.
    pub fn deregisterNotificationHub(self: *Self, allocator: std.mem.Allocator, input: deregister_notification_hub.DeregisterNotificationHubInput, options: deregister_notification_hub.Options) !deregister_notification_hub.DeregisterNotificationHubOutput {
        return deregister_notification_hub.execute(self, allocator, input, options);
    }

    /// Disables service trust between User Notifications and Amazon Web Services
    /// Organizations.
    pub fn disableNotificationsAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: disable_notifications_access_for_organization.DisableNotificationsAccessForOrganizationInput, options: disable_notifications_access_for_organization.Options) !disable_notifications_access_for_organization.DisableNotificationsAccessForOrganizationOutput {
        return disable_notifications_access_for_organization.execute(self, allocator, input, options);
    }

    /// Disassociates a Channel from a specified `NotificationConfiguration`.
    /// Supported Channels include Amazon Q Developer in chat applications, the
    /// Console Mobile Application, and emails (notifications-contacts).
    pub fn disassociateChannel(self: *Self, allocator: std.mem.Allocator, input: disassociate_channel.DisassociateChannelInput, options: disassociate_channel.Options) !disassociate_channel.DisassociateChannelOutput {
        return disassociate_channel.execute(self, allocator, input, options);
    }

    /// Disassociates an Account Contact with a particular
    /// `ManagedNotificationConfiguration`.
    pub fn disassociateManagedNotificationAccountContact(self: *Self, allocator: std.mem.Allocator, input: disassociate_managed_notification_account_contact.DisassociateManagedNotificationAccountContactInput, options: disassociate_managed_notification_account_contact.Options) !disassociate_managed_notification_account_contact.DisassociateManagedNotificationAccountContactOutput {
        return disassociate_managed_notification_account_contact.execute(self, allocator, input, options);
    }

    /// Disassociates an additional Channel from a particular
    /// `ManagedNotificationConfiguration`.
    ///
    /// Supported Channels include Amazon Q Developer in chat applications, the
    /// Console Mobile Application, and emails (notifications-contacts).
    pub fn disassociateManagedNotificationAdditionalChannel(self: *Self, allocator: std.mem.Allocator, input: disassociate_managed_notification_additional_channel.DisassociateManagedNotificationAdditionalChannelInput, options: disassociate_managed_notification_additional_channel.Options) !disassociate_managed_notification_additional_channel.DisassociateManagedNotificationAdditionalChannelOutput {
        return disassociate_managed_notification_additional_channel.execute(self, allocator, input, options);
    }

    /// Removes the association between an organizational unit and a notification
    /// configuration.
    pub fn disassociateOrganizationalUnit(self: *Self, allocator: std.mem.Allocator, input: disassociate_organizational_unit.DisassociateOrganizationalUnitInput, options: disassociate_organizational_unit.Options) !disassociate_organizational_unit.DisassociateOrganizationalUnitOutput {
        return disassociate_organizational_unit.execute(self, allocator, input, options);
    }

    /// Enables service trust between User Notifications and Amazon Web Services
    /// Organizations.
    pub fn enableNotificationsAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: enable_notifications_access_for_organization.EnableNotificationsAccessForOrganizationInput, options: enable_notifications_access_for_organization.Options) !enable_notifications_access_for_organization.EnableNotificationsAccessForOrganizationOutput {
        return enable_notifications_access_for_organization.execute(self, allocator, input, options);
    }

    /// Returns a specified `EventRule`.
    pub fn getEventRule(self: *Self, allocator: std.mem.Allocator, input: get_event_rule.GetEventRuleInput, options: get_event_rule.Options) !get_event_rule.GetEventRuleOutput {
        return get_event_rule.execute(self, allocator, input, options);
    }

    /// Returns the child event of a specific given `ManagedNotificationEvent`.
    pub fn getManagedNotificationChildEvent(self: *Self, allocator: std.mem.Allocator, input: get_managed_notification_child_event.GetManagedNotificationChildEventInput, options: get_managed_notification_child_event.Options) !get_managed_notification_child_event.GetManagedNotificationChildEventOutput {
        return get_managed_notification_child_event.execute(self, allocator, input, options);
    }

    /// Returns a specified `ManagedNotificationConfiguration`.
    pub fn getManagedNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_managed_notification_configuration.GetManagedNotificationConfigurationInput, options: get_managed_notification_configuration.Options) !get_managed_notification_configuration.GetManagedNotificationConfigurationOutput {
        return get_managed_notification_configuration.execute(self, allocator, input, options);
    }

    /// Returns a specified `ManagedNotificationEvent`.
    pub fn getManagedNotificationEvent(self: *Self, allocator: std.mem.Allocator, input: get_managed_notification_event.GetManagedNotificationEventInput, options: get_managed_notification_event.Options) !get_managed_notification_event.GetManagedNotificationEventOutput {
        return get_managed_notification_event.execute(self, allocator, input, options);
    }

    /// Returns a specified `NotificationConfiguration`.
    pub fn getNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_notification_configuration.GetNotificationConfigurationInput, options: get_notification_configuration.Options) !get_notification_configuration.GetNotificationConfigurationOutput {
        return get_notification_configuration.execute(self, allocator, input, options);
    }

    /// Returns a specified `NotificationEvent`.
    ///
    /// User Notifications stores notifications in the individual Regions you
    /// register as notification hubs and the Region of the source event rule.
    /// `GetNotificationEvent` only returns notifications stored in the same Region
    /// in which the action is called. User Notifications doesn't backfill
    /// notifications to new Regions selected as notification hubs. For this reason,
    /// we recommend that you make calls in your oldest registered notification hub.
    /// For more information, see [Notification
    /// hubs](https://docs.aws.amazon.com/notifications/latest/userguide/notification-hubs.html) in the *Amazon Web Services User Notifications User Guide*.
    pub fn getNotificationEvent(self: *Self, allocator: std.mem.Allocator, input: get_notification_event.GetNotificationEventInput, options: get_notification_event.Options) !get_notification_event.GetNotificationEventOutput {
        return get_notification_event.execute(self, allocator, input, options);
    }

    /// Returns the AccessStatus of Service Trust Enablement for User Notifications
    /// and Amazon Web Services Organizations.
    pub fn getNotificationsAccessForOrganization(self: *Self, allocator: std.mem.Allocator, input: get_notifications_access_for_organization.GetNotificationsAccessForOrganizationInput, options: get_notifications_access_for_organization.Options) !get_notifications_access_for_organization.GetNotificationsAccessForOrganizationOutput {
        return get_notifications_access_for_organization.execute(self, allocator, input, options);
    }

    /// Returns a list of Channels for a `NotificationConfiguration`.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Returns a list of `EventRules` according to specified filters, in reverse
    /// chronological order (newest first).
    pub fn listEventRules(self: *Self, allocator: std.mem.Allocator, input: list_event_rules.ListEventRulesInput, options: list_event_rules.Options) !list_event_rules.ListEventRulesOutput {
        return list_event_rules.execute(self, allocator, input, options);
    }

    /// Returns a list of Account contacts and Channels associated with a
    /// `ManagedNotificationConfiguration`, in paginated format.
    pub fn listManagedNotificationChannelAssociations(self: *Self, allocator: std.mem.Allocator, input: list_managed_notification_channel_associations.ListManagedNotificationChannelAssociationsInput, options: list_managed_notification_channel_associations.Options) !list_managed_notification_channel_associations.ListManagedNotificationChannelAssociationsOutput {
        return list_managed_notification_channel_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of `ManagedNotificationChildEvents` for a specified aggregate
    /// `ManagedNotificationEvent`, ordered by creation time in reverse
    /// chronological order (newest first).
    pub fn listManagedNotificationChildEvents(self: *Self, allocator: std.mem.Allocator, input: list_managed_notification_child_events.ListManagedNotificationChildEventsInput, options: list_managed_notification_child_events.Options) !list_managed_notification_child_events.ListManagedNotificationChildEventsOutput {
        return list_managed_notification_child_events.execute(self, allocator, input, options);
    }

    /// Returns a list of Managed Notification Configurations according to specified
    /// filters, ordered by creation time in reverse chronological order (newest
    /// first).
    pub fn listManagedNotificationConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_managed_notification_configurations.ListManagedNotificationConfigurationsInput, options: list_managed_notification_configurations.Options) !list_managed_notification_configurations.ListManagedNotificationConfigurationsOutput {
        return list_managed_notification_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of Managed Notification Events according to specified
    /// filters, ordered by creation time in reverse chronological order (newest
    /// first).
    pub fn listManagedNotificationEvents(self: *Self, allocator: std.mem.Allocator, input: list_managed_notification_events.ListManagedNotificationEventsInput, options: list_managed_notification_events.Options) !list_managed_notification_events.ListManagedNotificationEventsOutput {
        return list_managed_notification_events.execute(self, allocator, input, options);
    }

    /// Returns a list of member accounts associated with a notification
    /// configuration.
    pub fn listMemberAccounts(self: *Self, allocator: std.mem.Allocator, input: list_member_accounts.ListMemberAccountsInput, options: list_member_accounts.Options) !list_member_accounts.ListMemberAccountsOutput {
        return list_member_accounts.execute(self, allocator, input, options);
    }

    /// Returns a list of abbreviated `NotificationConfigurations` according to
    /// specified filters, in reverse chronological order (newest first).
    pub fn listNotificationConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_notification_configurations.ListNotificationConfigurationsInput, options: list_notification_configurations.Options) !list_notification_configurations.ListNotificationConfigurationsOutput {
        return list_notification_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of `NotificationEvents` according to specified filters, in
    /// reverse chronological order (newest first).
    ///
    /// User Notifications stores notifications in the individual Regions you
    /// register as notification hubs and the Region of the source event rule.
    /// ListNotificationEvents only returns notifications stored in the same Region
    /// in which the action is called. User Notifications doesn't backfill
    /// notifications to new Regions selected as notification hubs. For this reason,
    /// we recommend that you make calls in your oldest registered notification hub.
    /// For more information, see [Notification
    /// hubs](https://docs.aws.amazon.com/notifications/latest/userguide/notification-hubs.html) in the *Amazon Web Services User Notifications User Guide*.
    pub fn listNotificationEvents(self: *Self, allocator: std.mem.Allocator, input: list_notification_events.ListNotificationEventsInput, options: list_notification_events.Options) !list_notification_events.ListNotificationEventsOutput {
        return list_notification_events.execute(self, allocator, input, options);
    }

    /// Returns a list of `NotificationHubs`.
    pub fn listNotificationHubs(self: *Self, allocator: std.mem.Allocator, input: list_notification_hubs.ListNotificationHubsInput, options: list_notification_hubs.Options) !list_notification_hubs.ListNotificationHubsOutput {
        return list_notification_hubs.execute(self, allocator, input, options);
    }

    /// Returns a list of organizational units associated with a notification
    /// configuration.
    pub fn listOrganizationalUnits(self: *Self, allocator: std.mem.Allocator, input: list_organizational_units.ListOrganizationalUnitsInput, options: list_organizational_units.Options) !list_organizational_units.ListOrganizationalUnitsOutput {
        return list_organizational_units.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a specified Amazon Resource Name (ARN).
    ///
    /// For more information, see [Tagging your Amazon Web Services
    /// resources](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) in the *Tagging Amazon Web Services Resources User Guide*.
    ///
    /// This is only supported for `NotificationConfigurations`.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Registers a `NotificationConfiguration` in the specified Region.
    ///
    /// There is a maximum of one `NotificationConfiguration` per Region. You can
    /// have a maximum of 3 `NotificationHub` resources at a time.
    pub fn registerNotificationHub(self: *Self, allocator: std.mem.Allocator, input: register_notification_hub.RegisterNotificationHubInput, options: register_notification_hub.Options) !register_notification_hub.RegisterNotificationHubOutput {
        return register_notification_hub.execute(self, allocator, input, options);
    }

    /// Tags the resource with a tag key and value.
    ///
    /// For more information, see [Tagging your Amazon Web Services
    /// resources](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) in the *Tagging Amazon Web Services Resources User Guide*.
    ///
    /// This is only supported for `NotificationConfigurations`.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource with a specified Amazon Resource Name (ARN).
    ///
    /// For more information, see [Tagging your Amazon Web Services
    /// resources](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) in the *Tagging Amazon Web Services Resources User Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing `EventRule`.
    pub fn updateEventRule(self: *Self, allocator: std.mem.Allocator, input: update_event_rule.UpdateEventRuleInput, options: update_event_rule.Options) !update_event_rule.UpdateEventRuleOutput {
        return update_event_rule.execute(self, allocator, input, options);
    }

    /// Updates a `NotificationConfiguration`.
    pub fn updateNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_notification_configuration.UpdateNotificationConfigurationInput, options: update_notification_configuration.Options) !update_notification_configuration.UpdateNotificationConfigurationOutput {
        return update_notification_configuration.execute(self, allocator, input, options);
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventRulesPaginator(self: *Self, params: list_event_rules.ListEventRulesInput) paginator.ListEventRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedNotificationChannelAssociationsPaginator(self: *Self, params: list_managed_notification_channel_associations.ListManagedNotificationChannelAssociationsInput) paginator.ListManagedNotificationChannelAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedNotificationChildEventsPaginator(self: *Self, params: list_managed_notification_child_events.ListManagedNotificationChildEventsInput) paginator.ListManagedNotificationChildEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedNotificationConfigurationsPaginator(self: *Self, params: list_managed_notification_configurations.ListManagedNotificationConfigurationsInput) paginator.ListManagedNotificationConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedNotificationEventsPaginator(self: *Self, params: list_managed_notification_events.ListManagedNotificationEventsInput) paginator.ListManagedNotificationEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMemberAccountsPaginator(self: *Self, params: list_member_accounts.ListMemberAccountsInput) paginator.ListMemberAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationConfigurationsPaginator(self: *Self, params: list_notification_configurations.ListNotificationConfigurationsInput) paginator.ListNotificationConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationEventsPaginator(self: *Self, params: list_notification_events.ListNotificationEventsInput) paginator.ListNotificationEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotificationHubsPaginator(self: *Self, params: list_notification_hubs.ListNotificationHubsInput) paginator.ListNotificationHubsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOrganizationalUnitsPaginator(self: *Self, params: list_organizational_units.ListOrganizationalUnitsInput) paginator.ListOrganizationalUnitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
