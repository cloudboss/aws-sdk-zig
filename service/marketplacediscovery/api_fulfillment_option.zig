const AwsSupportedService = @import("aws_supported_service.zig").AwsSupportedService;
const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;

/// Describes an API-based fulfillment option, where the product is accessed
/// through an API integration.
pub const ApiFulfillmentOption = struct {
    /// The AWS services supported by this API integration.
    aws_supported_services: []const AwsSupportedService,

    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    /// Instructions on how to integrate with and use this API.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_supported_services = "awsSupportedServices",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
        .usage_instructions = "usageInstructions",
    };
};
