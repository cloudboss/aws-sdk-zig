pub const VideoExtractionType = enum {
    transcript,
    summary,

    pub const json_field_names = .{
        .transcript = "TRANSCRIPT",
        .summary = "SUMMARY",
    };
};
