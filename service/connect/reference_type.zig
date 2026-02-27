pub const ReferenceType = enum {
    url,
    attachment,
    contact_analysis,
    number,
    string,
    date,
    email,
    email_message,
    email_message_plain_text,

    pub const json_field_names = .{
        .url = "URL",
        .attachment = "ATTACHMENT",
        .contact_analysis = "CONTACT_ANALYSIS",
        .number = "NUMBER",
        .string = "STRING",
        .date = "DATE",
        .email = "EMAIL",
        .email_message = "EMAIL_MESSAGE",
        .email_message_plain_text = "EMAIL_MESSAGE_PLAIN_TEXT",
    };
};
