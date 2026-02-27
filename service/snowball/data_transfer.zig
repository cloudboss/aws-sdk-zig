/// Defines the real-time status of a Snow device's data transfer while the
/// device is at
/// Amazon Web Services. This data is only available while a job has a
/// `JobState`
/// value of `InProgress`, for both import and export jobs.
pub const DataTransfer = struct {
    /// The number of bytes transferred between a Snow device and Amazon S3.
    bytes_transferred: i64 = 0,

    /// The number of objects transferred between a Snow device and Amazon S3.
    objects_transferred: i64 = 0,

    /// The total bytes of data for a transfer between a Snow device and Amazon S3.
    /// This value
    /// is set to 0 (zero) until all the keys that will be transferred have been
    /// listed.
    total_bytes: i64 = 0,

    /// The total number of objects for a transfer between a Snow device and Amazon
    /// S3. This
    /// value is set to 0 (zero) until all the keys that will be transferred have
    /// been
    /// listed.
    total_objects: i64 = 0,

    pub const json_field_names = .{
        .bytes_transferred = "BytesTransferred",
        .objects_transferred = "ObjectsTransferred",
        .total_bytes = "TotalBytes",
        .total_objects = "TotalObjects",
    };
};
