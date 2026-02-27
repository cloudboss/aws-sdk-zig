const JobsQueryFilterKey = @import("jobs_query_filter_key.zig").JobsQueryFilterKey;

/// Provide one or more JobsQueryFilter objects, each containing a Key with an
/// associated Values array. Note that MediaConvert queries jobs using OR logic.
pub const JobsQueryFilter = struct {
    /// Specify job details to filter for while performing a jobs query. You specify
    /// these filters as part of a key-value pair within the JobsQueryFilter array.
    /// The following list describes which keys are available and their possible
    /// values: * queue - Your Queue's name or ARN. * status - Your job's status.
    /// (SUBMITTED | PROGRESSING | COMPLETE | CANCELED | ERROR) * fileInput - Your
    /// input file URL, or partial input file name. * jobEngineVersionRequested -
    /// The Job engine version that you requested for your job. Valid versions are
    /// in a YYYY-MM-DD format. * jobEngineVersionUsed - The Job engine version that
    /// your job used. This may differ from the version that you requested. Valid
    /// versions are in a YYYY-MM-DD format. * audioCodec - Your output's audio
    /// codec. (AAC | MP2 | MP3 | WAV | AIFF | AC3| EAC3 | EAC3_ATMOS | VORBIS |
    /// OPUS | PASSTHROUGH | FLAC) * videoCodec - Your output's video codec. (AV1 |
    /// AVC_INTRA | FRAME_CAPTURE | H_264 | H_265 | MPEG2 | PASSTHROUGH | PRORES |
    /// UNCOMPRESSED | VC3 | VP8 | VP9 | XAVC)
    key: ?JobsQueryFilterKey,

    /// A list of values associated with a JobsQueryFilterKey.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
