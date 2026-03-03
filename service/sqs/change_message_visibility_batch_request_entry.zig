/// Encloses a receipt handle and an entry ID for each message in `
/// ChangeMessageVisibilityBatch.`
pub const ChangeMessageVisibilityBatchRequestEntry = struct {
    /// An identifier for this particular receipt handle used to communicate the
    /// result.
    ///
    /// The `Id`s of a batch request need to be unique within a request.
    ///
    /// This identifier can have up to 80 characters. The following characters are
    /// accepted: alphanumeric characters, hyphens(-), and underscores (_).
    id: []const u8,

    /// A receipt handle.
    receipt_handle: []const u8,

    /// The new value (in seconds) for the message's visibility timeout.
    visibility_timeout: ?i32 = null,

    pub const json_field_names = .{
        .id = "Id",
        .receipt_handle = "ReceiptHandle",
        .visibility_timeout = "VisibilityTimeout",
    };
};
