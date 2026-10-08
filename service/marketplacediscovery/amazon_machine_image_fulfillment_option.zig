const AmazonMachineImageEbsVolume = @import("amazon_machine_image_ebs_volume.zig").AmazonMachineImageEbsVolume;
const FulfillmentOptionType = @import("fulfillment_option_type.zig").FulfillmentOptionType;
const AmazonMachineImageOperatingSystem = @import("amazon_machine_image_operating_system.zig").AmazonMachineImageOperatingSystem;
const AmazonMachineImageRecommendation = @import("amazon_machine_image_recommendation.zig").AmazonMachineImageRecommendation;

/// Describes an Amazon Machine Image (AMI) fulfillment option, including
/// version details, supported operating systems, and recommended instance
/// types.
pub const AmazonMachineImageFulfillmentOption = struct {
    /// The URL pattern for accessing the product when an instance is running.
    access_url_template: ?[]const u8 = null,

    /// The alias of the AMI associated with this fulfillment option.
    ami_alias: ?[]const u8 = null,

    /// The architecture of the AMI, such as `x86_64`.
    architecture: []const u8,

    /// The date and time when the AMI became available for fulfillment.
    available_from_time: ?i64 = null,

    /// The supported Amazon EBS volume configuration for the AMI.
    ebs_volume: ?AmazonMachineImageEbsVolume = null,

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

    /// The operating systems supported by this AMI.
    operating_systems: []const AmazonMachineImageOperatingSystem,

    /// Recommended instance types for running this AMI.
    recommendation: ?AmazonMachineImageRecommendation = null,

    /// Release notes describing changes in this version of the fulfillment option.
    release_notes: ?[]const u8 = null,

    /// A short description of the fulfillment option.
    short_description: ?[]const u8 = null,

    /// Instructions on how to deploy and use this fulfillment option.
    usage_instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_url_template = "accessUrlTemplate",
        .ami_alias = "amiAlias",
        .architecture = "architecture",
        .available_from_time = "availableFromTime",
        .ebs_volume = "ebsVolume",
        .fulfillment_option_display_name = "fulfillmentOptionDisplayName",
        .fulfillment_option_id = "fulfillmentOptionId",
        .fulfillment_option_name = "fulfillmentOptionName",
        .fulfillment_option_type = "fulfillmentOptionType",
        .fulfillment_option_version = "fulfillmentOptionVersion",
        .operating_systems = "operatingSystems",
        .recommendation = "recommendation",
        .release_notes = "releaseNotes",
        .short_description = "shortDescription",
        .usage_instructions = "usageInstructions",
    };
};
