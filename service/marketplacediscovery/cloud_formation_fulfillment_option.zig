const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;

/// Describes an AWS CloudFormation template fulfillment option for
/// infrastructure deployment.
pub const CloudFormationFulfillmentOption = struct {
    /// The date and time when the CloudFormation fulfillment option became
    /// available for fulfillment.
    available_from_time: ?i64 = null,

    /// A human-readable name for the fulfillment option type.
    fulfillment_option_display_name: []const u8,

    /// The unique identifier of the fulfillment option.
    fulfillment_option_id: []const u8,

    /// The display name of the fulfillment option version.
    fulfillment_option_name: []const u8,

    /// The category of the fulfillment option.
    fulfillment_option_type: FulfillmentOptionType,

    /// The version identifier of the fulfillment option.
    fulfillment_option_version: ?[]const u8 = null,

    /// A detailed description of the fulfillment option.
    long_description: ?[]const u8 = null,

    /// Release notes describing changes in this version of the fulfillment option.
    release_notes: ?[]const u8 = null,

    /// A short description of the fulfillment option.
    short_description: ?[]const u8 = null,

    /// Instructions on how to deploy and use this CloudFormation template.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_from_time = "availableFromTime",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_name = "fulfillmentOptionName",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_option_version = "fulfillmentOptionVersion",
        .long_description = "longDescription",
        .release_notes = "releaseNotes",
        .short_description = "shortDescription",
        .usage_instructions = "usageInstructions",
    };
};
