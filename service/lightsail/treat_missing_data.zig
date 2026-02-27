pub const TreatMissingData = enum {
    breaching,
    not_breaching,
    ignore,
    missing,

    pub const json_field_names = .{
        .breaching = "Breaching",
        .not_breaching = "NotBreaching",
        .ignore = "Ignore",
        .missing = "Missing",
    };
};
