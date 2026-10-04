/// Contains the Amazon Web Services IAM Identity Center configuration of a
/// SageMaker Partner AI App that uses `IDC` authorization.
pub const IdcConfigOutput = struct {
    /// The ARN of the Amazon Web Services IAM Identity Center application that
    /// SageMaker creates for the SageMaker Partner AI App.
    application_arn: ?[]const u8 = null,

    /// The ARN of the Amazon Web Services IAM Identity Center instance that the
    /// SageMaker Partner AI App uses to authenticate users.
    instance_arn: []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .instance_arn = "InstanceArn",
    };
};
