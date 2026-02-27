pub const FileUseCaseType = enum {
    email_message,
    attachment,

    pub const json_field_names = .{
        .email_message = "EMAIL_MESSAGE",
        .attachment = "ATTACHMENT",
    };
};
