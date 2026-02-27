const ShotSegment = @import("shot_segment.zig").ShotSegment;
const TechnicalCueSegment = @import("technical_cue_segment.zig").TechnicalCueSegment;
const SegmentType = @import("segment_type.zig").SegmentType;

/// A technical cue or shot detection segment detected in a video. An array
/// of `SegmentDetection` objects containing all segments detected in a stored
/// video
/// is returned by GetSegmentDetection.
pub const SegmentDetection = struct {
    /// The duration of a video segment, expressed in frames.
    duration_frames: ?i64,

    /// The duration of the detected segment in milliseconds.
    duration_millis: ?i64,

    /// The duration of the timecode for the detected segment in SMPTE format.
    duration_smpte: ?[]const u8,

    /// The frame number at the end of a video segment, using a frame index that
    /// starts with 0.
    end_frame_number: ?i64,

    /// The frame-accurate SMPTE timecode, from the start of a video, for the end of
    /// a detected segment.
    /// `EndTimecode` is in *HH:MM:SS:fr* format
    /// (and *;fr* for drop frame-rates).
    end_timecode_smpte: ?[]const u8,

    /// The end time of the detected segment, in milliseconds, from the start of the
    /// video.
    /// This value is rounded down.
    end_timestamp_millis: i64 = 0,

    /// If the segment is a shot detection, contains information about the shot
    /// detection.
    shot_segment: ?ShotSegment,

    /// The frame number of the start of a video segment, using a frame index that
    /// starts with 0.
    start_frame_number: ?i64,

    /// The frame-accurate SMPTE timecode, from the start of a video, for the start
    /// of a detected segment.
    /// `StartTimecode` is in *HH:MM:SS:fr* format
    /// (and *;fr* for drop frame-rates).
    start_timecode_smpte: ?[]const u8,

    /// The start time of the detected segment in milliseconds from the start of the
    /// video. This value
    /// is rounded down. For example, if the actual timestamp is 100.6667
    /// milliseconds, Amazon Rekognition Video returns a value of
    /// 100 millis.
    start_timestamp_millis: i64 = 0,

    /// If the segment is a technical cue, contains information about the technical
    /// cue.
    technical_cue_segment: ?TechnicalCueSegment,

    /// The type of the segment. Valid values are `TECHNICAL_CUE` and `SHOT`.
    type: ?SegmentType,

    pub const json_field_names = .{
        .duration_frames = "DurationFrames",
        .duration_millis = "DurationMillis",
        .duration_smpte = "DurationSMPTE",
        .end_frame_number = "EndFrameNumber",
        .end_timecode_smpte = "EndTimecodeSMPTE",
        .end_timestamp_millis = "EndTimestampMillis",
        .shot_segment = "ShotSegment",
        .start_frame_number = "StartFrameNumber",
        .start_timecode_smpte = "StartTimecodeSMPTE",
        .start_timestamp_millis = "StartTimestampMillis",
        .technical_cue_segment = "TechnicalCueSegment",
        .type = "Type",
    };
};
