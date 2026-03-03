const AwsBackupBackupPlanBackupPlanDetails = @import("aws_backup_backup_plan_backup_plan_details.zig").AwsBackupBackupPlanBackupPlanDetails;

/// Provides details about an Backup backup plan and an array of `BackupRule`
/// objects, each of which specifies a backup rule.
pub const AwsBackupBackupPlanDetails = struct {
    /// Uniquely identifies the backup plan to be associated with the selection of
    /// resources.
    backup_plan: ?AwsBackupBackupPlanBackupPlanDetails = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies the backup plan.
    backup_plan_arn: ?[]const u8 = null,

    /// A unique ID for the backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings. Version IDs
    /// cannot be edited.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan = "BackupPlan",
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .version_id = "VersionId",
    };
};
