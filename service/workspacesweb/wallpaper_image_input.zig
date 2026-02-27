/// The input for a wallpaper image. Provide the image as either a binary image
/// file or an S3 URI. Maximum 5 MB in JPEG or PNG format.
pub const WallpaperImageInput = union(enum) {
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
