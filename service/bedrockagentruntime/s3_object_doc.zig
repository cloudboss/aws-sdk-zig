/// The unique wrapper object of the document from the S3 location.
pub const S3ObjectDoc = struct {
    /// The file location of the S3 wrapper object.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
