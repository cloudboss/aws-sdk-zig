const DeletionConfigurationItemType = @import("deletion_configuration_item_type.zig").DeletionConfigurationItemType;
const DeletionWarning = @import("deletion_warning.zig").DeletionWarning;
const FailedConfiguration = @import("failed_configuration.zig").FailedConfiguration;
const BatchDeleteConfigurationTaskStatus = @import("batch_delete_configuration_task_status.zig").BatchDeleteConfigurationTaskStatus;

/// A metadata object that represents the deletion task being executed.
pub const BatchDeleteConfigurationTask = struct {
    /// The type of configuration item to delete. Supported types are: SERVER.
    configuration_type: ?DeletionConfigurationItemType,

    /// The list of configuration IDs that were successfully deleted by the deletion
    /// task.
    deleted_configurations: ?[]const []const u8,

    /// A list of configuration IDs that produced warnings regarding their deletion,
    /// paired with a warning message.
    deletion_warnings: ?[]const DeletionWarning,

    /// An epoch seconds timestamp (UTC) of when the deletion task was completed or
    /// failed.
    end_time: ?i64,

    /// A list of configuration IDs that failed to delete during the deletion task,
    /// each paired with an error message.
    failed_configurations: ?[]const FailedConfiguration,

    /// The list of configuration IDs that were originally requested to be deleted
    /// by the deletion task.
    requested_configurations: ?[]const []const u8,

    /// An epoch seconds timestamp (UTC) of when the deletion task was started.
    start_time: ?i64,

    /// The current execution status of the deletion task.
    /// Valid status are: INITIALIZING | VALIDATING | DELETING | COMPLETED | FAILED.
    status: ?BatchDeleteConfigurationTaskStatus,

    /// The deletion task's unique identifier.
    task_id: ?[]const u8,

    pub const json_field_names = .{
        .configuration_type = "configurationType",
        .deleted_configurations = "deletedConfigurations",
        .deletion_warnings = "deletionWarnings",
        .end_time = "endTime",
        .failed_configurations = "failedConfigurations",
        .requested_configurations = "requestedConfigurations",
        .start_time = "startTime",
        .status = "status",
        .task_id = "taskId",
    };
};
