pub const RuleAddressListEmailAttribute = enum {
    recipient,
    mail_from,
    sender,
    from,
    to,
    cc,

    pub const json_field_names = .{
        .recipient = "RECIPIENT",
        .mail_from = "MAIL_FROM",
        .sender = "SENDER",
        .from = "FROM",
        .to = "TO",
        .cc = "CC",
    };
};
