const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// Contains the status and metadata for an opt-in feature.
pub const FeatureDetail = struct {
    /// The current enablement status of the feature. Valid values: `ENABLED` |
    /// `DISABLED`.
    feature_status: ?FeatureStatus = null,

    /// The date and time when the feature status was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .feature_status = "FeatureStatus",
        .updated_at = "UpdatedAt",
    };
};
