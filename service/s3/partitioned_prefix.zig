const PartitionDateSource = @import("partition_date_source.zig").PartitionDateSource;

/// Amazon S3 keys for log objects are partitioned in the following format:
///
/// `[DestinationPrefix][SourceAccountId]/[SourceRegion]/[SourceBucket]/[YYYY]/[MM]/[DD]/[YYYY]-[MM]-[DD]-[hh]-[mm]-[ss]-[UniqueString]`
///
/// PartitionedPrefix defaults to EventTime delivery when server access logs are
/// delivered.
pub const PartitionedPrefix = struct {
    /// Specifies the partition date source for the partitioned prefix.
    /// `PartitionDateSource` can
    /// be `EventTime` or `DeliveryTime`.
    ///
    /// For `DeliveryTime`, the time in the log file names corresponds to the
    /// delivery time for
    /// the log files.
    ///
    /// For `EventTime`, The logs delivered are for a specific day only. The year,
    /// month, and
    /// day correspond to the day on which the event occurred, and the hour, minutes
    /// and seconds are set to 00
    /// in the key.
    partition_date_source: ?PartitionDateSource = null,
};
