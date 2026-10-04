const ManagedConfiguration = @import("managed_configuration.zig").ManagedConfiguration;
const ModelPackageGroupStatus = @import("model_package_group_status.zig").ModelPackageGroupStatus;

/// Summary information about a model group.
pub const ModelPackageGroupSummary = struct {
    /// The time that the model group was created.
    creation_time: i64,

    /// The managed configuration of the model package group.
    managed_configuration: ?ManagedConfiguration = null,

    /// The Amazon Resource Name (ARN) of the model group.
    model_package_group_arn: []const u8,

    /// A description of the model group.
    model_package_group_description: ?[]const u8 = null,

    /// The name of the model group.
    model_package_group_name: []const u8,

    /// The status of the model group.
    model_package_group_status: ModelPackageGroupStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .managed_configuration = "ManagedConfiguration",
        .model_package_group_arn = "ModelPackageGroupArn",
        .model_package_group_description = "ModelPackageGroupDescription",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_group_status = "ModelPackageGroupStatus",
    };
};
