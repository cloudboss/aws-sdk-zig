const FeatureAdditionalConfiguration = @import("feature_additional_configuration.zig").FeatureAdditionalConfiguration;
const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Information about the additional configuration.
pub const DetectorAdditionalConfigurationResult = struct {
    /// Name of the additional configuration.
    name: ?FeatureAdditionalConfiguration = null,

    /// Status of the additional configuration.
    status: ?FeatureStatus = null,

    /// The timestamp at which the additional configuration was last updated. This
    /// is in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
