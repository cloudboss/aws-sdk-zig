const AbsoluteTimeRange = @import("absolute_time_range.zig").AbsoluteTimeRange;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RelativeTimeRange = @import("relative_time_range.zig").RelativeTimeRange;

/// Flag the presence or absence of interruptions in your Call Analytics
/// transcription
/// output.
///
/// Rules using `InterruptionFilter` are designed to match:
///
/// * Instances where an agent interrupts a customer
///
/// * Instances where a customer interrupts an agent
///
/// * Either participant interrupting the other
///
/// * A lack of interruptions
///
/// See [Rule criteria for post-call
/// categories](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html#tca-rules-batch) for usage examples.
pub const InterruptionFilter = struct {
    /// Makes it possible to specify a time range (in milliseconds) in your audio,
    /// during
    /// which you want to search for an interruption. See for more detail.
    absolute_time_range: ?AbsoluteTimeRange = null,

    /// Set to `TRUE` to flag speech that does not contain interruptions. Set to
    /// `FALSE` to flag speech that contains interruptions.
    negate: ?bool = null,

    /// Specify the interrupter that you want to flag. Omitting this parameter is
    /// equivalent
    /// to specifying both participants.
    participant_role: ?ParticipantRole = null,

    /// Makes it possible to specify a time range (in percentage) in your media
    /// file, during
    /// which you want to search for an interruption. See for more detail.
    relative_time_range: ?RelativeTimeRange = null,

    /// Specify the duration of the interruptions in milliseconds. For example, you
    /// can flag
    /// speech that contains more than 10,000 milliseconds of interruptions.
    threshold: ?i64 = null,

    pub const json_field_names = .{
        .absolute_time_range = "AbsoluteTimeRange",
        .negate = "Negate",
        .participant_role = "ParticipantRole",
        .relative_time_range = "RelativeTimeRange",
        .threshold = "Threshold",
    };
};
