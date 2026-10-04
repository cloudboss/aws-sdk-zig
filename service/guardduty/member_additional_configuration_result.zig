const ManagedBy = @import("managed_by.zig").ManagedBy;
const OrgFeatureAdditionalConfiguration = @import("org_feature_additional_configuration.zig").OrgFeatureAdditionalConfiguration;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Information about the additional configuration for the member account.
pub const MemberAdditionalConfigurationResult = struct {
    /// Indicates what manages the additional configuration. A value of
    /// `GUARDDUTY_POLICY` means a GuardDuty policy manages the additional
    /// configuration.
    managed_by: ?ManagedBy = null,

    /// Indicates the name of the additional configuration that is set for the
    /// member account.
    name: ?OrgFeatureAdditionalConfiguration = null,

    /// Indicates the status of the additional configuration that is set for the
    /// member account.
    status: ?FeatureStatus = null,

    /// The timestamp at which the additional configuration was set for the member
    /// account. This is in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .managed_by = "ManagedBy",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
