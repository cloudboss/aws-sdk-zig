/// The billable token usage for a training session, broken down by operation
/// type.
pub const BillableTokenUsage = struct {
    /// The number of prefill tokens consumed.
    prefill_token_count: ?i64 = null,

    /// The number of sample tokens consumed.
    sample_token_count: ?i64 = null,

    /// The number of training tokens consumed.
    training_token_count: ?i64 = null,

    pub const json_field_names = .{
        .prefill_token_count = "PrefillTokenCount",
        .sample_token_count = "SampleTokenCount",
        .training_token_count = "TrainingTokenCount",
    };
};
