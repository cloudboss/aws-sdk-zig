/// This data type contains information about progress of an operation.
pub const Progress = struct {
    /// The current number of uncompressed object bytes processed.
    bytes_processed: ?i64,

    /// The current number of bytes of records payload data returned.
    bytes_returned: ?i64,

    /// The current number of object bytes scanned.
    bytes_scanned: ?i64,
};
