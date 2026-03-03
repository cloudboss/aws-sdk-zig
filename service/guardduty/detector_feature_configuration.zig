const DetectorAdditionalConfiguration = @import("detector_additional_configuration.zig").DetectorAdditionalConfiguration;
const DetectorFeature = @import("detector_feature.zig").DetectorFeature;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Contains information about a GuardDuty feature.
///
/// Specifying both EKS Runtime Monitoring (`EKS_RUNTIME_MONITORING`)
/// and Runtime Monitoring (`RUNTIME_MONITORING`) will cause an error.
/// You can add only one of these two features because Runtime Monitoring
/// already includes the
/// threat detection for Amazon EKS resources. For more information, see
/// [Runtime
/// Monitoring](https://docs.aws.amazon.com/guardduty/latest/ug/runtime-monitoring.html).
pub const DetectorFeatureConfiguration = struct {
    /// Additional configuration for a resource.
    additional_configuration: ?[]const DetectorAdditionalConfiguration = null,

    /// The name of the feature.
    name: ?DetectorFeature = null,

    /// The status of the feature.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .name = "Name",
        .status = "Status",
    };
};
