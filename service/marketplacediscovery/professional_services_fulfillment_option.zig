const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;

/// Describes a professional services fulfillment option.
pub const ProfessionalServicesFulfillmentOption = struct {
    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    pub const json_field_names = .{
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
    };
};
