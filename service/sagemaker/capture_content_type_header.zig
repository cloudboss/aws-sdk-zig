/// Configuration specifying how to treat different headers. If no headers are
/// specified Amazon SageMaker AI will by default base64 encode when capturing
/// the data.
pub const CaptureContentTypeHeader = struct {
    /// The list of all content type headers that Amazon SageMaker AI will treat as
    /// CSV and capture accordingly.
    csv_content_types: ?[]const []const u8,

    /// The list of all content type headers that SageMaker AI will treat as JSON
    /// and capture accordingly.
    json_content_types: ?[]const []const u8,

    pub const json_field_names = .{
        .csv_content_types = "CsvContentTypes",
        .json_content_types = "JsonContentTypes",
    };
};
