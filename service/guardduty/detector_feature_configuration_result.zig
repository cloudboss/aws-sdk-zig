const DetectorAdditionalConfigurationResult = @import("detector_additional_configuration_result.zig").DetectorAdditionalConfigurationResult;
const ManagedBy = @import("managed_by.zig").ManagedBy;
const DetectorFeatureResult = @import("detector_feature_result.zig").DetectorFeatureResult;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Contains information about a GuardDuty feature.
///
/// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`) and
/// Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error. You can add
/// only one of these two features because Runtime Monitoring already includes
/// the threat detection for Amazon EKS resources. For more information, see
/// [Runtime
/// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
pub const DetectorFeatureConfigurationResult = struct {
    /// Additional configuration for a resource.
    additional_configuration: ?[]const DetectorAdditionalConfigurationResult = null,

    /// Indicates what manages the feature. A value of `GUARDDUTY_POLICY` means a
    /// GuardDuty policy manages the feature.
    managed_by: ?ManagedBy = null,

    /// Indicates the name of the feature that can be enabled for the detector.
    name: ?DetectorFeatureResult = null,

    /// Indicates the status of the feature that is enabled for the detector.
    status: ?FeatureStatus = null,

    /// The timestamp at which the feature object was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .managed_by = "ManagedBy",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
