const AutoMountHomeEFS = @import("auto_mount_home_efs.zig").AutoMountHomeEFS;
const CanvasAppSettings = @import("canvas_app_settings.zig").CanvasAppSettings;
const CodeEditorAppSettings = @import("code_editor_app_settings.zig").CodeEditorAppSettings;
const CustomFileSystemConfig = @import("custom_file_system_config.zig").CustomFileSystemConfig;
const CustomPosixUserConfig = @import("custom_posix_user_config.zig").CustomPosixUserConfig;
const JupyterLabAppSettings = @import("jupyter_lab_app_settings.zig").JupyterLabAppSettings;
const JupyterServerAppSettings = @import("jupyter_server_app_settings.zig").JupyterServerAppSettings;
const KernelGatewayAppSettings = @import("kernel_gateway_app_settings.zig").KernelGatewayAppSettings;
const RSessionAppSettings = @import("r_session_app_settings.zig").RSessionAppSettings;
const RStudioServerProAppSettings = @import("r_studio_server_pro_app_settings.zig").RStudioServerProAppSettings;
const SharingSettings = @import("sharing_settings.zig").SharingSettings;
const DefaultSpaceStorageSettings = @import("default_space_storage_settings.zig").DefaultSpaceStorageSettings;
const StudioWebPortal = @import("studio_web_portal.zig").StudioWebPortal;
const StudioWebPortalSettings = @import("studio_web_portal_settings.zig").StudioWebPortalSettings;
const TensorBoardAppSettings = @import("tensor_board_app_settings.zig").TensorBoardAppSettings;

/// A collection of settings that apply to users in a domain. These settings are
/// specified when the `CreateUserProfile` API is called, and as
/// `DefaultUserSettings` when the `CreateDomain` API is called.
///
/// `SecurityGroups` is aggregated when specified in both calls. For all other
/// settings in `UserSettings`, the values specified in `CreateUserProfile` take
/// precedence over those specified in `CreateDomain`.
pub const UserSettings = struct {
    /// Indicates whether auto-mounting of an EFS volume is supported for the user
    /// profile. The `DefaultAsDomain` value is only supported for user profiles. Do
    /// not use the `DefaultAsDomain` value when setting this parameter for a
    /// domain.
    ///
    /// SageMaker applies this setting only to private spaces that the user creates
    /// in the domain. SageMaker doesn't apply this setting to shared spaces.
    auto_mount_home_efs: ?AutoMountHomeEFS = null,

    /// The Canvas app settings.
    ///
    /// SageMaker applies these settings only to private spaces that SageMaker
    /// creates for the Canvas app.
    canvas_app_settings: ?CanvasAppSettings = null,

    /// The Code Editor application settings.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    code_editor_app_settings: ?CodeEditorAppSettings = null,

    /// The settings for assigning a custom file system to a user profile. Permitted
    /// users can access this file system in Amazon SageMaker AI Studio.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    custom_file_system_configs: ?[]const CustomFileSystemConfig = null,

    /// Details about the POSIX identity that is used for file system operations.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    custom_posix_user_config: ?CustomPosixUserConfig = null,

    /// The default experience that the user is directed to when accessing the
    /// domain. The supported values are:
    ///
    /// * `studio::`: Indicates that Studio is the default experience. This value
    ///   can only be passed if `StudioWebPortal` is set to `ENABLED`.
    /// * `app:JupyterServer:`: Indicates that Studio Classic is the default
    ///   experience.
    default_landing_uri: ?[]const u8 = null,

    /// The execution role for the user.
    ///
    /// SageMaker applies this setting only to private spaces that the user creates
    /// in the domain. SageMaker doesn't apply this setting to shared spaces.
    execution_role: ?[]const u8 = null,

    /// The settings for the JupyterLab application.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    jupyter_lab_app_settings: ?JupyterLabAppSettings = null,

    /// The Jupyter server's app settings.
    jupyter_server_app_settings: ?JupyterServerAppSettings = null,

    /// The kernel gateway app settings.
    kernel_gateway_app_settings: ?KernelGatewayAppSettings = null,

    /// A collection of settings that configure the `RSessionGateway` app.
    r_session_app_settings: ?RSessionAppSettings = null,

    /// A collection of settings that configure user interaction with the
    /// `RStudioServerPro` app.
    r_studio_server_pro_app_settings: ?RStudioServerProAppSettings = null,

    /// The security groups for the Amazon Virtual Private Cloud (VPC) that the
    /// domain uses for communication.
    ///
    /// Optional when the `CreateDomain.AppNetworkAccessType` parameter is set to
    /// `PublicInternetOnly`.
    ///
    /// Required when the `CreateDomain.AppNetworkAccessType` parameter is set to
    /// `VpcOnly`, unless specified as part of the `DefaultUserSettings` for the
    /// domain.
    ///
    /// Amazon SageMaker AI adds a security group to allow NFS traffic from Amazon
    /// SageMaker AI Studio. Therefore, the number of security groups that you can
    /// specify is one less than the maximum number shown.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    security_groups: ?[]const []const u8 = null,

    /// Specifies options for sharing Amazon SageMaker AI Studio notebooks.
    sharing_settings: ?SharingSettings = null,

    /// The storage settings for a space.
    ///
    /// SageMaker applies these settings only to private spaces that the user
    /// creates in the domain. SageMaker doesn't apply these settings to shared
    /// spaces.
    space_storage_settings: ?DefaultSpaceStorageSettings = null,

    /// Whether the user can access Studio. If this value is set to `DISABLED`, the
    /// user cannot access Studio, even if that is the default experience for the
    /// domain.
    studio_web_portal: ?StudioWebPortal = null,

    /// Studio settings. If these settings are applied on a user level, they take
    /// priority over the settings applied on a domain level.
    studio_web_portal_settings: ?StudioWebPortalSettings = null,

    /// The TensorBoard app settings.
    tensor_board_app_settings: ?TensorBoardAppSettings = null,

    pub const json_field_names = .{
        .auto_mount_home_efs = "AutoMountHomeEFS",
        .canvas_app_settings = "CanvasAppSettings",
        .code_editor_app_settings = "CodeEditorAppSettings",
        .custom_file_system_configs = "CustomFileSystemConfigs",
        .custom_posix_user_config = "CustomPosixUserConfig",
        .default_landing_uri = "DefaultLandingUri",
        .execution_role = "ExecutionRole",
        .jupyter_lab_app_settings = "JupyterLabAppSettings",
        .jupyter_server_app_settings = "JupyterServerAppSettings",
        .kernel_gateway_app_settings = "KernelGatewayAppSettings",
        .r_session_app_settings = "RSessionAppSettings",
        .r_studio_server_pro_app_settings = "RStudioServerProAppSettings",
        .security_groups = "SecurityGroups",
        .sharing_settings = "SharingSettings",
        .space_storage_settings = "SpaceStorageSettings",
        .studio_web_portal = "StudioWebPortal",
        .studio_web_portal_settings = "StudioWebPortalSettings",
        .tensor_board_app_settings = "TensorBoardAppSettings",
    };
};
