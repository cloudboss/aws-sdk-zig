const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The Amazon SageMaker Canvas application setting where you configure document
/// querying.
pub const KendraSettings = struct {
    /// Describes whether the document querying feature is enabled or disabled in
    /// the Canvas application.
    status: ?FeatureStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
