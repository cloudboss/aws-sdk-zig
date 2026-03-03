/// Configuration for integrating Argo CD with IAM Identity CenterIAM; Identity
/// Center. This allows you to use your organization's identity provider for
/// authentication to Argo CD.
pub const ArgoCdAwsIdcConfigRequest = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity CenterIAM; Identity
    /// Center instance to use for authentication.
    idc_instance_arn: []const u8,

    /// The Region where your IAM Identity CenterIAM; Identity Center instance is
    /// located.
    idc_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .idc_instance_arn = "idcInstanceArn",
        .idc_region = "idcRegion",
    };
};
