/// This contains metadata about a restore testing selection.
pub const RestoreTestingSelectionForList = struct {
    /// The date and time that a restore testing selection
    /// was created, in Unix format and Coordinated Universal Time (UTC).
    /// The value of `CreationTime` is accurate to milliseconds.
    /// For example, the value 1516925490.087 represents Friday,
    /// January 26,2018 12:11:30.087 AM.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// Backup uses to create the target resource; for example:
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// The type of Amazon Web Services resource included in a restore
    /// testing selection; for example, an
    /// Amazon EBS volume or an
    /// Amazon RDS database.
    protected_resource_type: []const u8,

    /// Unique string that is the name of the restore testing plan.
    ///
    /// The name cannot be changed after creation. The name must
    /// consist of only alphanumeric characters and underscores.
    /// Maximum length is 50.
    restore_testing_plan_name: []const u8,

    /// Unique name of a restore testing selection.
    ///
    /// The name consists of only alphanumeric characters and underscores.
    /// Maximum length is 50.
    restore_testing_selection_name: []const u8,

    /// This value represents the time, in hours, data is retained after
    /// a restore test so that optional validation can be completed.
    ///
    /// Accepted value is an integer between
    /// 0 and 168 (the hourly equivalent of seven days).
    validation_window_hours: i32 = 0,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .iam_role_arn = "IamRoleArn",
        .protected_resource_type = "ProtectedResourceType",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
        .validation_window_hours = "ValidationWindowHours",
    };
};
