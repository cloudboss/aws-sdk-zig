const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;

/// A summary of a fulfillment option available for deploying or accessing a
/// listing or product.
pub const FulfillmentOptionSummary = struct {
    /// The human-readable name of the fulfillment option type.
    display_name: []const u8,

    /// The machine-readable type of the fulfillment option, such as `SAAS` or
    /// `AMAZON_MACHINE_IMAGE`.
    fulfillment_option_type: FulfillmentOptionType,

    pub const json_field_names = .{
        .display_name = "displayName",
        .fulfillment_option_type = "fulfillmentOptionType",
    };
};
