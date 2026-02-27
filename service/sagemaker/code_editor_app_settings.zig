const AppLifecycleManagement = @import("app_lifecycle_management.zig").AppLifecycleManagement;
const CustomImage = @import("custom_image.zig").CustomImage;
const ResourceSpec = @import("resource_spec.zig").ResourceSpec;

/// The Code Editor application settings.
///
/// For more information about Code Editor, see [Get started with Code Editor in
/// Amazon
/// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/code-editor.html).
pub const CodeEditorAppSettings = struct {
    /// Settings that are used to configure and manage the lifecycle of CodeEditor
    /// applications.
    app_lifecycle_management: ?AppLifecycleManagement,

    /// The lifecycle configuration that runs before the default lifecycle
    /// configuration. It can override changes made in the default lifecycle
    /// configuration.
    built_in_lifecycle_config_arn: ?[]const u8,

    /// A list of custom SageMaker images that are configured to run as a Code
    /// Editor app.
    custom_images: ?[]const CustomImage,

    default_resource_spec: ?ResourceSpec,

    /// The Amazon Resource Name (ARN) of the Code Editor application lifecycle
    /// configuration.
    lifecycle_config_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .app_lifecycle_management = "AppLifecycleManagement",
        .built_in_lifecycle_config_arn = "BuiltInLifecycleConfigArn",
        .custom_images = "CustomImages",
        .default_resource_spec = "DefaultResourceSpec",
        .lifecycle_config_arns = "LifecycleConfigArns",
    };
};
