const aws = @import("aws");

const WriteTreatmentResource = @import("write_treatment_resource.zig").WriteTreatmentResource;
const CustomDeliveryConfiguration = @import("custom_delivery_configuration.zig").CustomDeliveryConfiguration;
const CampaignHook = @import("campaign_hook.zig").CampaignHook;
const CampaignLimits = @import("campaign_limits.zig").CampaignLimits;
const MessageConfiguration = @import("message_configuration.zig").MessageConfiguration;
const Schedule = @import("schedule.zig").Schedule;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;

/// Specifies the configuration and other settings for a campaign.
pub const WriteCampaignRequest = struct {
    /// An array of requests that defines additional treatments for the campaign, in
    /// addition to the default treatment for the campaign.
    additional_treatments: ?[]const WriteTreatmentResource = null,

    /// The delivery configuration settings for sending the campaign through a
    /// custom channel. This object is required if the MessageConfiguration object
    /// for the campaign specifies a CustomMessage object.
    custom_delivery_configuration: ?CustomDeliveryConfiguration = null,

    /// A custom description of the campaign.
    description: ?[]const u8 = null,

    /// The allocated percentage of users (segment members) who shouldn't receive
    /// messages from the campaign.
    holdout_percent: ?i32 = null,

    /// The settings for the AWS Lambda function to invoke as a code hook for the
    /// campaign. You can use this hook to customize the segment that's used by the
    /// campaign.
    hook: ?CampaignHook = null,

    /// Specifies whether to pause the campaign. A paused campaign doesn't run
    /// unless you resume it by changing this value to false.
    is_paused: ?bool = null,

    /// The messaging limits for the campaign.
    limits: ?CampaignLimits = null,

    /// The message configuration settings for the campaign.
    message_configuration: ?MessageConfiguration = null,

    /// A custom name for the campaign.
    name: ?[]const u8 = null,

    /// Defines the priority of the campaign, used to decide the order of messages
    /// displayed to user if there are multiple messages scheduled to be displayed
    /// at the same moment.
    priority: ?i32 = null,

    /// The schedule settings for the campaign.
    schedule: ?Schedule = null,

    /// The unique identifier for the segment to associate with the campaign.
    segment_id: ?[]const u8 = null,

    /// The version of the segment to associate with the campaign.
    segment_version: ?i32 = null,

    /// As of **22-05-2023** tags has been deprecated for update operations. After
    /// this date any value in tags is not processed and an error code is not
    /// returned. To manage tags we recommend using either
    /// [Tags](https://docs.aws.amazon.com/pinpoint/latest/apireference/tags-resource-arn.html) in the *API Reference for Amazon Pinpoint*, [resourcegroupstaggingapi](https://docs.aws.amazon.com/cli/latest/reference/resourcegroupstaggingapi/index.html) commands in the *AWS Command Line Interface Documentation* or [resourcegroupstaggingapi](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/resourcegroupstaggingapi/package-summary.html) in the *AWS SDK*.
    ///
    /// (Deprecated) A string-to-string map of key-value pairs that defines the tags
    /// to associate with the campaign. Each tag consists of a required tag key and
    /// an associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The message template to use for the campaign.
    template_configuration: ?TemplateConfiguration = null,

    /// A custom description of the default treatment for the campaign.
    treatment_description: ?[]const u8 = null,

    /// A custom name of the default treatment for the campaign, if the campaign has
    /// multiple treatments. A *treatment* is a variation of a campaign that's used
    /// for A/B testing.
    treatment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_treatments = "AdditionalTreatments",
        .custom_delivery_configuration = "CustomDeliveryConfiguration",
        .description = "Description",
        .holdout_percent = "HoldoutPercent",
        .hook = "Hook",
        .is_paused = "IsPaused",
        .limits = "Limits",
        .message_configuration = "MessageConfiguration",
        .name = "Name",
        .priority = "Priority",
        .schedule = "Schedule",
        .segment_id = "SegmentId",
        .segment_version = "SegmentVersion",
        .tags = "tags",
        .template_configuration = "TemplateConfiguration",
        .treatment_description = "TreatmentDescription",
        .treatment_name = "TreatmentName",
    };
};
