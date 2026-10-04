/// The applied image configuration.
pub const ImageConfiguration = struct {
    /// Boolean value indicating if the digest resolution is application level or
    /// workload level. If true, a custom image URI is resolved at application start
    /// time and all workloads submitted will use that image digest. If false, the
    /// custom image URI is resolved at the workload submission time.
    application_level_digest_resolution: ?bool = null,

    /// The image URI.
    image_uri: []const u8,

    /// The SHA256 digest of the image URI. This indicates which specific image the
    /// application is configured for. The image digest doesn't exist until an
    /// application has started.
    resolved_image_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_level_digest_resolution = "applicationLevelDigestResolution",
        .image_uri = "imageUri",
        .resolved_image_digest = "resolvedImageDigest",
    };
};
