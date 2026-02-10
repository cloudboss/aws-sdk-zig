/// The container for the records event.
pub const RecordsEvent = struct {
    /// The byte array of partial, one or more result records. S3 Select doesn't
    /// guarantee that a record
    /// will be self-contained in one record frame. To ensure continuous streaming
    /// of data, S3 Select might
    /// split the same record across multiple record frames instead of aggregating
    /// the results in memory. Some
    /// S3 clients (for example, the SDK for Java) handle this behavior by creating
    /// a
    /// `ByteStream` out of the response by default. Other clients might not handle
    /// this behavior
    /// by default. In those cases, you must aggregate the results on the client
    /// side and parse the
    /// response.
    payload: ?[]const u8,
};
