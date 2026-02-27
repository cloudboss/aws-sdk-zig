const ContainerConfig = @import("container_config.zig").ContainerConfig;
const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;

/// The configuration for the file system and kernels in a SageMaker image
/// running as a Code Editor app. The `FileSystemConfig` object is not
/// supported.
pub const CodeEditorAppImageConfig = struct {
    container_config: ?ContainerConfig,

    file_system_config: ?FileSystemConfig,

    pub const json_field_names = .{
        .container_config = "ContainerConfig",
        .file_system_config = "FileSystemConfig",
    };
};
