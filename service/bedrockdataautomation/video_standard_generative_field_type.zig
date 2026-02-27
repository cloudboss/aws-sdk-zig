pub const VideoStandardGenerativeFieldType = enum {
    video_summary,
    iab,
    chapter_summary,

    pub const json_field_names = .{
        .video_summary = "VIDEO_SUMMARY",
        .iab = "IAB",
        .chapter_summary = "CHAPTER_SUMMARY",
    };
};
