const AwsSupportedService = @import("aws_supported_service.zig").AwsSupportedService;
const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;
const HelmOperatingSystem = @import("helm_operating_system.zig").HelmOperatingSystem;

/// Describes a Helm chart fulfillment option for Kubernetes deployment.
pub const HelmFulfillmentOption = struct {
    /// The AWS services supported by this Helm chart deployment.
    aws_supported_services: ?[]const AwsSupportedService = null,

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

    /// The operating systems supported by this Helm chart.
    operating_systems: ?[]const HelmOperatingSystem = null,

    /// Release notes describing changes in this version of the fulfillment option.
    release_notes: ?[]const u8 = null,

    /// Instructions on how to deploy and use this Helm chart.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_supported_services = "awsSupportedServices",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_name = "fulfillmentOptionName",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_option_version = "fulfillmentOptionVersion",
        .operating_systems = "operatingSystems",
        .release_notes = "releaseNotes",
        .usage_instructions = "usageInstructions",
    };
};
