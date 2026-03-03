/// Describes the status of a cluster while it is in the process of resizing
/// with an
/// incremental resize.
pub const DataTransferProgress = struct {
    /// Describes the data transfer rate in MB's per second.
    current_rate_in_mega_bytes_per_second: ?f64 = null,

    /// Describes the total amount of data that has been transfered in MB's.
    data_transferred_in_mega_bytes: ?i64 = null,

    /// Describes the number of seconds that have elapsed during the data transfer.
    elapsed_time_in_seconds: ?i64 = null,

    /// Describes the estimated number of seconds remaining to complete the
    /// transfer.
    estimated_time_to_completion_in_seconds: ?i64 = null,

    /// Describes the status of the cluster. While the transfer is in progress the
    /// status is
    /// `transferringdata`.
    status: ?[]const u8 = null,

    /// Describes the total amount of data to be transfered in megabytes.
    total_data_in_mega_bytes: ?i64 = null,
};
