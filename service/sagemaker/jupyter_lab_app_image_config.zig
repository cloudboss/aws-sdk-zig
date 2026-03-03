const ContainerConfig = @import("container_config.zig").ContainerConfig;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;

/// The configuration for the file system and kernels in a SageMaker AI image
/// running as a JupyterLab app. The `FileSystemConfig` object is not supported.
pub const JupyterLabAppImageConfig = struct {
    container_config: ?ContainerConfig = null,

    file_system_config: ?FileSystemConfig = null,

    pub const json_field_names = .{
        .container_config = "ContainerConfig",
        .file_system_config = "FileSystemConfig",
    };
};
