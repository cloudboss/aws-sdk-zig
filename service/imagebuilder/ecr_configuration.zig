/// Settings that Image Builder uses to configure the ECR repository and the
/// output container
/// images that Amazon Inspector scans.
pub const EcrConfiguration = struct {
    /// Tags for Image Builder to apply to the output container image that Amazon
    /// Inspector scans. Tags can
    /// help you identify and manage your scanned images.
    container_tags: ?[]const []const u8,

    /// The name of the container repository that Amazon Inspector scans to identify
    /// findings for your
    /// container images. The name includes the path for the repository location. If
    /// you don’t
    /// provide this information, Image Builder creates a repository in your account
    /// named
    /// `image-builder-image-scanning-repository` for vulnerability scans of your
    /// output container images.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .container_tags = "containerTags",
        .repository_name = "repositoryName",
    };
};
