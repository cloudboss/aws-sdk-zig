/// Specifies image mappings that workflow tasks can use. For example, you can
/// replace all the task references of a public image to use an equivalent image
/// in your private ECR repository. You can use image mappings with upstream
/// registries that don't support pull through cache. You need to manually
/// synchronize the upstream registry with your private repository.
pub const ImageMapping = struct {
    /// Specifies the URI of the corresponding image in the private ECR registry.
    destination_image: ?[]const u8,

    /// Specifies the URI of the source image in the upstream registry.
    source_image: ?[]const u8,

    pub const json_field_names = .{
        .destination_image = "destinationImage",
        .source_image = "sourceImage",
    };
};
