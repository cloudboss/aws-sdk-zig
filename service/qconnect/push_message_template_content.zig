const PushADMMessageTemplateContent = @import("push_adm_message_template_content.zig").PushADMMessageTemplateContent;
const PushAPNSMessageTemplateContent = @import("push_apns_message_template_content.zig").PushAPNSMessageTemplateContent;
const PushBaiduMessageTemplateContent = @import("push_baidu_message_template_content.zig").PushBaiduMessageTemplateContent;
const PushFCMMessageTemplateContent = @import("push_fcm_message_template_content.zig").PushFCMMessageTemplateContent;

/// The content of the message template that applies to the push channel
/// subtype.
pub const PushMessageTemplateContent = struct {
    /// The content of the message template that applies to ADM (Amazon Device
    /// Messaging) notification service.
    adm: ?PushADMMessageTemplateContent = null,

    /// The content of the message template that applies to APNS(Apple Push
    /// Notification service) notification service.
    apns: ?PushAPNSMessageTemplateContent = null,

    /// The content of the message template that applies to Baidu notification
    /// service.
    baidu: ?PushBaiduMessageTemplateContent = null,

    /// The content of the message template that applies to FCM (Firebase Cloud
    /// Messaging) notification service.
    fcm: ?PushFCMMessageTemplateContent = null,

    pub const json_field_names = .{
        .adm = "adm",
        .apns = "apns",
        .baidu = "baidu",
        .fcm = "fcm",
    };
};
