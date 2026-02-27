const ReplacePermissionAssociationsWorkStatus = @import("replace_permission_associations_work_status.zig").ReplacePermissionAssociationsWorkStatus;

/// A structure that represents the background work that RAM performs when you
/// invoke
/// the ReplacePermissionAssociations operation.
pub const ReplacePermissionAssociationsWork = struct {
    /// The date and time when this asynchronous background task was created.
    creation_time: ?i64,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed permission that this background task is replacing.
    from_permission_arn: ?[]const u8,

    /// The version of the managed permission that this background task is
    /// replacing.
    from_permission_version: ?[]const u8,

    /// The unique identifier for the background task associated with one
    /// ReplacePermissionAssociations request.
    id: ?[]const u8,

    /// The date and time when the status of this background task was last updated.
    last_updated_time: ?i64,

    /// Specifies the current status of the background tasks for the specified ID.
    /// The output
    /// is one of the following strings:
    ///
    /// * `IN_PROGRESS`
    ///
    /// * `COMPLETED`
    ///
    /// * `FAILED`
    status: ?ReplacePermissionAssociationsWorkStatus,

    /// Specifies the reason for a `FAILED` status. This field is present only when
    /// there `status` is `FAILED`.
    status_message: ?[]const u8,

    /// The ARN of the managed permission that this background task is associating
    /// with the resource shares in place
    /// of the managed permission and version specified in `fromPermissionArn` and
    /// `fromPermissionVersion`.
    to_permission_arn: ?[]const u8,

    /// The version of the managed permission that this background task is
    /// associating with the resource shares. This
    /// is always the version that is currently the default for this managed
    /// permission.
    to_permission_version: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .from_permission_arn = "fromPermissionArn",
        .from_permission_version = "fromPermissionVersion",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .status = "status",
        .status_message = "statusMessage",
        .to_permission_arn = "toPermissionArn",
        .to_permission_version = "toPermissionVersion",
    };
};
