/// To transcode only portions of your video overlay, include one input clip for
/// each part of your video overlay that you want in your output.
pub const VideoOverlayInputClipping = struct {
    /// Specify the timecode of the last frame to include in your video overlay's
    /// clip. Use the format HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is
    /// the minute, SS is the second, and FF is the frame number. When entering this
    /// value, take into account your choice for Timecode source.
    end_timecode: ?[]const u8 = null,

    /// Specify the timecode of the first frame to include in your video overlay's
    /// clip. Use the format HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is
    /// the minute, SS is the second, and FF is the frame number. When entering this
    /// value, take into account your choice for Timecode source.
    start_timecode: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_timecode = "EndTimecode",
        .start_timecode = "StartTimecode",
    };
};
