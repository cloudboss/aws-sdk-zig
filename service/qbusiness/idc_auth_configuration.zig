/// Information about the IAM Identity Center Application used to configure
/// authentication for a plugin.
pub const IdcAuthConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity Center Application used
    /// to configure authentication.
    idc_application_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to perform
    /// actions on Amazon Web Services services on your behalf.
    role_arn: []const u8,

    pub const json_field_names = .{
        .idc_application_arn = "idcApplicationArn",
        .role_arn = "roleArn",
    };
};
