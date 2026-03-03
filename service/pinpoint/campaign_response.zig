const aws = @import("aws");

const TreatmentResource = @import("treatment_resource.zig").TreatmentResource;
const CustomDeliveryConfiguration = @import("custom_delivery_configuration.zig").CustomDeliveryConfiguration;
const CampaignState = @import("campaign_state.zig").CampaignState;
const CampaignHook = @import("campaign_hook.zig").CampaignHook;
const CampaignLimits = @import("campaign_limits.zig").CampaignLimits;
const MessageConfiguration = @import("message_configuration.zig").MessageConfiguration;
const Schedule = @import("schedule.zig").Schedule;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;

/// Provides information about the status, configuration, and other settings for
/// a campaign.
pub const CampaignResponse = struct {
    /// An array of responses, one for each treatment that you defined for the
    /// campaign, in addition to the default treatment.
    additional_treatments: ?[]const TreatmentResource = null,

    /// The unique identifier for the application that the campaign applies to.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the campaign.
    arn: []const u8,

    /// The date, in ISO 8601 format, when the campaign was created.
    creation_date: []const u8,

    /// The delivery configuration settings for sending the campaign through a
    /// custom channel.
    custom_delivery_configuration: ?CustomDeliveryConfiguration = null,

    /// The current status of the campaign's default treatment. This value exists
    /// only for campaigns that have more than one treatment.
    default_state: ?CampaignState = null,

    /// The custom description of the campaign.
    description: ?[]const u8 = null,

    /// The allocated percentage of users (segment members) who shouldn't receive
    /// messages from the campaign.
    holdout_percent: ?i32 = null,

    /// The settings for the AWS Lambda function to use as a code hook for the
    /// campaign. You can use this hook to customize the segment that's used by the
    /// campaign.
    hook: ?CampaignHook = null,

    /// The unique identifier for the campaign.
    id: []const u8,

    /// Specifies whether the campaign is paused. A paused campaign doesn't run
    /// unless you resume it by changing this value to false.
    is_paused: ?bool = null,

    /// The date, in ISO 8601 format, when the campaign was last modified.
    last_modified_date: []const u8,

    /// The messaging limits for the campaign.
    limits: ?CampaignLimits = null,

    /// The message configuration settings for the campaign.
    message_configuration: ?MessageConfiguration = null,

    /// The name of the campaign.
    name: ?[]const u8 = null,

    /// Defines the priority of the campaign, used to decide the order of messages
    /// displayed to user if there are multiple messages scheduled to be displayed
    /// at the same moment.
    priority: ?i32 = null,

    /// The schedule settings for the campaign.
    schedule: ?Schedule = null,

    /// The unique identifier for the segment that's associated with the campaign.
    segment_id: []const u8,

    /// The version number of the segment that's associated with the campaign.
    segment_version: i32,

    /// The current status of the campaign.
    state: ?CampaignState = null,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the campaign. Each tag consists of a required tag key and an
    /// associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The message template that’s used for the campaign.
    template_configuration: ?TemplateConfiguration = null,

    /// The custom description of the default treatment for the campaign.
    treatment_description: ?[]const u8 = null,

    /// The custom name of the default treatment for the campaign, if the campaign
    /// has multiple treatments. A *treatment* is a variation of a campaign that's
    /// used for A/B testing.
    treatment_name: ?[]const u8 = null,

    /// The version number of the campaign.
    version: ?i32 = null,

    pub const json_field_names = .{
        .additional_treatments = "AdditionalTreatments",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .creation_date = "CreationDate",
        .custom_delivery_configuration = "CustomDeliveryConfiguration",
        .default_state = "DefaultState",
        .description = "Description",
        .holdout_percent = "HoldoutPercent",
        .hook = "Hook",
        .id = "Id",
        .is_paused = "IsPaused",
        .last_modified_date = "LastModifiedDate",
        .limits = "Limits",
        .message_configuration = "MessageConfiguration",
        .name = "Name",
        .priority = "Priority",
        .schedule = "Schedule",
        .segment_id = "SegmentId",
        .segment_version = "SegmentVersion",
        .state = "State",
        .tags = "tags",
        .template_configuration = "TemplateConfiguration",
        .treatment_description = "TreatmentDescription",
        .treatment_name = "TreatmentName",
        .version = "Version",
    };
};
