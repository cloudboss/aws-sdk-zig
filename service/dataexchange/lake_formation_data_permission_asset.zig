const LakeFormationDataPermissionDetails = @import("lake_formation_data_permission_details.zig").LakeFormationDataPermissionDetails;
const LakeFormationDataPermissionType = @import("lake_formation_data_permission_type.zig").LakeFormationDataPermissionType;
const LFPermission = @import("lf_permission.zig").LFPermission;

/// The AWS Lake Formation data permission asset.
pub const LakeFormationDataPermissionAsset = struct {
    /// Details about the AWS Lake Formation data permission.
    lake_formation_data_permission_details: LakeFormationDataPermissionDetails,

    /// The data permission type.
    lake_formation_data_permission_type: LakeFormationDataPermissionType,

    /// The permissions granted to the subscribers on the resource.
    permissions: []const LFPermission,

    /// The IAM role's ARN that allows AWS Data Exchange to assume the role and
    /// grant and revoke permissions to AWS Lake Formation data permissions.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lake_formation_data_permission_details = "LakeFormationDataPermissionDetails",
        .lake_formation_data_permission_type = "LakeFormationDataPermissionType",
        .permissions = "Permissions",
        .role_arn = "RoleArn",
    };
};
