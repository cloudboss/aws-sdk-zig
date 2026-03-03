/// Settings to identify the start of the clip.
pub const StartTimecode = struct {
    /// The timecode for the frame where you want to start the clip. Optional; if
    /// not specified, the clip starts at first frame in the file. Enter the
    /// timecode as HH:MM:SS:FF or HH:MM:SS;FF.
    timecode: ?[]const u8 = null,

    pub const json_field_names = .{
        .timecode = "Timecode",
    };
};
