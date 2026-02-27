const UserContext = @import("user_context.zig").UserContext;
const ModelPackageGroupStatus = @import("model_package_group_status.zig").ModelPackageGroupStatus;
const Tag = @import("tag.zig").Tag;

/// A group of versioned models in the Model Registry.
pub const ModelPackageGroup = struct {
    created_by: ?UserContext,

    /// The time that the model group was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the model group.
    model_package_group_arn: ?[]const u8,

    /// The description for the model group.
    model_package_group_description: ?[]const u8,

    /// The name of the model group.
    model_package_group_name: ?[]const u8,

    /// The status of the model group. This can be one of the following values.
    ///
    /// * `PENDING` - The model group is pending being created.
    /// * `IN_PROGRESS` - The model group is in the process of being created.
    /// * `COMPLETED` - The model group was successfully created.
    /// * `FAILED` - The model group failed.
    /// * `DELETING` - The model group is in the process of being deleted.
    /// * `DELETE_FAILED` - SageMaker failed to delete the model group.
    model_package_group_status: ?ModelPackageGroupStatus,

    /// A list of the tags associated with the model group. For more information,
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .model_package_group_arn = "ModelPackageGroupArn",
        .model_package_group_description = "ModelPackageGroupDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_group_status = "ModelPackageGroupStatus",
        .tags = "Tags",
    };
};
