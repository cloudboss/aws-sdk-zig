const OrgFeatureAdditionalConfiguration = @import("org_feature_additional_configuration.zig").OrgFeatureAdditionalConfiguration;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Information about the additional configuration for the member account.
pub const MemberAdditionalConfiguration = struct {
    /// Name of the additional configuration.
    name: ?OrgFeatureAdditionalConfiguration = null,

    /// Status of the additional configuration.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};
