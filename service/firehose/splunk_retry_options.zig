/// Configures retry behavior in case Firehose is unable to deliver
/// documents to Splunk, or if it doesn't receive an acknowledgment from Splunk.
pub const SplunkRetryOptions = struct {
    /// The total amount of time that Firehose spends on retries. This duration
    /// starts after the initial attempt to send data to Splunk fails. It doesn't
    /// include the
    /// periods during which Firehose waits for acknowledgment from Splunk after
    /// each
    /// attempt.
    duration_in_seconds: ?i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
