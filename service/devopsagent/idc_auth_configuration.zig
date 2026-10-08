/// Configuration for AWS Identity Center (IdC) authentication flow for the
/// Operator App.
pub const IdcAuthConfiguration = struct {
    /// The timestamp when the Operator App IdC auth flow was enabled.
    created_at: i64,

    /// The IdC application Arn created for IdC auth
    idc_application_arn: ?[]const u8 = null,

    /// The IdC instance Arn used to create an IdC auth application
    idc_instance_arn: []const u8,

    /// The IAM role end users assume to access AIDevOps APIs
    operator_app_role_arn: []const u8,

    /// The timestamp when the Operator App IdC auth flow was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .idc_application_arn = "idcApplicationArn",
        .idc_instance_arn = "idcInstanceArn",
        .operator_app_role_arn = "operatorAppRoleArn",
        .updated_at = "updatedAt",
    };
};
