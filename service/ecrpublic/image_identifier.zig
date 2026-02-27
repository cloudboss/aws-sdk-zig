/// An object with identifying information for an Amazon ECR image.
pub const ImageIdentifier = struct {
    /// The `sha256` digest of the image manifest.
    image_digest: ?[]const u8,

    /// The tag that's used for the image.
    image_tag: ?[]const u8,

    pub const json_field_names = .{
        .image_digest = "imageDigest",
        .image_tag = "imageTag",
    };
};
