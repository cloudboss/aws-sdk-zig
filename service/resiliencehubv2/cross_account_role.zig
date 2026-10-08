/// Specifies a cross-account IAM role ARN and optional external ID.
pub const CrossAccountRole = struct {
    cross_account_role_arn: []const u8,

    /// The external ID used for assuming the cross-account role.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cross_account_role_arn = "crossAccountRoleArn",
        .external_id = "externalId",
    };
};
