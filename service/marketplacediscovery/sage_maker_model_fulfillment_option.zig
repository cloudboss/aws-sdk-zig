const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;
const SageMakerModelRecommendation = @import("sage_maker_model_recommendation.zig").SageMakerModelRecommendation;

/// Describes an Amazon SageMaker model fulfillment option, including version
/// details and recommended instance types.
pub const SageMakerModelFulfillmentOption = struct {
    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    /// The version identifier of the fulfillment option.
    fulfillment_option_version: ?[]const u8 = null,

    /// Recommended instance types for inference with this model.
    recommendation: ?SageMakerModelRecommendation = null,

    /// Release notes describing changes in this version of the fulfillment option.
    release_notes: ?[]const u8 = null,

    /// The MIME types that this model accepts as input.
    supported_content_types: ?[]const []const u8 = null,

    /// The MIME types that this model returns as output.
    supported_response_mime_types: ?[]const []const u8 = null,

    /// Instructions on how to use this SageMaker model.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_option_version = "fulfillmentOptionVersion",
        .recommendation = "recommendation",
        .release_notes = "releaseNotes",
        .supported_content_types = "supportedContentTypes",
        .supported_response_mime_types = "supportedResponseMimeTypes",
        .usage_instructions = "usageInstructions",
    };
};
