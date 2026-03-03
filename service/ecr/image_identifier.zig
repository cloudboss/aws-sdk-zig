/// An object with identifying information for an image in an Amazon ECR
/// repository.
pub const ImageIdentifier = struct {
    /// The `sha256` digest of the image manifest.
    image_digest: ?[]const u8 = null,

    /// The tag used for the image.
    image_tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_digest = "imageDigest",
        .image_tag = "imageTag",
    };
};
