const DashboardAttributes = @import("dashboard_attributes.zig").DashboardAttributes;
const GuardianAttributes = @import("guardian_attributes.zig").GuardianAttributes;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The VDM attributes that apply to your Amazon SES account.
pub const VdmAttributes = struct {
    /// Specifies additional settings for your VDM configuration as applicable to
    /// the
    /// Dashboard.
    dashboard_attributes: ?DashboardAttributes,

    /// Specifies additional settings for your VDM configuration as applicable to
    /// the
    /// Guardian.
    guardian_attributes: ?GuardianAttributes,

    /// Specifies the status of your VDM configuration. Can be one of the following:
    ///
    /// * `ENABLED` – Amazon SES enables VDM for your account.
    ///
    /// * `DISABLED` – Amazon SES disables VDM for your account.
    vdm_enabled: FeatureStatus,

    pub const json_field_names = .{
        .dashboard_attributes = "DashboardAttributes",
        .guardian_attributes = "GuardianAttributes",
        .vdm_enabled = "VdmEnabled",
    };
};
