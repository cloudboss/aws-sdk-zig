const FileSystemConfig = @import("file_system_config.zig").FileSystemConfig;
const KernelSpec = @import("kernel_spec.zig").KernelSpec;

/// The configuration for the file system and kernels in a SageMaker AI image
/// running as a KernelGateway app.
pub const KernelGatewayImageConfig = struct {
    /// The Amazon Elastic File System storage configuration for a SageMaker AI
    /// image.
    file_system_config: ?FileSystemConfig,

    /// The specification of the Jupyter kernels in the image.
    kernel_specs: []const KernelSpec,

    pub const json_field_names = .{
        .file_system_config = "FileSystemConfig",
        .kernel_specs = "KernelSpecs",
    };
};
