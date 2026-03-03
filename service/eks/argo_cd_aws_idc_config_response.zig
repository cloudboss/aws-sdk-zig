/// The response object containing IAM Identity CenterIAM; Identity Center
/// configuration details for an Argo CD capability.
pub const ArgoCdAwsIdcConfigResponse = struct {
    /// The Amazon Resource Name (ARN) of the IAM Identity CenterIAM; Identity
    /// Center instance used for authentication.
    idc_instance_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the managed application created in IAM
    /// Identity CenterIAM; Identity Center for this Argo CD capability. This
    /// application is automatically created and managed by Amazon EKS.
    idc_managed_application_arn: ?[]const u8 = null,

    /// The Region where the IAM Identity CenterIAM; Identity Center instance is
    /// located.
    idc_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .idc_instance_arn = "idcInstanceArn",
        .idc_managed_application_arn = "idcManagedApplicationArn",
        .idc_region = "idcRegion",
    };
};
