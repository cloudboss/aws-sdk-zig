const AbsoluteTimeRange = @import("absolute_time_range.zig").AbsoluteTimeRange;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RelativeTimeRange = @import("relative_time_range.zig").RelativeTimeRange;
const SentimentValue = @import("sentiment_value.zig").SentimentValue;

/// Flag the presence or absence of specific sentiments detected in your Call
/// Analytics
/// transcription output.
///
/// Rules using `SentimentFilter` are designed to match:
///
/// * The presence or absence of a positive sentiment felt by the customer,
///   agent,
/// or both at specified points in the call
///
/// * The presence or absence of a negative sentiment felt by the customer,
///   agent,
/// or both at specified points in the call
///
/// * The presence or absence of a neutral sentiment felt by the customer,
///   agent, or
/// both at specified points in the call
///
/// * The presence or absence of a mixed sentiment felt by the customer, the
///   agent,
/// or both at specified points in the call
///
/// See [Rule criteria for post-call
/// categories](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html#tca-rules-batch) for usage examples.
pub const SentimentFilter = struct {
    /// Makes it possible to specify a time range (in milliseconds) in your audio,
    /// during
    /// which you want to search for the specified sentiments. See for more detail.
    absolute_time_range: ?AbsoluteTimeRange = null,

    /// Set to `TRUE` to flag the sentiments that you didn't include in your
    /// request. Set to `FALSE` to flag the sentiments that you specified in your
    /// request.
    negate: ?bool = null,

    /// Specify the participant that you want to flag. Omitting this parameter is
    /// equivalent
    /// to specifying both participants.
    participant_role: ?ParticipantRole = null,

    /// Makes it possible to specify a time range (in percentage) in your media
    /// file, during
    /// which you want to search for the specified sentiments. See for more detail.
    relative_time_range: ?RelativeTimeRange = null,

    /// Specify the sentiments that you want to flag.
    sentiments: []const SentimentValue,

    pub const json_field_names = .{
        .absolute_time_range = "AbsoluteTimeRange",
        .negate = "Negate",
        .participant_role = "ParticipantRole",
        .relative_time_range = "RelativeTimeRange",
        .sentiments = "Sentiments",
    };
};
