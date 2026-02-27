pub const RuleStringEmailAttribute = enum {
    mail_from,
    helo,
    recipient,
    sender,
    from,
    subject,
    to,
    cc,

    pub const json_field_names = .{
        .mail_from = "MAIL_FROM",
        .helo = "HELO",
        .recipient = "RECIPIENT",
        .sender = "SENDER",
        .from = "FROM",
        .subject = "SUBJECT",
        .to = "TO",
        .cc = "CC",
    };
};
