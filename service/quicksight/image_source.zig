/// The source of the image.
pub const ImageSource = union(enum) {
    /// The public URL that points to the source image.
    public_url: ?[]const u8,
    /// The Amazon S3 URI that points to the source image.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .public_url = "PublicUrl",
        .s3_uri = "S3Uri",
    };
};
