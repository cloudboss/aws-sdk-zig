const ManagedBy = @import("managed_by.zig").ManagedBy;
const FeatureAdditionalConfiguration = @import("feature_additional_configuration.zig").FeatureAdditionalConfiguration;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Information about the additional configuration.
pub const DetectorAdditionalConfigurationResult = struct {
    /// Indicates what manages the additional configuration. A value of
    /// `GUARDDUTY_POLICY` means a GuardDuty policy manages the additional
    /// configuration.
    managed_by: ?ManagedBy = null,

    /// Name of the additional configuration.
    name: ?FeatureAdditionalConfiguration = null,

    /// Status of the additional configuration.
    status: ?FeatureStatus = null,

    /// The timestamp at which the additional configuration was last updated. This
    /// is in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .managed_by = "ManagedBy",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
