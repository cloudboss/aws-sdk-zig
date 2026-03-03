const MemberAdditionalConfigurationResult = @import("member_additional_configuration_result.zig").MemberAdditionalConfigurationResult;
const OrgFeature = @import("org_feature.zig").OrgFeature;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Contains information about the features for the member account.
pub const MemberFeaturesConfigurationResult = struct {
    /// Indicates the additional configuration of the feature that is configured for
    /// the member
    /// account.
    additional_configuration: ?[]const MemberAdditionalConfigurationResult = null,

    /// Indicates the name of the feature that is enabled for the detector.
    name: ?OrgFeature = null,

    /// Indicates the status of the feature that is enabled for the detector.
    status: ?FeatureStatus = null,

    /// The timestamp at which the feature object was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
