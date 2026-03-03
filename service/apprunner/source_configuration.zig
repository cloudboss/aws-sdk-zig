const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const CodeRepository = @import("code_repository.zig").CodeRepository;
const ImageRepository = @import("image_repository.zig").ImageRepository;

/// Describes the source deployed to an App Runner service. It can be a code or
/// an image repository.
pub const SourceConfiguration = struct {
    /// Describes the resources that are needed to authenticate access to some
    /// source repositories.
    authentication_configuration: ?AuthenticationConfiguration = null,

    /// If `true`, continuous integration from the source repository is enabled for
    /// the App Runner service. Each repository change (including any source
    /// code commit or new image version) starts a deployment.
    ///
    /// Default: App Runner sets to `false` for a source image that uses an ECR
    /// Public repository or an ECR repository that's in an Amazon Web Services
    /// account other than the one that the service is in. App Runner sets to `true`
    /// in all other cases (which currently include a source code
    /// repository or a source image using a same-account ECR repository).
    auto_deployments_enabled: ?bool = null,

    /// The description of a source code
    /// repository.
    ///
    /// You must provide either this member or `ImageRepository` (but not both).
    code_repository: ?CodeRepository = null,

    /// The description of a source image
    /// repository.
    ///
    /// You must provide either this member or `CodeRepository` (but not both).
    image_repository: ?ImageRepository = null,

    pub const json_field_names = .{
        .authentication_configuration = "AuthenticationConfiguration",
        .auto_deployments_enabled = "AutoDeploymentsEnabled",
        .code_repository = "CodeRepository",
        .image_repository = "ImageRepository",
    };
};
