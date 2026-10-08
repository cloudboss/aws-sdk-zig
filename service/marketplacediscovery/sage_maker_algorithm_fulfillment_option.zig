const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;
const SageMakerAlgorithmRecommendation = @import("sage_maker_algorithm_recommendation.zig").SageMakerAlgorithmRecommendation;

/// Describes an Amazon SageMaker algorithm fulfillment option, including
/// version details and recommended instance types.
pub const SageMakerAlgorithmFulfillmentOption = struct {
    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    /// The version identifier of the fulfillment option.
    fulfillment_option_version: ?[]const u8 = null,

    /// Recommended instance types for training and inference with this algorithm.
    recommendation: ?SageMakerAlgorithmRecommendation = null,

    /// Release notes describing changes in this version of the fulfillment option.
    release_notes: ?[]const u8 = null,

    /// Instructions on how to use this SageMaker algorithm.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_option_version = "fulfillmentOptionVersion",
        .recommendation = "recommendation",
        .release_notes = "releaseNotes",
        .usage_instructions = "usageInstructions",
    };
};
