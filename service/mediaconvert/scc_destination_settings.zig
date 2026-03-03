const SccDestinationFramerate = @import("scc_destination_framerate.zig").SccDestinationFramerate;

/// Settings related to SCC captions. SCC is a sidecar format that holds
/// captions in a file that is separate from the video container. Set up sidecar
/// captions in the same output group, but different output from your video. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/scc-srt-output-captions.html.
pub const SccDestinationSettings = struct {
    /// Set Framerate to make sure that the captions and the video are synchronized
    /// in the output. Specify a frame rate that matches the frame rate of the
    /// associated video. If the video frame rate is 29.97, choose 29.97 dropframe
    /// only if the video has video_insertion=true and drop_frame_timecode=true;
    /// otherwise, choose 29.97 non-dropframe.
    framerate: ?SccDestinationFramerate = null,

    pub const json_field_names = .{
        .framerate = "Framerate",
    };
};
