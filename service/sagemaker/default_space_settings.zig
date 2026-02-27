const CustomFileSystemConfig = @import("custom_file_system_config.zig").CustomFileSystemConfig;
const CustomPosixUserConfig = @import("custom_posix_user_config.zig").CustomPosixUserConfig;
const JupyterLabAppSettings = @import("jupyter_lab_app_settings.zig").JupyterLabAppSettings;
const JupyterServerAppSettings = @import("jupyter_server_app_settings.zig").JupyterServerAppSettings;
const KernelGatewayAppSettings = @import("kernel_gateway_app_settings.zig").KernelGatewayAppSettings;
const DefaultSpaceStorageSettings = @import("default_space_storage_settings.zig").DefaultSpaceStorageSettings;

/// The default settings for shared spaces that users create in the domain.
///
/// SageMaker applies these settings only to shared spaces. It doesn't apply
/// them to private spaces.
pub const DefaultSpaceSettings = struct {
    /// The settings for assigning a custom file system to a domain. Permitted users
    /// can access this file system in Amazon SageMaker AI Studio.
    custom_file_system_configs: ?[]const CustomFileSystemConfig,

    custom_posix_user_config: ?CustomPosixUserConfig,

    /// The ARN of the execution role for the space.
    execution_role: ?[]const u8,

    jupyter_lab_app_settings: ?JupyterLabAppSettings,

    jupyter_server_app_settings: ?JupyterServerAppSettings,

    kernel_gateway_app_settings: ?KernelGatewayAppSettings,

    /// The security group IDs for the Amazon VPC that the space uses for
    /// communication.
    security_groups: ?[]const []const u8,

    space_storage_settings: ?DefaultSpaceStorageSettings,

    pub const json_field_names = .{
        .custom_file_system_configs = "CustomFileSystemConfigs",
        .custom_posix_user_config = "CustomPosixUserConfig",
        .execution_role = "ExecutionRole",
        .jupyter_lab_app_settings = "JupyterLabAppSettings",
        .jupyter_server_app_settings = "JupyterServerAppSettings",
        .kernel_gateway_app_settings = "KernelGatewayAppSettings",
        .security_groups = "SecurityGroups",
        .space_storage_settings = "SpaceStorageSettings",
    };
};
