/// A document ID doesn't exist but you have specified as a featured document.
/// Amazon Kendra cannot feature the document if it doesn't exist in the index.
/// You can check the status of a document and its ID or check for documents
/// with
/// status errors using the
/// [BatchGetDocumentStatus](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchGetDocumentStatus.html)
/// API.
pub const FeaturedDocumentMissing = struct {
    /// The identifier of the document that doesn't exist but you have specified
    /// as a featured document.
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
