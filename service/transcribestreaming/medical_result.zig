const MedicalAlternative = @import("medical_alternative.zig").MedicalAlternative;

/// The `Result` associated with a
/// ``.
///
/// Contains a set of transcription results from one or more audio segments,
/// along with
/// additional information per your request parameters. This can include
/// information relating to
/// alternative transcriptions, channel identification, partial result
/// stabilization, language
/// identification, and other transcription-related data.
pub const MedicalResult = struct {
    /// A list of possible alternative transcriptions for the input audio. Each
    /// alternative may
    /// contain one or more of `Items`, `Entities`, or
    /// `Transcript`.
    alternatives: ?[]const MedicalAlternative = null,

    /// Indicates the channel identified for the `Result`.
    channel_id: ?[]const u8 = null,

    /// The end time, in seconds, of the `Result`.
    end_time: f64 = 0,

    /// Indicates if the segment is complete.
    ///
    /// If `IsPartial` is `true`, the segment is not complete. If
    /// `IsPartial` is `false`, the segment is complete.
    is_partial: bool = false,

    /// Provides a unique identifier for the `Result`.
    result_id: ?[]const u8 = null,

    /// The start time, in seconds, of the `Result`.
    start_time: f64 = 0,

    pub const json_field_names = .{
        .alternatives = "Alternatives",
        .channel_id = "ChannelId",
        .end_time = "EndTime",
        .is_partial = "IsPartial",
        .result_id = "ResultId",
        .start_time = "StartTime",
    };
};
