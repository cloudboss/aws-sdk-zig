const Conditions = @import("conditions.zig").Conditions;
const Condition = @import("condition.zig").Condition;

/// Used to specify a set of resources to a backup plan.
///
/// We recommend that you specify conditions, tags, or resources to include or
/// exclude.
/// Otherwise, Backup attempts to select all supported and opted-in storage
/// resources, which
/// could have unintended cost implications.
///
/// For more information, see [Assigning resources
/// programmatically](https://docs.aws.amazon.com/aws-backup/latest/devguide/assigning-resources.html#assigning-resources-json).
pub const BackupSelection = struct {
    /// The conditions that you define to assign resources to your backup plans
    /// using tags. For example,
    /// `"StringEquals": { "ConditionKey": "aws:ResourceTag/backup",
    /// "ConditionValue": "daily" }`.
    ///
    /// `Conditions` supports `StringEquals`,
    /// `StringLike`, `StringNotEquals`, and
    /// `StringNotLike`. Condition operators are case sensitive.
    ///
    /// If you specify multiple conditions, the resources much match all conditions
    /// (AND logic).
    conditions: ?Conditions = null,

    /// The ARN of the IAM role that Backup uses to authenticate when backing up the
    /// target resource; for example, `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// The conditions that you define to assign resources to your backup plans
    /// using tags. For example,
    /// `"StringEquals": { "ConditionKey": "backup", "ConditionValue": "daily"}`.
    ///
    /// `ListOfTags` supports only `StringEquals`. Condition operators are case
    /// sensitive.
    ///
    /// If you specify multiple conditions, the resources much match any of the
    /// conditions (OR logic).
    list_of_tags: ?[]const Condition = null,

    /// The Amazon Resource Names (ARNs) of the resources to exclude from a backup
    /// plan. The maximum number
    /// of ARNs is 500 without wildcards, or 30 ARNs with wildcards.
    ///
    /// If you need to exclude many resources from a backup plan, consider a
    /// different resource
    /// selection strategy, such as assigning only one or a few resource types or
    /// refining your
    /// resource selection using tags.
    not_resources: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARNs) of the resources to assign to a backup
    /// plan. The maximum number of
    /// ARNs is 500 without wildcards, or 30 ARNs with wildcards.
    ///
    /// If you need to assign many resources to a backup plan, consider a different
    /// resource
    /// selection strategy, such as assigning all resources of a resource type or
    /// refining your
    /// resource selection using tags.
    ///
    /// If you specify multiple ARNs, the resources much match any of the ARNs (OR
    /// logic).
    resources: ?[]const []const u8 = null,

    /// The display name of a resource selection document. Must contain 1 to 50
    /// alphanumeric or
    /// '-_.' characters.
    selection_name: []const u8,

    pub const json_field_names = .{
        .conditions = "Conditions",
        .iam_role_arn = "IamRoleArn",
        .list_of_tags = "ListOfTags",
        .not_resources = "NotResources",
        .resources = "Resources",
        .selection_name = "SelectionName",
    };
};
