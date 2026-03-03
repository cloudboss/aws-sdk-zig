const SubtitleFormat = @import("subtitle_format.zig").SubtitleFormat;

/// Generate subtitles for your media file with your transcription request.
///
/// You can choose a start index of 0 or 1, and you can specify either WebVTT or
/// SubRip
/// (or both) as your output format.
///
/// Note that your subtitle files are placed in the same location as your
/// transcription
/// output.
pub const Subtitles = struct {
    /// Specify the output format for your subtitle file; if you select both WebVTT
    /// (`vtt`) and SubRip (`srt`) formats, two output files are
    /// generated.
    formats: ?[]const SubtitleFormat = null,

    /// Specify the starting value that is assigned to the first subtitle segment.
    ///
    /// The default start index for Amazon Transcribe is `0`, which differs from
    /// the more widely used standard of `1`. If you're uncertain which value to
    /// use,
    /// we recommend choosing `1`, as this may improve compatibility with other
    /// services.
    output_start_index: ?i32 = null,

    pub const json_field_names = .{
        .formats = "Formats",
        .output_start_index = "OutputStartIndex",
    };
};
