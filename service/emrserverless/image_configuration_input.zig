/// The image configuration.
pub const ImageConfigurationInput = struct {
    /// Boolean value indicating if the digest resolution is application level or
    /// workload level. If true, a custom image URI is resolved at application start
    /// time and all workloads submitted will use that image digest. If false, the
    /// custom image URI is resolved at the workload submission time.
    application_level_digest_resolution: ?bool = null,

    /// The URI of an image in the Amazon ECR registry. This field is required when
    /// you create a new application. If you leave this field blank in an update,
    /// Amazon EMR will remove the image configuration.
    image_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_level_digest_resolution = "applicationLevelDigestResolution",
        .image_uri = "imageUri",
    };
};
