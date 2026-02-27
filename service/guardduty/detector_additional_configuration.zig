const FeatureAdditionalConfiguration = @import("feature_additional_configuration.zig").FeatureAdditionalConfiguration;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Information about the additional configuration for a feature in your
/// GuardDuty account.
pub const DetectorAdditionalConfiguration = struct {
    /// Name of the additional configuration.
    name: ?FeatureAdditionalConfiguration,

    /// Status of the additional configuration.
    status: ?FeatureStatus,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};
