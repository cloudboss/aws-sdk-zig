/// Contains information about the restore testing plan that
/// Backup used to initiate the restore job.
pub const RestoreJobCreator = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies
    /// a restore testing plan.
    restore_testing_plan_arn: ?[]const u8,

    pub const json_field_names = .{
        .restore_testing_plan_arn = "RestoreTestingPlanArn",
    };
};
