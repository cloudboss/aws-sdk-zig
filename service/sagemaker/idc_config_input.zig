/// Specifies the Amazon Web Services IAM Identity Center configuration to use
/// for a SageMaker Partner AI App that uses `IDC` authorization.
pub const IdcConfigInput = struct {
    /// The ARN of the Amazon Web Services IAM Identity Center instance that the
    /// SageMaker Partner AI App uses to authenticate users.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
    };
};
