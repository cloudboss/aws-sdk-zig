const S3 = @import("s3.zig").S3;

/// The contents of a document.
///
/// Documents have size limitations. The maximum file size for a document is 50
/// MB. The maximum amount of text that can be extracted from a single document
/// is 5 MB. For more information, see [Supported document formats in Amazon Q
/// Business](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/doc-types.html).
pub const DocumentContent = union(enum) {
    /// The contents of the document. Documents passed to the `blob` parameter must
    /// be base64 encoded. Your code might not need to encode the document file
    /// bytes if you're using an Amazon Web Services SDK to call Amazon Q Business
    /// APIs. If you are calling the Amazon Q Business endpoint directly using REST,
    /// you must base64 encode the contents before sending.
    blob: ?[]const u8,
    /// The path to the document in an Amazon S3 bucket.
    s_3: ?S3,

    pub const json_field_names = .{
        .blob = "blob",
        .s_3 = "s3",
    };
};
