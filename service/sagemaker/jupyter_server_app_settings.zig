const CodeRepository = @import("code_repository.zig").CodeRepository;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The JupyterServer app settings.
pub const JupyterServerAppSettings = struct {
    /// A list of Git repositories that SageMaker AI automatically displays to users
    /// for cloning in the JupyterServer application.
    code_repositories: ?[]const CodeRepository = null,

    /// The default instance type and the Amazon Resource Name (ARN) of the default
    /// SageMaker AI image used by the JupyterServer app. If you use the
    /// `LifecycleConfigArns` parameter, then this parameter is also required.
    default_resource_spec: ?ResourceSpec = null,

    /// The Amazon Resource Name (ARN) of the Lifecycle Configurations attached to
    /// the JupyterServerApp. If you use this parameter, the `DefaultResourceSpec`
    /// parameter is also required.
    ///
    /// To remove a Lifecycle Config, you must set `LifecycleConfigArns` to an empty
    /// list.
    lifecycle_config_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code_repositories = "CodeRepositories",
        .default_resource_spec = "DefaultResourceSpec",
        .lifecycle_config_arns = "LifecycleConfigArns",
    };
};
