const RepositoryAccessMode = @import("repository_access_mode.zig").RepositoryAccessMode;
const RepositoryAuthConfig = @import("repository_auth_config.zig").RepositoryAuthConfig;

/// Specifies whether the model container is in Amazon ECR or a private Docker
/// registry accessible from your Amazon Virtual Private Cloud (VPC).
pub const ImageConfig = struct {
    /// Set this to one of the following values:
    ///
    /// * `Platform` - The model image is hosted in Amazon ECR.
    /// * `Vpc` - The model image is hosted in a private Docker registry in your
    ///   VPC.
    repository_access_mode: RepositoryAccessMode,

    /// (Optional) Specifies an authentication configuration for the private docker
    /// registry where your model image is hosted. Specify a value for this property
    /// only if you specified `Vpc` as the value for the `RepositoryAccessMode`
    /// field, and the private Docker registry where the model image is hosted
    /// requires authentication.
    repository_auth_config: ?RepositoryAuthConfig = null,

    pub const json_field_names = .{
        .repository_access_mode = "RepositoryAccessMode",
        .repository_auth_config = "RepositoryAuthConfig",
    };
};
