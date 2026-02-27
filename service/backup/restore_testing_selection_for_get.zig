const aws = @import("aws");

const ProtectedResourceConditions = @import("protected_resource_conditions.zig").ProtectedResourceConditions;

/// This contains metadata about a restore testing selection.
pub const RestoreTestingSelectionForGet = struct {
    /// The date and time that a restore testing selection was created,
    /// in Unix format and Coordinated Universal Time (UTC). The value of
    /// `CreationTime` is accurate to milliseconds. For example,
    /// the value 1516925490.087 represents Friday, January 26,
    /// 201812:11:30.087 AM.
    creation_time: i64,

    /// This identifies the request and allows failed requests to
    /// be retried without the risk of running the operation twice.
    /// If the request includes a `CreatorRequestId` that
    /// matches an existing backup plan, that plan is returned. This
    /// parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric
    /// or '-_.' characters.
    creator_request_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// Backup uses to create the target resource; for
    /// example:`arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// You can include specific ARNs, such as
    /// `ProtectedResourceArns: ["arn:aws:...", "arn:aws:..."]`
    /// or you can include a wildcard: `ProtectedResourceArns: ["*"]`,
    /// but not both.
    protected_resource_arns: ?[]const []const u8,

    /// In a resource testing selection, this parameter filters by
    /// specific conditions such as `StringEquals` or
    /// `StringNotEquals`.
    protected_resource_conditions: ?ProtectedResourceConditions,

    /// The type of Amazon Web Services resource included in a resource
    /// testing selection;
    /// for example, an Amazon EBS volume
    /// or an Amazon RDS database.
    protected_resource_type: []const u8,

    /// You can override certain restore metadata keys by including the parameter
    /// `RestoreMetadataOverrides` in the body of
    /// `RestoreTestingSelection`. Key values are not case sensitive.
    ///
    /// See the complete list of [restore testing
    /// inferred
    /// metadata](https://docs.aws.amazon.com/aws-backup/latest/devguide/restore-testing-inferred-metadata.html).
    restore_metadata_overrides: ?[]const aws.map.StringMapEntry,

    /// The RestoreTestingPlanName is a unique string that is the name
    /// of the restore testing plan.
    restore_testing_plan_name: []const u8,

    /// The unique name of the restore testing selection that
    /// belongs to the related restore testing plan.
    ///
    /// The name consists of only alphanumeric characters and underscores.
    /// Maximum length is 50.
    restore_testing_selection_name: []const u8,

    /// This is amount of hours (1 to 168) available to run a validation script on
    /// the data. The
    /// data will be deleted upon the completion of the validation script or the end
    /// of the
    /// specified retention period, whichever comes first.
    validation_window_hours: i32 = 0,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .iam_role_arn = "IamRoleArn",
        .protected_resource_arns = "ProtectedResourceArns",
        .protected_resource_conditions = "ProtectedResourceConditions",
        .protected_resource_type = "ProtectedResourceType",
        .restore_metadata_overrides = "RestoreMetadataOverrides",
        .restore_testing_plan_name = "RestoreTestingPlanName",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
        .validation_window_hours = "ValidationWindowHours",
    };
};
