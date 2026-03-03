const CodeEditorAppImageConfig = @import("code_editor_app_image_config.zig").CodeEditorAppImageConfig;
const JupyterLabAppImageConfig = @import("jupyter_lab_app_image_config.zig").JupyterLabAppImageConfig;
const KernelGatewayImageConfig = @import("kernel_gateway_image_config.zig").KernelGatewayImageConfig;

/// The configuration for running a SageMaker AI image as a KernelGateway app.
pub const AppImageConfigDetails = struct {
    /// The ARN of the AppImageConfig.
    app_image_config_arn: ?[]const u8 = null,

    /// The name of the AppImageConfig. Must be unique to your account.
    app_image_config_name: ?[]const u8 = null,

    /// The configuration for the file system and the runtime, such as the
    /// environment variables and entry point.
    code_editor_app_image_config: ?CodeEditorAppImageConfig = null,

    /// When the AppImageConfig was created.
    creation_time: ?i64 = null,

    /// The configuration for the file system and the runtime, such as the
    /// environment variables and entry point.
    jupyter_lab_app_image_config: ?JupyterLabAppImageConfig = null,

    /// The configuration for the file system and kernels in the SageMaker AI image.
    kernel_gateway_image_config: ?KernelGatewayImageConfig = null,

    /// When the AppImageConfig was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .app_image_config_arn = "AppImageConfigArn",
        .app_image_config_name = "AppImageConfigName",
        .code_editor_app_image_config = "CodeEditorAppImageConfig",
        .creation_time = "CreationTime",
        .jupyter_lab_app_image_config = "JupyterLabAppImageConfig",
        .kernel_gateway_image_config = "KernelGatewayImageConfig",
        .last_modified_time = "LastModifiedTime",
    };
};
