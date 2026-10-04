const ChannelType = @import("channel_type.zig").ChannelType;
const ChannelAssociationOverrideOption = @import("channel_association_override_option.zig").ChannelAssociationOverrideOption;

/// Provides a summary of channel associations for a managed notification
/// configuration.
pub const ManagedNotificationChannelAssociationSummary = struct {
    /// The unique identifier for the notification channel.
    channel_identifier: []const u8,

    /// The type of notification channel used for message delivery.
    ///
    /// * Values:
    ///
    /// * `ACCOUNT_CONTACT`
    ///
    /// * Delivers notifications to Account Managed contacts through the User
    ///   Notification Service.
    ///
    /// * `MOBILE`
    ///
    /// * Delivers notifications through the Amazon Web Services Console Mobile
    ///   Application to mobile devices.
    ///
    /// * `CHATBOT`
    ///
    /// * Delivers notifications through Amazon Q Developer in chat applications to
    ///   collaboration platforms (Slack, Chime).
    ///
    /// * `EMAIL`
    ///
    /// * Delivers notifications to email addresses.
    channel_type: ChannelType,

    /// Specifies whether this channel association is subscribed to sensitive
    /// events. Defaults to false for associations created without the flag.
    is_sensitive_events_subscribed: ?bool = null,

    /// Controls whether users can modify channel associations for a notification
    /// configuration.
    ///
    /// * Values:
    ///
    /// * `ENABLED`
    ///
    /// * Users can associate or disassociate channels with the notification
    ///   configuration.
    ///
    /// * `DISABLED`
    ///
    /// * Users cannot associate or disassociate channels with the notification
    ///   configuration.
    override_option: ?ChannelAssociationOverrideOption = null,

    pub const json_field_names = .{
        .channel_identifier = "channelIdentifier",
        .channel_type = "channelType",
        .is_sensitive_events_subscribed = "isSensitiveEventsSubscribed",
        .override_option = "overrideOption",
    };
};
