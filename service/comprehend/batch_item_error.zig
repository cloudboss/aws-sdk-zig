/// Describes an error that occurred while processing a document in a batch. The
/// operation
/// returns on `BatchItemError` object for each document that contained an
/// error.
pub const BatchItemError = struct {
    /// The numeric error code of the error.
    error_code: ?[]const u8,

    /// A text description of the error.
    error_message: ?[]const u8,

    /// The zero-based index of the document in the input list.
    index: ?i32,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .index = "Index",
    };
};
