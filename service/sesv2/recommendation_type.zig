pub const RecommendationType = enum {
    dkim,
    dmarc,
    spf,
    bimi,
    complaint,
    bounce,
    feedback_3_p,
    ip_listing,

    pub const json_field_names = .{
        .dkim = "DKIM",
        .dmarc = "DMARC",
        .spf = "SPF",
        .bimi = "BIMI",
        .complaint = "COMPLAINT",
        .bounce = "BOUNCE",
        .feedback_3_p = "FEEDBACK_3P",
        .ip_listing = "IP_LISTING",
    };
};
