/// Provides summary information for aggregated utterances. The
/// `ListAggregatedUtterances` operations combines all
/// instances of the same utterance into a single aggregated
/// summary.
pub const AggregatedUtterancesSummary = struct {
    /// Aggregated utterance data may contain utterances from versions of
    /// your bot that have since been deleted. When the aggregated contains
    /// this kind of data, this field is set to true.
    contains_data_from_deleted_resources: ?bool,

    /// The number of times that the utterance was detected by Amazon Lex during
    /// the time period. When an utterance is detected, it activates an intent
    /// or a slot.
    hit_count: ?i32,

    /// The number of times that the utterance was missed by Amazon Lex An
    /// utterance is missed when it doesn't activate an intent or slot.
    missed_count: ?i32,

    /// The text of the utterance. If the utterance was used with the
    /// `RecognizeUtterance` operation, the text is the
    /// transcription of the audio utterance.
    utterance: ?[]const u8,

    /// The date and time that the utterance was first recorded in the time
    /// window for aggregation. An utterance may have been sent to Amazon Lex before
    /// that time, but only utterances within the time window are
    /// counted.
    utterance_first_recorded_in_aggregation_duration: ?i64,

    /// The last date and time that an utterance was recorded in the time
    /// window for aggregation. An utterance may be sent to Amazon Lex after that
    /// time, but only utterances within the time window are counted.
    utterance_last_recorded_in_aggregation_duration: ?i64,

    pub const json_field_names = .{
        .contains_data_from_deleted_resources = "containsDataFromDeletedResources",
        .hit_count = "hitCount",
        .missed_count = "missedCount",
        .utterance = "utterance",
        .utterance_first_recorded_in_aggregation_duration = "utteranceFirstRecordedInAggregationDuration",
        .utterance_last_recorded_in_aggregation_duration = "utteranceLastRecordedInAggregationDuration",
    };
};
