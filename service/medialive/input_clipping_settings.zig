const InputTimecodeSource = @import("input_timecode_source.zig").InputTimecodeSource;
const StartTimecode = @import("start_timecode.zig").StartTimecode;
const StopTimecode = @import("stop_timecode.zig").StopTimecode;

/// Settings to let you create a clip of the file input, in order to set up the
/// input to ingest only a portion of the file.
pub const InputClippingSettings = struct {
    /// The source of the timecodes in the source being clipped.
    input_timecode_source: InputTimecodeSource,

    /// Settings to identify the start of the clip.
    start_timecode: ?StartTimecode = null,

    /// Settings to identify the end of the clip.
    stop_timecode: ?StopTimecode = null,

    pub const json_field_names = .{
        .input_timecode_source = "InputTimecodeSource",
        .start_timecode = "StartTimecode",
        .stop_timecode = "StopTimecode",
    };
};
