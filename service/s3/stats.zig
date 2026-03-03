/// Container for the stats details.
pub const Stats = struct {
    /// The total number of uncompressed object bytes processed.
    bytes_processed: ?i64 = null,

    /// The total number of bytes of records payload data returned.
    bytes_returned: ?i64 = null,

    /// The total number of object bytes scanned.
    bytes_scanned: ?i64 = null,
};
