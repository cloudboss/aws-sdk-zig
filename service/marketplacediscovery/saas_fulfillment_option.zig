const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;
const SaasQuickLaunchStatus = @import("saas_quick_launch_status.zig").SaasQuickLaunchStatus;

/// Describes a Software as a Service (SaaS) fulfillment option.
pub const SaasFulfillmentOption = struct {
    /// The date and time when the SaaS product became available for fulfillment.
    available_from_time: ?i64 = null,

    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    /// The URL of the seller's software registration landing page.
    fulfillment_url: ?[]const u8 = null,

    /// The URL that a buyer uses to launch the seller's SaaS product. This URL is
    /// distinct from `fulfillmentUrl`, which is the seller's software registration
    /// landing page.
    launch_url: ?[]const u8 = null,

    /// Specifies whether the SaaS product supports quick-launch deployment.
    quick_launch: SaasQuickLaunchStatus,

    /// Instructions on how to access and use this SaaS product.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_from_time = "availableFromTime",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_url = "fulfillmentUrl",
        .launch_url = "launchUrl",
        .quick_launch = "quickLaunch",
        .usage_instructions = "usageInstructions",
    };
};
