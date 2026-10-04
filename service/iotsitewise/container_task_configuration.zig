const aws = @import("aws");

const EphemeralStorageConfiguration = @import("ephemeral_storage_configuration.zig").EphemeralStorageConfiguration;
const Mount = @import("mount.zig").Mount;
const ProcessingType = @import("processing_type.zig").ProcessingType;
const ProcessingUnit = @import("processing_unit.zig").ProcessingUnit;

/// Configuration for a container task, including the container image, IAM role,
/// and compute settings.
pub const ContainerTaskConfiguration = struct {
    /// The command to execute in the container.
    command: ?[]const []const u8 = null,

    /// The Amazon ECR image URI for the task container.
    ecr_uri: []const u8,

    /// Environment variables passed to the container at runtime.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// Ephemeral storage configuration for the container task.
    ephemeral_storage_configuration: ?EphemeralStorageConfiguration = null,

    /// Mounts attached to the container filesystem. Each mount exposes an external
    /// data source as a local directory inside the container. The service assigns
    /// each mount
    /// a container path based on the mount name. The container reads files through
    /// that path
    /// as if the data were on the local filesystem.
    mounts: ?[]const Mount = null,

    /// The processing type for compute resources.
    processing_type: ProcessingType,

    /// The processing unit allocation that determines the vCPU, memory, and GPU
    /// resources.
    processing_unit: ProcessingUnit,

    /// The ARN of the IAM role that grants the containerized workload permissions
    /// to access AWS resources.
    task_execution_role: []const u8,

    /// The timeout in seconds for task execution. Default: 3600 (1 hour).
    timeout_seconds: ?i64 = null,

    pub const json_field_names = .{
        .command = "command",
        .ecr_uri = "ecrUri",
        .environment_variables = "environmentVariables",
        .ephemeral_storage_configuration = "ephemeralStorageConfiguration",
        .mounts = "mounts",
        .processing_type = "processingType",
        .processing_unit = "processingUnit",
        .task_execution_role = "taskExecutionRole",
        .timeout_seconds = "timeoutSeconds",
    };
};
