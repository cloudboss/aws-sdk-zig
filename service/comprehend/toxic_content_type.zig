pub const ToxicContentType = enum {
    graphic,
    harassment_or_abuse,
    hate_speech,
    insult,
    profanity,
    sexual,
    violence_or_threat,

    pub const json_field_names = .{
        .graphic = "GRAPHIC",
        .harassment_or_abuse = "HARASSMENT_OR_ABUSE",
        .hate_speech = "HATE_SPEECH",
        .insult = "INSULT",
        .profanity = "PROFANITY",
        .sexual = "SEXUAL",
        .violence_or_threat = "VIOLENCE_OR_THREAT",
    };
};
