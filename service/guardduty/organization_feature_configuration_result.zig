const OrganizationAdditionalConfigurationResult = @import("organization_additional_configuration_result.zig").OrganizationAdditionalConfigurationResult;
const OrgFeatureStatus = @import("org_feature_status.zig").OrgFeatureStatus;
const OrgFeature = @import("org_feature.zig").OrgFeature;

/// A list of features which will be configured for the organization.
pub const OrganizationFeatureConfigurationResult = struct {
    /// The additional configuration that is configured for the member accounts
    /// within the
    /// organization.
    additional_configuration: ?[]const OrganizationAdditionalConfigurationResult = null,

    /// Describes the status of the feature that is configured for the member
    /// accounts within
    /// the organization.
    ///
    /// * `NEW`: Indicates that when a new account joins the organization, they will
    /// have the feature enabled automatically.
    ///
    /// * `ALL`: Indicates that all accounts in the organization have the feature
    /// enabled automatically. This includes `NEW` accounts that join the
    /// organization
    /// and accounts that may have been suspended or removed from the organization
    /// in
    /// GuardDuty.
    ///
    /// * `NONE`: Indicates that the feature will not be automatically enabled for
    ///   any
    /// account in the organization. In this case, each account will be managed
    /// individually
    /// by the
    /// administrator.
    auto_enable: ?OrgFeatureStatus = null,

    /// The name of the feature that is configured for the member accounts within
    /// the
    /// organization.
    name: ?OrgFeature = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .auto_enable = "AutoEnable",
        .name = "Name",
    };
};
