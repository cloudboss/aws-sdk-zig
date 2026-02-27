const AwsGuardDutyDetectorDataSourcesDetails = @import("aws_guard_duty_detector_data_sources_details.zig").AwsGuardDutyDetectorDataSourcesDetails;
const AwsGuardDutyDetectorFeaturesDetails = @import("aws_guard_duty_detector_features_details.zig").AwsGuardDutyDetectorFeaturesDetails;

/// Provides details about an Amazon GuardDuty detector. A detector is an object
/// that represents the GuardDuty service. A detector is required for GuardDuty
/// to become operational.
pub const AwsGuardDutyDetectorDetails = struct {
    /// Describes which data sources are activated for the detector.
    data_sources: ?AwsGuardDutyDetectorDataSourcesDetails,

    /// Describes which features are activated for the detector.
    features: ?[]const AwsGuardDutyDetectorFeaturesDetails,

    /// The publishing frequency of the finding.
    finding_publishing_frequency: ?[]const u8,

    /// The GuardDuty service role.
    service_role: ?[]const u8,

    /// The activation status of the detector.
    status: ?[]const u8,

    pub const json_field_names = .{
        .data_sources = "DataSources",
        .features = "Features",
        .finding_publishing_frequency = "FindingPublishingFrequency",
        .service_role = "ServiceRole",
        .status = "Status",
    };
};
