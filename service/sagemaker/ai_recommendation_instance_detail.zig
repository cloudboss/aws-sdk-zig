const AIRecommendationInstanceType = @import("ai_recommendation_instance_type.zig").AIRecommendationInstanceType;

/// Instance details for a recommendation.
pub const AIRecommendationInstanceDetail = struct {
    /// The number of model copies per instance.
    copy_count_per_instance: ?i32 = null,

    /// The recommended number of instances.
    instance_count: ?i32 = null,

    /// The recommended instance type.
    instance_type: ?AIRecommendationInstanceType = null,

    pub const json_field_names = .{
        .copy_count_per_instance = "CopyCountPerInstance",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
    };
};
