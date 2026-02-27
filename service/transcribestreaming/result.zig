const Alternative = @import("alternative.zig").Alternative;
const LanguageCode = @import("language_code.zig").LanguageCode;
const LanguageWithScore = @import("language_with_score.zig").LanguageWithScore;

/// The `Result` associated with a
/// ``.
///
/// Contains a set of transcription results from one or more audio segments,
/// along with additional
/// information per your request parameters. This can include information
/// relating to alternative
/// transcriptions, channel identification, partial result stabilization,
/// language identification, and other
/// transcription-related data.
pub const Result = struct {
    /// A list of possible alternative transcriptions for the input audio. Each
    /// alternative may contain
    /// one or more of `Items`, `Entities`, or `Transcript`.
    alternatives: ?[]const Alternative,

    /// Indicates which audio channel is associated with the `Result`.
    channel_id: ?[]const u8,

    /// The end time of the `Result` in seconds, with millisecond precision (e.g.,
    /// 1.056).
    end_time: f64 = 0,

    /// Indicates if the segment is complete.
    ///
    /// If `IsPartial` is `true`, the segment is not complete. If
    /// `IsPartial` is `false`, the segment is complete.
    is_partial: bool = false,

    /// The language code that represents the language spoken in your audio stream.
    language_code: ?LanguageCode,

    /// The language code of the dominant language identified in your stream.
    ///
    /// If you enabled channel identification and each channel of your audio
    /// contains a different language,
    /// you may have more than one result.
    language_identification: ?[]const LanguageWithScore,

    /// Provides a unique identifier for the `Result`.
    result_id: ?[]const u8,

    /// The start time of the `Result` in seconds, with millisecond precision (e.g.,
    /// 1.056).
    start_time: f64 = 0,

    pub const json_field_names = .{
        .alternatives = "Alternatives",
        .channel_id = "ChannelId",
        .end_time = "EndTime",
        .is_partial = "IsPartial",
        .language_code = "LanguageCode",
        .language_identification = "LanguageIdentification",
        .result_id = "ResultId",
        .start_time = "StartTime",
    };
};
