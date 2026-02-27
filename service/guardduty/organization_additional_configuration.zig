const OrgFeatureStatus = @import("org_feature_status.zig").OrgFeatureStatus;
const OrgFeatureAdditionalConfiguration = @import("org_feature_additional_configuration.zig").OrgFeatureAdditionalConfiguration;

/// A list of additional configurations which will be configured for the
/// organization.
///
/// Additional configuration applies to only GuardDuty Runtime Monitoring
/// protection plan.
pub const OrganizationAdditionalConfiguration = struct {
    /// The status of the additional configuration that will be configured for the
    /// organization. Use one of the following
    /// values to configure the feature status for the entire organization:
    ///
    /// * `NEW`: Indicates that when a new account joins the organization, they will
    /// have the additional configuration enabled automatically.
    ///
    /// * `ALL`: Indicates that all accounts in the organization have
    /// the additional configuration
    /// enabled automatically. This includes `NEW` accounts that join the
    /// organization
    /// and accounts that may have been suspended or removed from the organization
    /// in
    /// GuardDuty.
    ///
    /// It may take up to 24 hours to update the configuration for all the member
    /// accounts.
    ///
    /// * `NONE`: Indicates that the additional configuration will not be
    /// automatically enabled for any
    /// account in the organization. The administrator must manage the additional
    /// configuration
    /// for each account individually.
    auto_enable: ?OrgFeatureStatus,

    /// The name of the additional configuration that will be configured for the
    /// organization. These values are applicable to only Runtime Monitoring
    /// protection plan.
    name: ?OrgFeatureAdditionalConfiguration,

    pub const json_field_names = .{
        .auto_enable = "AutoEnable",
        .name = "Name",
    };
};
