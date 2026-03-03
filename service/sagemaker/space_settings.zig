const AppType = @import("app_type.zig").AppType;
const SpaceCodeEditorAppSettings = @import("space_code_editor_app_settings.zig").SpaceCodeEditorAppSettings;
const CustomFileSystem = @import("custom_file_system.zig").CustomFileSystem;
const SpaceJupyterLabAppSettings = @import("space_jupyter_lab_app_settings.zig").SpaceJupyterLabAppSettings;
const JupyterServerAppSettings = @import("jupyter_server_app_settings.zig").JupyterServerAppSettings;
const KernelGatewayAppSettings = @import("kernel_gateway_app_settings.zig").KernelGatewayAppSettings;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;
const SpaceStorageSettings = @import("space_storage_settings.zig").SpaceStorageSettings;

/// A collection of space settings.
pub const SpaceSettings = struct {
    /// The type of app created within the space.
    ///
    /// If using the [
    /// UpdateSpace](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateSpace.html) API, you can't change the app type of your space by specifying a different value for this field.
    app_type: ?AppType = null,

    /// The Code Editor application settings.
    code_editor_app_settings: ?SpaceCodeEditorAppSettings = null,

    /// A file system, created by you, that you assign to a space for an Amazon
    /// SageMaker AI Domain. Permitted users can access this file system in Amazon
    /// SageMaker AI Studio.
    custom_file_systems: ?[]const CustomFileSystem = null,

    /// The settings for the JupyterLab application.
    jupyter_lab_app_settings: ?SpaceJupyterLabAppSettings = null,

    jupyter_server_app_settings: ?JupyterServerAppSettings = null,

    kernel_gateway_app_settings: ?KernelGatewayAppSettings = null,

    /// A setting that enables or disables remote access for a SageMaker space. When
    /// enabled, this allows you to connect to the remote space from your local IDE.
    remote_access: ?FeatureStatus = null,

    /// If you enable this option, SageMaker AI creates the following resources on
    /// your behalf when you create the space:
    ///
    /// * The user profile that possesses the space.
    /// * The app that the space contains.
    space_managed_resources: ?FeatureStatus = null,

    /// The storage settings for a space.
    space_storage_settings: ?SpaceStorageSettings = null,

    pub const json_field_names = .{
        .app_type = "AppType",
        .code_editor_app_settings = "CodeEditorAppSettings",
        .custom_file_systems = "CustomFileSystems",
        .jupyter_lab_app_settings = "JupyterLabAppSettings",
        .jupyter_server_app_settings = "JupyterServerAppSettings",
        .kernel_gateway_app_settings = "KernelGatewayAppSettings",
        .remote_access = "RemoteAccess",
        .space_managed_resources = "SpaceManagedResources",
        .space_storage_settings = "SpaceStorageSettings",
    };
};
