/// Contains the number of log events scanned by the query, the number of log
/// events that
/// matched the query criteria, and the total number of bytes in the log events
/// that were
/// scanned.
///
/// If the query involved log groups that have field index policies, the
/// estimated number of
/// skipped log events and the total bytes of those skipped log events are
/// included. Using field
/// indexes to skip log events in queries reduces scan volume and improves
/// performance. For more
/// information, see [Create field indexes
/// to improve query performance and reduce scan
/// volume](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogs-Field-Indexing.html).
pub const QueryStatistics = struct {
    /// The total number of bytes in the log events scanned during the query.
    bytes_scanned: f64 = 0,

    /// An estimate of the number of bytes in the log events that were skipped when
    /// processing
    /// this query, because the query contained an indexed field. Skipping these
    /// entries lowers query
    /// costs and improves the query performance time. For more information about
    /// field indexes, see
    /// [PutIndexPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutIndexPolicy.html).
    estimated_bytes_skipped: f64 = 0,

    /// An estimate of the number of log events that were skipped when processing
    /// this query,
    /// because the query contained an indexed field. Skipping these entries lowers
    /// query costs and
    /// improves the query performance time. For more information about field
    /// indexes, see
    /// [PutIndexPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutIndexPolicy.html).
    estimated_records_skipped: f64 = 0,

    /// The number of log groups that were scanned by this query.
    log_groups_scanned: f64 = 0,

    /// The number of log events that matched the query string.
    records_matched: f64 = 0,

    /// The total number of log events scanned during the query.
    records_scanned: f64 = 0,

    pub const json_field_names = .{
        .bytes_scanned = "bytesScanned",
        .estimated_bytes_skipped = "estimatedBytesSkipped",
        .estimated_records_skipped = "estimatedRecordsSkipped",
        .log_groups_scanned = "logGroupsScanned",
        .records_matched = "recordsMatched",
        .records_scanned = "recordsScanned",
    };
};
