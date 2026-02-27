pub const RealTimeContactAnalysisOutputType = enum {
    raw,
    redacted,

    pub const json_field_names = .{
        .raw = "Raw",
        .redacted = "Redacted",
    };
};
