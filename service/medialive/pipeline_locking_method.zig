/// Pipeline Locking Method
pub const PipelineLockingMethod = enum {
    source_timecode,
    video_alignment,

    pub const json_field_names = .{
        .source_timecode = "SOURCE_TIMECODE",
        .video_alignment = "VIDEO_ALIGNMENT",
    };
};
