const aws = @import("aws");

const CopyAction = @import("copy_action.zig").CopyAction;
const IndexAction = @import("index_action.zig").IndexAction;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const ScanAction = @import("scan_action.zig").ScanAction;

/// Specifies a scheduled task used to back up a selection of resources.
pub const BackupRule = struct {
    /// A value in minutes after a backup job is successfully started before it must
    /// be
    /// completed or it will be canceled by Backup. This value is optional.
    completion_window_minutes: ?i64,

    /// An array of `CopyAction` objects, which contains the details of the copy
    /// operation.
    copy_actions: ?[]const CopyAction,

    /// Specifies whether Backup creates continuous backups. True causes Backup to
    /// create continuous backups capable of point-in-time restore (PITR). False
    /// (or not specified) causes Backup to create snapshot backups.
    enable_continuous_backup: ?bool,

    /// IndexActions is an array you use to specify how backup data should
    /// be indexed.
    ///
    /// eEach BackupRule can have 0 or 1 IndexAction, as each backup can have up
    /// to one index associated with it.
    ///
    /// Within the array is ResourceType. Only one will be accepted for each
    /// BackupRule.
    index_actions: ?[]const IndexAction,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90
    /// days. Therefore, the “retention” setting must be 90 days greater than the
    /// “transition to
    /// cold after days” setting. The “transition to cold after days” setting cannot
    /// be changed
    /// after a backup has been transitioned to cold.
    ///
    /// Resource types that can transition to cold storage are listed in the
    /// [Feature availability
    /// by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for other resource types.
    lifecycle: ?Lifecycle,

    /// The tags that are assigned to resources that are associated
    /// with this rule when restored from backup.
    recovery_point_tags: ?[]const aws.map.StringMapEntry,

    /// Uniquely identifies a rule that is used to schedule the backup of a
    /// selection of
    /// resources.
    rule_id: ?[]const u8,

    /// A display name for a backup rule. Must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    rule_name: []const u8,

    /// Contains your scanning configuration for the backup rule and includes the
    /// malware scanner, and scan mode of either full or incremental.
    scan_actions: ?[]const ScanAction,

    /// A cron expression in UTC specifying when Backup initiates a backup job.
    /// When no CRON expression is provided, Backup will use the default
    /// expression `cron(0 5 ? * * *)`.
    ///
    /// For more information about Amazon Web Services cron expressions, see
    /// [Schedule Expressions for
    /// Rules](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html) in the *Amazon CloudWatch Events User
    /// Guide*.
    ///
    /// Two examples of Amazon Web Services cron expressions are ` 15 * ? * * *`
    /// (take
    /// a backup every hour at 15 minutes past the hour) and `0 12 * * ? *` (take a
    /// backup every day at 12 noon UTC).
    ///
    /// For a table of examples, click the preceding link and scroll down the page.
    schedule_expression: ?[]const u8,

    /// The timezone in which the schedule expression is set. By default,
    /// ScheduleExpressions are in UTC. You can modify this to a specified timezone.
    schedule_expression_timezone: ?[]const u8,

    /// A value in minutes after a backup is scheduled before a job will be canceled
    /// if it
    /// doesn't start successfully. This value is optional.
    /// If this value is included, it must be at least 60 minutes to avoid errors.
    ///
    /// During the start window, the backup job status remains in `CREATED` status
    /// until it
    /// has successfully begun or until the start window time has run out. If within
    /// the start
    /// window time Backup receives an error that allows the job to be retried,
    /// Backup will automatically retry to begin the job at least every 10 minutes
    /// until the backup
    /// successfully begins (the job status changes to `RUNNING`) or until the job
    /// status
    /// changes to `EXPIRED` (which is expected to occur when the start window time
    /// is over).
    start_window_minutes: ?i64,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    target_backup_vault_name: []const u8,

    /// The ARN of a logically air-gapped vault. ARN must be in the same account and
    /// Region.
    /// If provided, supported fully managed resources back up directly to logically
    /// air-gapped vault,
    /// while other supported resources create a temporary (billable) snapshot in
    /// backup vault,
    /// then copy it to logically air-gapped vault. Unsupported resources only back
    /// up to the specified
    /// backup vault.
    target_logically_air_gapped_backup_vault_arn: ?[]const u8,

    pub const json_field_names = .{
        .completion_window_minutes = "CompletionWindowMinutes",
        .copy_actions = "CopyActions",
        .enable_continuous_backup = "EnableContinuousBackup",
        .index_actions = "IndexActions",
        .lifecycle = "Lifecycle",
        .recovery_point_tags = "RecoveryPointTags",
        .rule_id = "RuleId",
        .rule_name = "RuleName",
        .scan_actions = "ScanActions",
        .schedule_expression = "ScheduleExpression",
        .schedule_expression_timezone = "ScheduleExpressionTimezone",
        .start_window_minutes = "StartWindowMinutes",
        .target_backup_vault_name = "TargetBackupVaultName",
        .target_logically_air_gapped_backup_vault_arn = "TargetLogicallyAirGappedBackupVaultArn",
    };
};
