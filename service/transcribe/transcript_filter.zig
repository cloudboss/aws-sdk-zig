const AbsoluteTimeRange = @import("absolute_time_range.zig").AbsoluteTimeRange;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RelativeTimeRange = @import("relative_time_range.zig").RelativeTimeRange;
const TranscriptFilterType = @import("transcript_filter_type.zig").TranscriptFilterType;

/// Flag the presence or absence of specific words or phrases detected in your
/// Call
/// Analytics transcription output.
///
/// Rules using `TranscriptFilter` are designed to match:
///
/// * Custom words or phrases spoken by the agent, the customer, or both
///
/// * Custom words or phrases **not** spoken by the
/// agent, the customer, or either
///
/// * Custom words or phrases that occur at a specific time frame
///
/// See [Rule criteria for post-call
/// categories](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html#tca-rules-batch) and [Rule criteria for
/// streaming
/// categories](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-stream.html#tca-rules-stream) for usage examples.
pub const TranscriptFilter = struct {
    /// Makes it possible to specify a time range (in milliseconds) in your audio,
    /// during
    /// which you want to search for the specified key words or phrases. See for
    /// more detail.
    absolute_time_range: ?AbsoluteTimeRange = null,

    /// Set to `TRUE` to flag the absence of the phrase that you specified in your
    /// request. Set to `FALSE` to flag the presence of the phrase that you
    /// specified
    /// in your request.
    negate: ?bool = null,

    /// Specify the participant that you want to flag. Omitting this parameter is
    /// equivalent
    /// to specifying both participants.
    participant_role: ?ParticipantRole = null,

    /// Makes it possible to specify a time range (in percentage) in your media
    /// file, during
    /// which you want to search for the specified key words or phrases. See for
    /// more detail.
    relative_time_range: ?RelativeTimeRange = null,

    /// Specify the phrases that you want to flag.
    targets: []const []const u8,

    /// Flag the presence or absence of an exact match to the phrases that you
    /// specify. For
    /// example, if you specify the phrase "speak to a manager" as your `Targets`
    /// value, only that exact phrase is flagged.
    ///
    /// Note that semantic matching is not supported. For example, if your customer
    /// says
    /// "speak to *the* manager", instead of "speak to *a*
    /// manager", your content is not flagged.
    transcript_filter_type: TranscriptFilterType,

    pub const json_field_names = .{
        .absolute_time_range = "AbsoluteTimeRange",
        .negate = "Negate",
        .participant_role = "ParticipantRole",
        .relative_time_range = "RelativeTimeRange",
        .targets = "Targets",
        .transcript_filter_type = "TranscriptFilterType",
    };
};
