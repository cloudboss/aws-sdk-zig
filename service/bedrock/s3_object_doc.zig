/// The unique wrapper object of the document from the S3 location.
pub const S3ObjectDoc = struct {
    /// The S3 URI location for the wrapper object of the document.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
