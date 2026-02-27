/// The applied image configuration.
pub const ImageConfiguration = struct {
    /// The image URI.
    image_uri: []const u8,

    /// The SHA256 digest of the image URI. This indicates which specific image the
    /// application is configured for. The image digest doesn't exist until an
    /// application has started.
    resolved_image_digest: ?[]const u8,

    pub const json_field_names = .{
        .image_uri = "imageUri",
        .resolved_image_digest = "resolvedImageDigest",
    };
};
