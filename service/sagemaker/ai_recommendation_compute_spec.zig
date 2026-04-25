const AICapacityReservationConfig = @import("ai_capacity_reservation_config.zig").AICapacityReservationConfig;
const AIRecommendationInstanceType = @import("ai_recommendation_instance_type.zig").AIRecommendationInstanceType;

/// The compute resource specification for an AI recommendation job.
pub const AIRecommendationComputeSpec = struct {
    /// The capacity reservation configuration.
    capacity_reservation_config: ?AICapacityReservationConfig = null,

    /// The list of instance types to consider for recommendations. You can specify
    /// up to 3 instance types.
    instance_types: ?[]const AIRecommendationInstanceType = null,

    pub const json_field_names = .{
        .capacity_reservation_config = "CapacityReservationConfig",
        .instance_types = "InstanceTypes",
    };
};
