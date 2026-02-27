pub const EmailHeaderType = enum {
    references,
    message_id,
    in_reply_to,
    x_ses_spam_verdict,
    x_ses_virus_verdict,

    pub const json_field_names = .{
        .references = "REFERENCES",
        .message_id = "MESSAGE_ID",
        .in_reply_to = "IN_REPLY_TO",
        .x_ses_spam_verdict = "X_SES_SPAM_VERDICT",
        .x_ses_virus_verdict = "X_SES_VIRUS_VERDICT",
    };
};
