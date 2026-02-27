const aws = @import("aws");

const ProductionVariantInstanceType = @import("production_variant_instance_type.zig").ProductionVariantInstanceType;

/// The recommended configuration to use for Real-Time Inference.
pub const RealTimeInferenceRecommendation = struct {
    /// The recommended environment variables to set in the model container for
    /// Real-Time Inference.
    environment: ?[]const aws.map.StringMapEntry,

    /// The recommended instance type for Real-Time Inference.
    instance_type: ProductionVariantInstanceType,

    /// The recommendation ID which uniquely identifies each recommendation.
    recommendation_id: []const u8,

    pub const json_field_names = .{
        .environment = "Environment",
        .instance_type = "InstanceType",
        .recommendation_id = "RecommendationId",
    };
};
