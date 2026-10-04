const Tag = @import("tag.zig").Tag;

/// Contains configuration and status information for an Amazon Redshift Query
/// Editor (QEV2) application that is registered with IAM Identity Center.
pub const Qev2IdcApplication = struct {
    /// The display name for the Amazon Redshift Query Editor (QEV2) IAM Identity
    /// Center application. It appears in the console.
    idc_display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center instance that the
    /// Amazon Redshift Query Editor (QEV2) application integrates with.
    idc_instance_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the Amazon Redshift Query Editor (QEV2)
    /// IAM Identity Center managed application.
    idc_managed_application_arn: ?[]const u8 = null,

    /// The onboarding status for the Amazon Redshift Query Editor (QEV2) IAM
    /// Identity Center application.
    idc_onboard_status: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the Amazon Redshift Query Editor (QEV2)
    /// application that integrates with IAM Identity Center.
    qev_2_idc_application_arn: ?[]const u8 = null,

    /// The name of the Amazon Redshift Query Editor (QEV2) application in IAM
    /// Identity Center.
    qev_2_idc_application_name: ?[]const u8 = null,

    /// A list of tags associated with the application. Tags are key-value pairs
    /// that you can use to organize and identify your resources.
    tags: ?[]const Tag = null,
};
