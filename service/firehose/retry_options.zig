/// The retry behavior in case Firehose is unable to deliver data to a
/// destination.
pub const RetryOptions = struct {
    /// The period of time during which Firehose retries to deliver data to the
    /// specified destination.
    duration_in_seconds: ?i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
