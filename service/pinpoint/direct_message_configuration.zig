const ADMMessage = @import("adm_message.zig").ADMMessage;
const APNSMessage = @import("apns_message.zig").APNSMessage;
const BaiduMessage = @import("baidu_message.zig").BaiduMessage;
const DefaultMessage = @import("default_message.zig").DefaultMessage;
const DefaultPushNotificationMessage = @import("default_push_notification_message.zig").DefaultPushNotificationMessage;
const EmailMessage = @import("email_message.zig").EmailMessage;
const GCMMessage = @import("gcm_message.zig").GCMMessage;
const SMSMessage = @import("sms_message.zig").SMSMessage;
const VoiceMessage = @import("voice_message.zig").VoiceMessage;

/// Specifies the settings and content for the default message and any default
/// messages that you tailored for specific channels.
pub const DirectMessageConfiguration = struct {
    /// The default push notification message for the ADM (Amazon Device Messaging)
    /// channel. This message overrides the default push notification message
    /// (DefaultPushNotificationMessage).
    adm_message: ?ADMMessage = null,

    /// The default push notification message for the APNs (Apple Push Notification
    /// service) channel. This message overrides the default push notification
    /// message (DefaultPushNotificationMessage).
    apns_message: ?APNSMessage = null,

    /// The default push notification message for the Baidu (Baidu Cloud Push)
    /// channel. This message overrides the default push notification message
    /// (DefaultPushNotificationMessage).
    baidu_message: ?BaiduMessage = null,

    /// The default message for all channels.
    default_message: ?DefaultMessage = null,

    /// The default push notification message for all push notification channels.
    default_push_notification_message: ?DefaultPushNotificationMessage = null,

    /// The default message for the email channel. This message overrides the
    /// default message (DefaultMessage).
    email_message: ?EmailMessage = null,

    /// The default push notification message for the GCM channel, which is used to
    /// send notifications through the Firebase Cloud Messaging (FCM), formerly
    /// Google Cloud Messaging (GCM), service. This message overrides the default
    /// push notification message (DefaultPushNotificationMessage).
    gcm_message: ?GCMMessage = null,

    /// The default message for the SMS channel. This message overrides the default
    /// message (DefaultMessage).
    sms_message: ?SMSMessage = null,

    /// The default message for the voice channel. This message overrides the
    /// default message (DefaultMessage).
    voice_message: ?VoiceMessage = null,

    pub const json_field_names = .{
        .adm_message = "ADMMessage",
        .apns_message = "APNSMessage",
        .baidu_message = "BaiduMessage",
        .default_message = "DefaultMessage",
        .default_push_notification_message = "DefaultPushNotificationMessage",
        .email_message = "EmailMessage",
        .gcm_message = "GCMMessage",
        .sms_message = "SMSMessage",
        .voice_message = "VoiceMessage",
    };
};
