pub const RuleVerdict = enum {
    pass,
    fail,
    gray,
    processing_failed,

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
        .gray = "GRAY",
        .processing_failed = "PROCESSING_FAILED",
    };
};
