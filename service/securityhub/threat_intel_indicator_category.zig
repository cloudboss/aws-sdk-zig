pub const ThreatIntelIndicatorCategory = enum {
    backdoor,
    card_stealer,
    command_and_control,
    drop_site,
    exploit_site,
    keylogger,

    pub const json_field_names = .{
        .backdoor = "BACKDOOR",
        .card_stealer = "CARD_STEALER",
        .command_and_control = "COMMAND_AND_CONTROL",
        .drop_site = "DROP_SITE",
        .exploit_site = "EXPLOIT_SITE",
        .keylogger = "KEYLOGGER",
    };
};
