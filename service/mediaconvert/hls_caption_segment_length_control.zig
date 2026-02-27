/// Set Caption segment length control to Match video to create caption segments
/// that align with the video segments from the first video output in this
/// output group. For example, if the video segments are 2 seconds long, your
/// WebVTT segments will also be 2 seconds long. Keep the default setting, Large
/// segments to create caption segments that are 300 seconds long.
pub const HlsCaptionSegmentLengthControl = enum {
    large_segments,
    match_video,

    pub const json_field_names = .{
        .large_segments = "LARGE_SEGMENTS",
        .match_video = "MATCH_VIDEO",
    };
};
