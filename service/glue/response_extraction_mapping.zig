/// Configuration that defines how to extract values from HTTP response content
/// or headers for use in subsequent requests or parameter mapping.
pub const ResponseExtractionMapping = struct {
    /// A JSON path expression that specifies how to extract a value from the
    /// response body content.
    content_path: ?[]const u8,

    /// The name of an HTTP response header from which to extract the value.
    header_key: ?[]const u8,

    pub const json_field_names = .{
        .content_path = "ContentPath",
        .header_key = "HeaderKey",
    };
};
