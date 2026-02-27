/// Use Source to set how timecodes are handled within this job. To make sure
/// that your video, audio, captions, and markers are synchronized and that
/// time-based features, such as image inserter, work correctly, choose the
/// Timecode source option that matches your assets. All timecodes are in a
/// 24-hour format with frame number (HH:MM:SS:FF). * Embedded - Use the
/// timecode that is in the input video. If no embedded timecode is in the
/// source, the service will use Start at 0 instead. * Start at 0 - Set the
/// timecode of the initial frame to 00:00:00:00. * Specified Start - Set the
/// timecode of the initial frame to a value other than zero. You use Start
/// timecode to provide this value.
pub const TimecodeSource = enum {
    embedded,
    zerobased,
    specifiedstart,

    pub const json_field_names = .{
        .embedded = "EMBEDDED",
        .zerobased = "ZEROBASED",
        .specifiedstart = "SPECIFIEDSTART",
    };
};
