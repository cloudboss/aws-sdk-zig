const AppLifecycleManagement = @import("app_lifecycle_management.zig").AppLifecycleManagement;
const CodeRepository = @import("code_repository.zig").CodeRepository;
const CustomImage = @import("custom_image.zig").CustomImage;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;
const EmrSettings = @import("emr_settings.zig").EmrSettings;

/// The settings for the JupyterLab application.
pub const JupyterLabAppSettings = struct {
    /// Indicates whether idle shutdown is activated for JupyterLab applications.
    app_lifecycle_management: ?AppLifecycleManagement = null,

    /// The lifecycle configuration that runs before the default lifecycle
    /// configuration. It can override changes made in the default lifecycle
    /// configuration.
    built_in_lifecycle_config_arn: ?[]const u8 = null,

    /// A list of Git repositories that SageMaker automatically displays to users
    /// for cloning in the JupyterLab application.
    code_repositories: ?[]const CodeRepository = null,

    /// A list of custom SageMaker images that are configured to run as a JupyterLab
    /// app.
    custom_images: ?[]const CustomImage = null,

    default_resource_spec: ?ResourceSpec = null,

    /// The configuration parameters that specify the IAM roles assumed by the
    /// execution role of SageMaker (assumable roles) and the cluster instances or
    /// job execution environments (execution roles or runtime roles) to manage and
    /// access resources required for running Amazon EMR clusters or Amazon EMR
    /// Serverless applications.
    emr_settings: ?EmrSettings = null,

    /// The Amazon Resource Name (ARN) of the lifecycle configurations attached to
    /// the user profile or domain. To remove a lifecycle config, you must set
    /// `LifecycleConfigArns` to an empty list.
    lifecycle_config_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .app_lifecycle_management = "AppLifecycleManagement",
        .built_in_lifecycle_config_arn = "BuiltInLifecycleConfigArn",
        .code_repositories = "CodeRepositories",
        .custom_images = "CustomImages",
        .default_resource_spec = "DefaultResourceSpec",
        .emr_settings = "EmrSettings",
        .lifecycle_config_arns = "LifecycleConfigArns",
    };
};
