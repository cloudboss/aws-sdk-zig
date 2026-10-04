const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// An object that overrides, for a single email sending request, the engagement
/// tracking
/// settings that would otherwise apply. Use these overrides to turn open
/// tracking or click
/// tracking on or off for an individual message, for example to suppress
/// tracking in a
/// transactional message that you send from an account or a configuration set
/// that has
/// tracking enabled.
///
/// Without an override, engagement tracking is determined by your account-level
/// `EngagementMetrics` setting, which you configure using the
/// `PutAccountVdmAttributes` operation, by the
/// `EngagementMetrics` setting of the configuration set that the message
/// uses, which you configure using the `PutConfigurationSetVdmOptions`
/// operation,
/// and by whether that configuration set has an event destination whose
/// `MatchingEventTypes` include the `OPEN` or `CLICK`
/// event types.
///
/// For more information about tracking open and click events, see the [Amazon
/// SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/event-publishing.html).
pub const TrackingConfigurationOverrides = struct {
    /// Specifies whether Amazon SES tracks when the recipient clicks a link in this
    /// message. Can be
    /// one of the following:
    ///
    /// * `ENABLED` – Amazon SES tracks clicks for this message, even when
    /// your account-level and configuration set settings don't enable click
    /// tracking.
    ///
    /// * `DISABLED` – Amazon SES doesn't track clicks for this message, even
    /// when your account-level or configuration set settings enable click tracking.
    /// Amazon SES doesn't rewrite the links in the message.
    ///
    /// If you don't specify this value, Amazon SES uses the click tracking setting
    /// that would
    /// otherwise apply to the message.
    ///
    /// Enabling open or click tracking with an override doesn't create an event
    /// destination. Amazon SES records the resulting open and click events in VDM,
    /// where you can
    /// review them using VDM metrics and Message Insights. To also receive these
    /// events at
    /// a destination that you own, the configuration set that the message uses must
    /// have an
    /// event destination that publishes open and click events.
    click_tracking_enabled: ?FeatureStatus = null,

    /// Specifies whether Amazon SES tracks when the recipient opens this message.
    /// Can be one of the
    /// following:
    ///
    /// * `ENABLED` – Amazon SES tracks opens for this message, even when
    /// your account-level and configuration set settings don't enable open
    /// tracking.
    ///
    /// * `DISABLED` – Amazon SES doesn't track opens for this message, even
    /// when your account-level or configuration set settings enable open tracking.
    /// Amazon SES
    /// doesn't add the tracking image to the message.
    ///
    /// If you don't specify this value, Amazon SES uses the open tracking setting
    /// that would
    /// otherwise apply to the message.
    open_tracking_enabled: ?FeatureStatus = null,

    pub const json_field_names = .{
        .click_tracking_enabled = "ClickTrackingEnabled",
        .open_tracking_enabled = "OpenTrackingEnabled",
    };
};
