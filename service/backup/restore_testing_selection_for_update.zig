const aws = @import("aws");

const ProtectedResourceConditions = @import("protected_resource_conditions.zig").ProtectedResourceConditions;

/// This contains metadata about a restore testing selection.
pub const RestoreTestingSelectionForUpdate = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// Backup uses to create the target resource; for example:
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8,

    /// You can include a list of specific ARNs, such as
    /// `ProtectedResourceArns: ["arn:aws:...", "arn:aws:..."]`
    /// or you can include a wildcard: `ProtectedResourceArns: ["*"]`,
    /// but not both.
    protected_resource_arns: ?[]const []const u8,

    /// The conditions that you define for resources in
    /// your restore testing plan using tags.
    protected_resource_conditions: ?ProtectedResourceConditions,

    /// You can override certain restore metadata keys by including the parameter
    /// `RestoreMetadataOverrides` in the body of
    /// `RestoreTestingSelection`. Key values are not case sensitive.
    ///
    /// See the complete list of [restore testing
    /// inferred
    /// metadata](https://docs.aws.amazon.com/aws-backup/latest/devguide/restore-testing-inferred-metadata.html).
    restore_metadata_overrides: ?[]const aws.map.StringMapEntry,

    /// This value represents the time, in hours, data is retained after
    /// a restore test so that optional validation can be completed.
    ///
    /// Accepted value is an integer between
    /// 0 and 168 (the hourly equivalent of seven days).
    validation_window_hours: i32 = 0,

    pub const json_field_names = .{
        .iam_role_arn = "IamRoleArn",
        .protected_resource_arns = "ProtectedResourceArns",
        .protected_resource_conditions = "ProtectedResourceConditions",
        .restore_metadata_overrides = "RestoreMetadataOverrides",
        .validation_window_hours = "ValidationWindowHours",
    };
};
