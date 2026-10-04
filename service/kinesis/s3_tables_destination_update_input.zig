/// The updated configuration for a streaming table destination. Used in
/// UpdateChannel. Only `DataFreshnessInSeconds` can be updated.
pub const S3TablesDestinationUpdateInput = struct {
    /// The maximum age, in seconds, of undelivered data before the channel delivers
    /// it to the destination.
    data_freshness_in_seconds: i32,

    pub const json_field_names = .{
        .data_freshness_in_seconds = "DataFreshnessInSeconds",
    };
};
