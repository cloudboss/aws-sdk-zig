/// Encloses a receipt handle and an identifier for it.
pub const DeleteMessageBatchRequestEntry = struct {
    /// The identifier for this particular receipt handle. This is used to
    /// communicate the
    /// result.
    ///
    /// **Note:**
    ///
    /// The `Id`s of a batch request need to be unique within a request.
    ///
    /// This identifier can have up to 80 characters. The following characters are
    /// accepted: alphanumeric characters, hyphens(-), and underscores (_).
    id: []const u8,

    /// A receipt handle.
    receipt_handle: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .receipt_handle = "ReceiptHandle",
    };
};
