/// The content and content type of a document.
pub const Document = struct {
    /// The `Content`field type is Binary large object (blob).
    /// This object contains the document content converted into base64-encoded
    /// binary data.
    /// If you use one of the AWS SDKs, the SDK performs the
    /// Base64-encoding on this field before sending the request.
    content: []const u8,

    /// Describes the format of the document. You can specify one of the following:
    ///
    /// * `text/html` - The input data consists of HTML content.
    /// Amazon Translate translates only the text in the HTML element.
    ///
    /// * `text/plain` - The input data consists of unformatted text.
    /// Amazon Translate translates every character in the content.
    ///
    /// * `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
    ///   - The
    /// input data consists of a Word document (.docx).
    content_type: []const u8,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
    };
};
