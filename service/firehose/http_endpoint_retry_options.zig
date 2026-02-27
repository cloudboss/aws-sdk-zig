/// Describes the retry behavior in case Firehose is unable to deliver data to
/// the specified HTTP endpoint destination, or if it doesn't receive a valid
/// acknowledgment of
/// receipt from the specified HTTP endpoint destination.
pub const HttpEndpointRetryOptions = struct {
    /// The total amount of time that Firehose spends on retries. This duration
    /// starts after the initial attempt to send data to the custom destination via
    /// HTTPS endpoint
    /// fails. It doesn't include the periods during which Firehose waits for
    /// acknowledgment from the specified destination after each attempt.
    duration_in_seconds: ?i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
