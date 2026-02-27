const UnusedPermissionsRecommendedStep = @import("unused_permissions_recommended_step.zig").UnusedPermissionsRecommendedStep;

/// Contains information about a recommended step for an unused access analyzer
/// finding.
pub const RecommendedStep = union(enum) {
    /// A recommended step for an unused permissions finding.
    unused_permissions_recommended_step: ?UnusedPermissionsRecommendedStep,

    pub const json_field_names = .{
        .unused_permissions_recommended_step = "unusedPermissionsRecommendedStep",
    };
};
