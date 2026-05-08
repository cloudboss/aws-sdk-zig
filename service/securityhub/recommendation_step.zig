const UnusedPermissionsRecommendationStep = @import("unused_permissions_recommendation_step.zig").UnusedPermissionsRecommendationStep;

/// Contains information about a recommended step to remediate a Security Hub
/// finding.
pub const RecommendationStep = union(enum) {
    /// A recommended step to remediate an unused permissions finding.
    unused_permissions: ?UnusedPermissionsRecommendationStep,

    pub const json_field_names = .{
        .unused_permissions = "UnusedPermissions",
    };
};
