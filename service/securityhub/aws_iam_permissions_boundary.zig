/// Information about the policy used to set the permissions boundary for an IAM
/// principal.
pub const AwsIamPermissionsBoundary = struct {
    /// The ARN of the policy used to set the permissions boundary.
    permissions_boundary_arn: ?[]const u8 = null,

    /// The usage type for the permissions boundary.
    permissions_boundary_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .permissions_boundary_arn = "PermissionsBoundaryArn",
        .permissions_boundary_type = "PermissionsBoundaryType",
    };
};
