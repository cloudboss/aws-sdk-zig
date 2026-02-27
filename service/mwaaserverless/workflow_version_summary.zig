const DefinitionS3Location = @import("definition_s3_location.zig").DefinitionS3Location;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;

/// Summary information about a workflow version, including identification and
/// configuration details.
pub const WorkflowVersionSummary = struct {
    /// The timestamp when the workflow version was created, in ISO 8601 date-time
    /// format.
    created_at: ?i64,

    /// The Amazon S3 location of the workflow definition file for this version.
    definition_s3_location: ?DefinitionS3Location,

    /// Boolean flag that indicates whether this is the latest version of the
    /// workflow.
    is_latest_version: ?bool,

    /// The timestamp when the workflow version was last modified, in ISO 8601
    /// date-time format.
    modified_at: ?i64,

    /// The schedule configuration for this workflow version.
    schedule_configuration: ?ScheduleConfiguration,

    /// The trigger mode for the workflow execution.
    trigger_mode: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains this version.
    workflow_arn: []const u8,

    /// The version identifier of the workflow version.
    workflow_version: []const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .definition_s3_location = "DefinitionS3Location",
        .is_latest_version = "IsLatestVersion",
        .modified_at = "ModifiedAt",
        .schedule_configuration = "ScheduleConfiguration",
        .trigger_mode = "TriggerMode",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};
