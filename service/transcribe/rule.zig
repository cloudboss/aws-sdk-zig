const InterruptionFilter = @import("interruption_filter.zig").InterruptionFilter;
const NonTalkTimeFilter = @import("non_talk_time_filter.zig").NonTalkTimeFilter;
const SentimentFilter = @import("sentiment_filter.zig").SentimentFilter;
const TranscriptFilter = @import("transcript_filter.zig").TranscriptFilter;

/// A rule is a set of criteria that you can specify to flag an attribute in
/// your Call
/// Analytics output. Rules define a Call Analytics category.
///
/// Rules can include these parameters: , , , and .
///
/// To learn more about Call Analytics rules and categories, see [Creating
/// categories for post-call
/// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-batch.html) and [Creating categories for
/// real-time
/// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-categories-stream.html).
///
/// To learn more about Call Analytics, see [Analyzing call center audio with
/// Call
/// Analytics](https://docs.aws.amazon.com/transcribe/latest/dg/call-analytics.html).
pub const Rule = union(enum) {
    /// Flag the presence or absence of interruptions in your Call Analytics
    /// transcription
    /// output. Refer to for more detail.
    interruption_filter: ?InterruptionFilter,
    /// Flag the presence or absence of periods of silence in your Call Analytics
    /// transcription output. Refer to for more
    /// detail.
    non_talk_time_filter: ?NonTalkTimeFilter,
    /// Flag the presence or absence of specific sentiments in your Call Analytics
    /// transcription output. Refer to for more
    /// detail.
    sentiment_filter: ?SentimentFilter,
    /// Flag the presence or absence of specific words or phrases in your Call
    /// Analytics
    /// transcription output. Refer to for more
    /// detail.
    transcript_filter: ?TranscriptFilter,

    pub const json_field_names = .{
        .interruption_filter = "InterruptionFilter",
        .non_talk_time_filter = "NonTalkTimeFilter",
        .sentiment_filter = "SentimentFilter",
        .transcript_filter = "TranscriptFilter",
    };
};
