/// Configures retry behavior in case Firehose is unable to deliver
/// documents to Amazon OpenSearch Service.
pub const ElasticsearchRetryOptions = struct {
    /// After an initial failure to deliver to Amazon OpenSearch Service, the total
    /// amount of time during
    /// which Firehose retries delivery (including the first attempt). After this
    /// time
    /// has elapsed, the failed documents are written to Amazon S3. Default value is
    /// 300 seconds (5
    /// minutes). A value of 0 (zero) results in no retries.
    duration_in_seconds: ?i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
