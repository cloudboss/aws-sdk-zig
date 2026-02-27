pub const ChannelType = enum {
    /// AWS Console Mobile App sends notifications to mobile devices.
    /// Link:https://aws.amazon.com/console/mobile/
    mobile,
    /// Chatbot sends notifications to group platforms, like Slack or Chime.
    /// Link:https://aws.amazon.com/chatbot/
    chatbot,
    /// Email sends notifications to email addresses.
    email,
    /// User Notification Service sends notifications to Account Managed contacts.
    account_contact,

    pub const json_field_names = .{
        .mobile = "MOBILE",
        .chatbot = "CHATBOT",
        .email = "EMAIL",
        .account_contact = "ACCOUNT_CONTACT",
    };
};
