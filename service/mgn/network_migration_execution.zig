const aws = @import("aws");

const ExecutionStageActivity = @import("execution_stage_activity.zig").ExecutionStageActivity;
const ExecutionStage = @import("execution_stage.zig").ExecutionStage;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Details about a network migration execution instance.
pub const NetworkMigrationExecution = struct {
    /// The current activity being performed in the execution.
    activity: ?ExecutionStageActivity = null,

    /// The timestamp when the execution was created.
    created_at: ?i64 = null,

    /// The unique identifier of the network migration definition used by this
    /// execution.
    network_migration_definition_id: ?[]const u8 = null,

    /// The unique identifier of the execution.
    network_migration_execution_id: ?[]const u8 = null,

    /// The current stage of the execution in the migration workflow.
    stage: ?ExecutionStage = null,

    /// The current status of the execution.
    status: ?ExecutionStatus = null,

    /// Tags assigned to the execution.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the execution was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .activity = "activity",
        .created_at = "createdAt",
        .network_migration_definition_id = "networkMigrationDefinitionID",
        .network_migration_execution_id = "networkMigrationExecutionID",
        .stage = "stage",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
