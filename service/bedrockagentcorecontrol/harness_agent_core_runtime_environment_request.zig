const FilesystemConfiguration = @import("filesystem_configuration.zig").FilesystemConfiguration;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;

/// The AgentCore Runtime environment request configuration.
pub const HarnessAgentCoreRuntimeEnvironmentRequest = struct {
    /// The filesystem configurations for the runtime environment.
    filesystem_configurations: ?[]const FilesystemConfiguration = null,

    lifecycle_configuration: ?LifecycleConfiguration = null,

    network_configuration: ?NetworkConfiguration = null,

    pub const json_field_names = .{
        .filesystem_configurations = "filesystemConfigurations",
        .lifecycle_configuration = "lifecycleConfiguration",
        .network_configuration = "networkConfiguration",
    };
};
