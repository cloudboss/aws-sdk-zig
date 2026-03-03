const OrganizationAdditionalConfiguration = @import("organization_additional_configuration.zig").OrganizationAdditionalConfiguration;
const OrgFeatureStatus = @import("org_feature_status.zig").OrgFeatureStatus;
const OrgFeature = @import("org_feature.zig").OrgFeature;

/// A list of features which will be configured for the organization.
pub const OrganizationFeatureConfiguration = struct {
    /// The additional information that will be configured for the organization.
    additional_configuration: ?[]const OrganizationAdditionalConfiguration = null,

    /// Describes the status of the feature that is configured for the
    /// member accounts within the organization. One of the following
    /// values is the status for the entire organization:
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
    /// It may take up to 24 hours to update the configuration for all the member
    /// accounts.
    ///
    /// * `NONE`: Indicates that the feature will not be
    /// automatically enabled for any
    /// account in the organization. The administrator must manage the feature
    /// for each account individually.
    auto_enable: ?OrgFeatureStatus = null,

    /// The name of the feature that will be configured for the organization.
    name: ?OrgFeature = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .auto_enable = "AutoEnable",
        .name = "Name",
    };
};
