const AdvancedBackupSetting = @import("advanced_backup_setting.zig").AdvancedBackupSetting;

/// Contains metadata about a backup plan.
pub const BackupPlansListMember = struct {
    /// Contains a list of `BackupOptions` for a resource type.
    advanced_backup_settings: ?[]const AdvancedBackupSetting,

    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50`.
    backup_plan_arn: ?[]const u8,

    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8,

    /// The display name of a saved backup plan.
    backup_plan_name: ?[]const u8,

    /// The date and time a resource backup plan is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8,

    /// The date and time a backup plan is deleted, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `DeletionDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    deletion_date: ?i64,

    /// The last time this backup plan was run. A date and time, in
    /// Unix format and Coordinated Universal Time (UTC). The value of
    /// `LastExecutionDate` is accurate to milliseconds. For example, the value
    /// 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    last_execution_date: ?i64,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
    /// 1,024 bytes
    /// long. Version IDs cannot be edited.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .advanced_backup_settings = "AdvancedBackupSettings",
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .backup_plan_name = "BackupPlanName",
        .creation_date = "CreationDate",
        .creator_request_id = "CreatorRequestId",
        .deletion_date = "DeletionDate",
        .last_execution_date = "LastExecutionDate",
        .version_id = "VersionId",
    };
};
