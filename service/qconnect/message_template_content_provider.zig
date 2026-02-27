const EmailMessageTemplateContent = @import("email_message_template_content.zig").EmailMessageTemplateContent;
const PushMessageTemplateContent = @import("push_message_template_content.zig").PushMessageTemplateContent;
const SMSMessageTemplateContent = @import("sms_message_template_content.zig").SMSMessageTemplateContent;
const WhatsAppMessageTemplateContent = @import("whats_app_message_template_content.zig").WhatsAppMessageTemplateContent;

/// The container of message template content.
pub const MessageTemplateContentProvider = union(enum) {
    /// The content of the message template that applies to the email channel
    /// subtype.
    email: ?EmailMessageTemplateContent,
    push: ?PushMessageTemplateContent,
    /// The content of the message template that applies to the SMS channel subtype.
    sms: ?SMSMessageTemplateContent,
    /// The content of the message template that applies to the WHATSAPP channel
    /// subtype.
    whats_app: ?WhatsAppMessageTemplateContent,

    pub const json_field_names = .{
        .email = "email",
        .push = "push",
        .sms = "sms",
        .whats_app = "whatsApp",
    };
};
