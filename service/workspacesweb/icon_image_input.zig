/// The input for an icon image (logo or favicon). Provide either a binary image
/// file or an S3 URI pointing to the image file. Maximum 100 KB in JPEG, PNG,
/// or ICO format.
pub const IconImageInput = union(enum) {
    /// The image provided as a binary image file.
    blob: ?[]const u8,
    /// The S3 URI pointing to the image file. The URI must use the format
    /// `s3://bucket-name/key-name`. You must have read access to the S3 object.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .blob = "blob",
        .s_3_uri = "s3Uri",
    };
};
