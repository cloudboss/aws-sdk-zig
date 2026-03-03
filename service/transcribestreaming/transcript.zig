const Result = @import("result.zig").Result;

/// The `Transcript` associated with a
/// ``.
///
/// `Transcript` contains `Results`, which contains a set of transcription
/// results from one or more audio segments, along with additional information
/// per your request
/// parameters.
pub const Transcript = struct {
    /// Contains a set of transcription results from one or more audio segments,
    /// along with additional
    /// information per your request parameters. This can include information
    /// relating to alternative
    /// transcriptions, channel identification, partial result stabilization,
    /// language identification, and other
    /// transcription-related data.
    results: ?[]const Result = null,

    pub const json_field_names = .{
        .results = "Results",
    };
};
