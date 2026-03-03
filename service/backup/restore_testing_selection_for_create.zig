const aws = @import("aws");

const ProtectedResourceConditions = @import("protected_resource_conditions.zig").ProtectedResourceConditions;

/// This contains metadata about a specific restore testing selection.
///
/// ProtectedResourceType is required, such as Amazon EBS or
/// Amazon EC2.
///
/// This consists of `RestoreTestingSelectionName`,
/// `ProtectedResourceType`, and one of the following:
///
/// * `ProtectedResourceArns`
///
/// * `ProtectedResourceConditions`
///
/// Each protected resource type can have one single value.
///
/// A restore testing selection can include a wildcard value ("*") for
/// `ProtectedResourceArns` along with `ProtectedResourceConditions`.
/// Alternatively, you can include up to 30 specific protected resource ARNs in
/// `ProtectedResourceArns`.
///
/// `ProtectedResourceConditions` examples include as `StringEquals`
/// and `StringNotEquals`.
pub const RestoreTestingSelectionForCreate = struct {
    /// The Amazon Resource Name (ARN) of the IAM role that
    /// Backup uses to create the target resource;
    /// for example: `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// Each protected resource can be filtered by its specific ARNs, such as
    /// `ProtectedResourceArns: ["arn:aws:...", "arn:aws:..."]`
    /// or by a wildcard: `ProtectedResourceArns: ["*"]`,
    /// but not both.
    protected_resource_arns: ?[]const []const u8 = null,

    /// If you have included the wildcard in ProtectedResourceArns,
    /// you can include resource conditions, such as
    /// `ProtectedResourceConditions: { StringEquals: [{ key: "XXXX",
    /// value: "YYYY" }]`.
    protected_resource_conditions: ?ProtectedResourceConditions = null,

    /// The type of Amazon Web Services resource included in a restore
    /// testing selection; for example, an Amazon EBS volume or
    /// an Amazon RDS database.
    ///
    /// Supported resource types accepted include:
    ///
    /// * `Aurora` for Amazon Aurora
    ///
    /// * `DocumentDB` for Amazon DocumentDB (with MongoDB compatibility)
    ///
    /// * `DynamoDB` for Amazon DynamoDB
    ///
    /// * `EBS` for Amazon Elastic Block Store
    ///
    /// * `EC2` for Amazon Elastic Compute Cloud
    ///
    /// * `EFS` for Amazon Elastic File System
    ///
    /// * `FSx` for Amazon FSx
    ///
    /// * `Neptune` for Amazon Neptune
    ///
    /// * `RDS` for Amazon Relational Database Service
    ///
    /// * `S3` for Amazon S3
    protected_resource_type: []const u8,

    /// You can override certain restore metadata keys by including the parameter
    /// `RestoreMetadataOverrides` in the body of
    /// `RestoreTestingSelection`. Key values are not case sensitive.
    ///
    /// See the complete list of [restore testing
    /// inferred
    /// metadata](https://docs.aws.amazon.com/aws-backup/latest/devguide/restore-testing-inferred-metadata.html).
    restore_metadata_overrides: ?[]const aws.map.StringMapEntry = null,

    /// The unique name of the restore testing selection
    /// that belongs to the related restore testing plan.
    ///
    /// The name consists of only alphanumeric characters and underscores.
    /// Maximum length is 50.
    restore_testing_selection_name: []const u8,

    /// This is amount of hours (0 to 168) available to run a validation script on
    /// the data. The
    /// data will be deleted upon the completion of the validation script or the end
    /// of the
    /// specified retention period, whichever comes first.
    validation_window_hours: i32 = 0,

    pub const json_field_names = .{
        .iam_role_arn = "IamRoleArn",
        .protected_resource_arns = "ProtectedResourceArns",
        .protected_resource_conditions = "ProtectedResourceConditions",
        .protected_resource_type = "ProtectedResourceType",
        .restore_metadata_overrides = "RestoreMetadataOverrides",
        .restore_testing_selection_name = "RestoreTestingSelectionName",
        .validation_window_hours = "ValidationWindowHours",
    };
};
