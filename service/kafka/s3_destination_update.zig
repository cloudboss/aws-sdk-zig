/// Update payload for an Amazon S3 destination.
pub const S3DestinationUpdate = struct {
    /// The maximum time, in seconds, that records buffer in MSK before being
    /// flushed to the destination. Allowed range: 300 to 900.
    data_freshness_in_seconds: i32,

    pub const json_field_names = .{
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
    };
};
