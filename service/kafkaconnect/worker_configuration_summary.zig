const WorkerConfigurationRevisionSummary = @import("worker_configuration_revision_summary.zig").WorkerConfigurationRevisionSummary;
const WorkerConfigurationState = @import("worker_configuration_state.zig").WorkerConfigurationState;

/// The summary of a worker configuration.
pub const WorkerConfigurationSummary = struct {
    /// The time that a worker configuration was created.
    creation_time: ?i64,

    /// The description of a worker configuration.
    description: ?[]const u8,

    /// The latest revision of a worker configuration.
    latest_revision: ?WorkerConfigurationRevisionSummary,

    /// The name of the worker configuration.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the worker configuration.
    worker_configuration_arn: ?[]const u8,

    /// The state of the worker configuration.
    worker_configuration_state: ?WorkerConfigurationState,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .latest_revision = "latestRevision",
        .name = "name",
        .worker_configuration_arn = "workerConfigurationArn",
        .worker_configuration_state = "workerConfigurationState",
    };
};
