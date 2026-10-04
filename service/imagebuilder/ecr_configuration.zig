/// Settings that Image Builder uses to configure the ECR repository and the
/// output container
/// images that Amazon Inspector scans.
pub const EcrConfiguration = struct {
    /// Tags for Image Builder to apply to the output container image that Amazon
    /// Inspector scans. Tags can
    /// help you identify and manage your scanned images.
    container_tags: ?[]const []const u8 = null,

    /// The name of the container repository where Image Builder pushes the
    /// container
    /// image for the vulnerability scan. Provide the repository name only (a
    /// namespace path is allowed, but not the registry hostname); the repository
    /// must already exist in your account. If you don't specify a repository
    /// name, Image Builder creates the default repository
    /// `image-builder-image-scanning-repository` in your account.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_tags = "containerTags",
        .repository_name = "repositoryName",
    };
};
