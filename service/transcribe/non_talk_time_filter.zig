const AbsoluteTimeRange = @import("absolute_time_range.zig").AbsoluteTimeRange;
const RelativeTimeRange = @import("relative_time_range.zig").RelativeTimeRange;

/// Flag the presence or absence of periods of silence in your Call Analytics
/// transcription output.
///
/// Rules using `NonTalkTimeFilter` are designed to match:
///
/// * The presence of silence at specified periods throughout the call
///
/// * The presence of speech at specified periods throughout the call
///
/// See [Rule criteria for post-call
/// categories](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html#tca-rules-batch) for usage examples.
pub const NonTalkTimeFilter = struct {
    /// Makes it possible to specify a time range (in milliseconds) in your audio,
    /// during
    /// which you want to search for a period of silence. See for more detail.
    absolute_time_range: ?AbsoluteTimeRange,

    /// Set to `TRUE` to flag periods of speech. Set to `FALSE` to flag
    /// periods of silence
    negate: ?bool,

    /// Makes it possible to specify a time range (in percentage) in your media
    /// file, during
    /// which you want to search for a period of silence. See for more detail.
    relative_time_range: ?RelativeTimeRange,

    /// Specify the duration, in milliseconds, of the period of silence that you
    /// want to flag.
    /// For example, you can flag a silent period that lasts 30,000 milliseconds.
    threshold: ?i64,

    pub const json_field_names = .{
        .absolute_time_range = "AbsoluteTimeRange",
        .negate = "Negate",
        .relative_time_range = "RelativeTimeRange",
        .threshold = "Threshold",
    };
};
