const JourneyPushMessage = @import("journey_push_message.zig").JourneyPushMessage;

/// Specifies the settings for a push notification activity in a journey. This
/// type of activity sends a push notification to participants.
pub const PushMessageActivity = struct {
    /// Specifies the time to live (TTL) value for push notifications that are sent
    /// to participants in a journey.
    message_config: ?JourneyPushMessage = null,

    /// The unique identifier for the next activity to perform, after the message is
    /// sent.
    next_activity: ?[]const u8 = null,

    /// The name of the push notification template to use for the message. If
    /// specified, this value must match the name of an existing message template.
    template_name: ?[]const u8 = null,

    /// The unique identifier for the version of the push notification template to
    /// use for the message. If specified, this value must match the identifier for
    /// an existing template version. To retrieve a list of versions and version
    /// identifiers for a template, use the Template Versions resource.
    ///
    /// If you don't specify a value for this property, Amazon Pinpoint uses the
    /// *active version* of the template. The *active version* is typically the
    /// version of a template that's been most recently reviewed and approved for
    /// use, depending on your workflow. It isn't necessarily the latest version of
    /// a template.
    template_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_config = "MessageConfig",
        .next_activity = "NextActivity",
        .template_name = "TemplateName",
        .template_version = "TemplateVersion",
    };
};
