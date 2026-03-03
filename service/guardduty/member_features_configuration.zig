const MemberAdditionalConfiguration = @import("member_additional_configuration.zig").MemberAdditionalConfiguration;
const OrgFeature = @import("org_feature.zig").OrgFeature;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Contains information about the features for the member account.
pub const MemberFeaturesConfiguration = struct {
    /// Additional configuration of the feature for the member account.
    additional_configuration: ?[]const MemberAdditionalConfiguration = null,

    /// The name of the feature.
    name: ?OrgFeature = null,

    /// The status of the feature.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .additional_configuration = "AdditionalConfiguration",
        .name = "Name",
        .status = "Status",
    };
};
