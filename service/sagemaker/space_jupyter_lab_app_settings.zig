const SpaceAppLifecycleManagement = @import("space_app_lifecycle_management.zig").SpaceAppLifecycleManagement;
const CodeRepository = @import("code_repository.zig").CodeRepository;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The settings for the JupyterLab application within a space.
pub const SpaceJupyterLabAppSettings = struct {
    /// Settings that are used to configure and manage the lifecycle of JupyterLab
    /// applications in a space.
    app_lifecycle_management: ?SpaceAppLifecycleManagement,

    /// A list of Git repositories that SageMaker automatically displays to users
    /// for cloning in the JupyterLab application.
    code_repositories: ?[]const CodeRepository,

    default_resource_spec: ?ResourceSpec,

    pub const json_field_names = .{
        .app_lifecycle_management = "AppLifecycleManagement",
        .code_repositories = "CodeRepositories",
        .default_resource_spec = "DefaultResourceSpec",
    };
};
