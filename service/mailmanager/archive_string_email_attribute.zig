pub const ArchiveStringEmailAttribute = enum {
    to,
    from,
    cc,
    subject,
    envelope_to,
    envelope_from,

    pub const json_field_names = .{
        .to = "TO",
        .from = "FROM",
        .cc = "CC",
        .subject = "SUBJECT",
        .envelope_to = "ENVELOPE_TO",
        .envelope_from = "ENVELOPE_FROM",
    };
};
