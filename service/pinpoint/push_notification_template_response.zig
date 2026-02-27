const aws = @import("aws");

const AndroidPushNotificationTemplate = @import("android_push_notification_template.zig").AndroidPushNotificationTemplate;
const APNSPushNotificationTemplate = @import("apns_push_notification_template.zig").APNSPushNotificationTemplate;
const DefaultPushNotificationTemplate = @import("default_push_notification_template.zig").DefaultPushNotificationTemplate;
const TemplateType = @import("template_type.zig").TemplateType;

/// Provides information about the content and settings for a message template
/// that can be used in messages that are sent through a push notification
/// channel.
pub const PushNotificationTemplateResponse = struct {
    /// The message template that's used for the ADM (Amazon Device Messaging)
    /// channel. This message template overrides the default template for push
    /// notification channels (DefaultPushNotificationTemplate).
    adm: ?AndroidPushNotificationTemplate,

    /// The message template that's used for the APNs (Apple Push Notification
    /// service) channel. This message template overrides the default template for
    /// push notification channels (DefaultPushNotificationTemplate).
    apns: ?APNSPushNotificationTemplate,

    /// The Amazon Resource Name (ARN) of the message template.
    arn: ?[]const u8,

    /// The message template that's used for the Baidu (Baidu Cloud Push) channel.
    /// This message template overrides the default template for push notification
    /// channels (DefaultPushNotificationTemplate).
    baidu: ?AndroidPushNotificationTemplate,

    /// The date, in ISO 8601 format, when the message template was created.
    creation_date: []const u8,

    /// The default message template that's used for push notification channels.
    default: ?DefaultPushNotificationTemplate,

    /// The JSON object that specifies the default values that are used for message
    /// variables in the message template. This object is a set of key-value pairs.
    /// Each key defines a message variable in the template. The corresponding value
    /// defines the default value for that variable.
    default_substitutions: ?[]const u8,

    /// The message template that's used for the GCM channel, which is used to send
    /// notifications through the Firebase Cloud Messaging (FCM), formerly Google
    /// Cloud Messaging (GCM), service. This message template overrides the default
    /// template for push notification channels (DefaultPushNotificationTemplate).
    gcm: ?AndroidPushNotificationTemplate,

    /// The date, in ISO 8601 format, when the message template was last modified.
    last_modified_date: []const u8,

    /// The unique identifier for the recommender model that's used by the message
    /// template.
    recommender_id: ?[]const u8,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry,

    /// The custom description of the message template.
    template_description: ?[]const u8,

    /// The name of the message template.
    template_name: []const u8,

    /// The type of channel that the message template is designed for. For a push
    /// notification template, this value is PUSH.
    template_type: TemplateType,

    /// The unique identifier, as an integer, for the active version of the message
    /// template, or the version of the template that you specified by using the
    /// version parameter in your request.
    version: ?[]const u8,

    pub const json_field_names = .{
        .adm = "ADM",
        .apns = "APNS",
        .arn = "Arn",
        .baidu = "Baidu",
        .creation_date = "CreationDate",
        .default = "Default",
        .default_substitutions = "DefaultSubstitutions",
        .gcm = "GCM",
        .last_modified_date = "LastModifiedDate",
        .recommender_id = "RecommenderId",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .version = "Version",
    };
};
