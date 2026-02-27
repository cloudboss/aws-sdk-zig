pub const ResourceType = enum {
    batch_job,
    compliance_consent,
    domain,
    fraudster,
    session,
    speaker,
    watchlist,

    pub const json_field_names = .{
        .batch_job = "BATCH_JOB",
        .compliance_consent = "COMPLIANCE_CONSENT",
        .domain = "DOMAIN",
        .fraudster = "FRAUDSTER",
        .session = "SESSION",
        .speaker = "SPEAKER",
        .watchlist = "WATCHLIST",
    };
};
