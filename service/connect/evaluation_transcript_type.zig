pub const EvaluationTranscriptType = enum {
    raw,
    redacted,

    pub const json_field_names = .{
        .raw = "RAW",
        .redacted = "REDACTED",
    };
};
