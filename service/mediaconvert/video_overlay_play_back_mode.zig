/// Specify whether your video overlay repeats or plays only once. To repeat
/// your video overlay on a loop: Keep the default value, Repeat. Your overlay
/// will repeat for the duration of the base input video. To playback your video
/// overlay only once: Choose Once. With either option, you can end playback at
/// a time that you specify by entering a value for End timecode.
pub const VideoOverlayPlayBackMode = enum {
    once,
    repeat,

    pub const json_field_names = .{
        .once = "ONCE",
        .repeat = "REPEAT",
    };
};
