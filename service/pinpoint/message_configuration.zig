const Message = @import("message.zig").Message;
const CampaignCustomMessage = @import("campaign_custom_message.zig").CampaignCustomMessage;
const CampaignEmailMessage = @import("campaign_email_message.zig").CampaignEmailMessage;
const CampaignInAppMessage = @import("campaign_in_app_message.zig").CampaignInAppMessage;
const CampaignSmsMessage = @import("campaign_sms_message.zig").CampaignSmsMessage;

/// Specifies the message configuration settings for a campaign.
pub const MessageConfiguration = struct {
    /// The message that the campaign sends through the ADM (Amazon Device
    /// Messaging) channel. If specified, this message overrides the default
    /// message.
    adm_message: ?Message = null,

    /// The message that the campaign sends through the APNs (Apple Push
    /// Notification service) channel. If specified, this message overrides the
    /// default message.
    apns_message: ?Message = null,

    /// The message that the campaign sends through the Baidu (Baidu Cloud Push)
    /// channel. If specified, this message overrides the default message.
    baidu_message: ?Message = null,

    /// The message that the campaign sends through a custom channel, as specified
    /// by the delivery configuration (CustomDeliveryConfiguration) settings for the
    /// campaign. If specified, this message overrides the default message.
    custom_message: ?CampaignCustomMessage = null,

    /// The default message that the campaign sends through all the channels that
    /// are configured for the campaign.
    default_message: ?Message = null,

    /// The message that the campaign sends through the email channel. If specified,
    /// this message overrides the default message.
    email_message: ?CampaignEmailMessage = null,

    /// The message that the campaign sends through the GCM channel, which enables
    /// Amazon Pinpoint to send push notifications through the Firebase Cloud
    /// Messaging (FCM), formerly Google Cloud Messaging (GCM), service. If
    /// specified, this message overrides the default message.
    gcm_message: ?Message = null,

    /// The in-app message configuration.
    in_app_message: ?CampaignInAppMessage = null,

    /// The message that the campaign sends through the SMS channel. If specified,
    /// this message overrides the default message.
    sms_message: ?CampaignSmsMessage = null,

    pub const json_field_names = .{
        .adm_message = "ADMMessage",
        .apns_message = "APNSMessage",
        .baidu_message = "BaiduMessage",
        .custom_message = "CustomMessage",
        .default_message = "DefaultMessage",
        .email_message = "EmailMessage",
        .gcm_message = "GCMMessage",
        .in_app_message = "InAppMessage",
        .sms_message = "SMSMessage",
    };
};
