/// The IAM Identity Center configuration for an application.
pub const IdCConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity Center application.
    idc_application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center instance.
    idc_instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .idc_application_arn = "idcApplicationArn",
        .idc_instance_arn = "idcInstanceArn",
    };
};
