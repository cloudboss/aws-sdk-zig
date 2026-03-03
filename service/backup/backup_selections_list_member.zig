/// Contains metadata about a `BackupSelection` object.
pub const BackupSelectionsListMember = struct {
    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// The date and time a backup plan is created, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8 = null,

    /// Specifies the IAM role Amazon Resource Name (ARN) to create the target
    /// recovery point;
    /// for example, `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8 = null,

    /// Uniquely identifies a request to assign a set of resources to a backup plan.
    selection_id: ?[]const u8 = null,

    /// The display name of a resource selection document.
    selection_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
        .creation_date = "CreationDate",
        .creator_request_id = "CreatorRequestId",
        .iam_role_arn = "IamRoleArn",
        .selection_id = "SelectionId",
        .selection_name = "SelectionName",
    };
};
