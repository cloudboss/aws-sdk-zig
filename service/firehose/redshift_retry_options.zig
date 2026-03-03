/// Configures retry behavior in case Firehose is unable to deliver
/// documents to Amazon Redshift.
pub const RedshiftRetryOptions = struct {
    /// The length of time during which Firehose retries delivery after a
    /// failure, starting from the initial request and including the first attempt.
    /// The default
    /// value is 3600 seconds (60 minutes). Firehose does not retry if the value of
    /// `DurationInSeconds` is 0 (zero) or if the first delivery attempt takes
    /// longer
    /// than the current value.
    duration_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
