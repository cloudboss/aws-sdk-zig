/// Information about the status of the query, including progress and bytes
/// scanned.
pub const QueryStatus = struct {
    /// The amount of data scanned by the query in bytes that you will be charged
    /// for. This is
    /// a cumulative sum and represents the total amount of data that you will be
    /// charged for
    /// since the query was started. The charge is applied only once and is either
    /// applied when
    /// the query completes running or when the query is cancelled.
    cumulative_bytes_metered: i64 = 0,

    /// The amount of data scanned by the query in bytes. This is a cumulative sum
    /// and
    /// represents the total amount of bytes scanned since the query was started.
    cumulative_bytes_scanned: i64 = 0,

    /// The progress of the query, expressed as a percentage.
    progress_percentage: f64 = 0,

    pub const json_field_names = .{
        .cumulative_bytes_metered = "CumulativeBytesMetered",
        .cumulative_bytes_scanned = "CumulativeBytesScanned",
        .progress_percentage = "ProgressPercentage",
    };
};
