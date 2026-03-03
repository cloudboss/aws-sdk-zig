const MigrationWorkflowStatusEnum = @import("migration_workflow_status_enum.zig").MigrationWorkflowStatusEnum;

/// The summary of a migration workflow.
pub const MigrationWorkflowSummary = struct {
    /// The name of the application configured in Application Discovery Service.
    ads_application_configuration_name: ?[]const u8 = null,

    /// The steps completed in the migration workflow.
    completed_steps: ?i32 = null,

    /// The time at which the migration workflow was created.
    creation_time: ?i64 = null,

    /// The time at which the migration workflow ended.
    end_time: ?i64 = null,

    /// The ID of the migration workflow.
    id: ?[]const u8 = null,

    /// The name of the migration workflow.
    name: ?[]const u8 = null,

    /// The status of the migration workflow.
    status: ?MigrationWorkflowStatusEnum = null,

    /// The status message of the migration workflow.
    status_message: ?[]const u8 = null,

    /// The ID of the template.
    template_id: ?[]const u8 = null,

    /// All the steps in a migration workflow.
    total_steps: ?i32 = null,

    pub const json_field_names = .{
        .ads_application_configuration_name = "adsApplicationConfigurationName",
        .completed_steps = "completedSteps",
        .creation_time = "creationTime",
        .end_time = "endTime",
        .id = "id",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .template_id = "templateId",
        .total_steps = "totalSteps",
    };
};
