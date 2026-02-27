const CustomDeliveryConfiguration = @import("custom_delivery_configuration.zig").CustomDeliveryConfiguration;
const MessageConfiguration = @import("message_configuration.zig").MessageConfiguration;
const Schedule = @import("schedule.zig").Schedule;
const CampaignState = @import("campaign_state.zig").CampaignState;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;

/// Specifies the settings for a campaign treatment. A *treatment* is a
/// variation of a campaign that's used for A/B testing of a campaign.
pub const TreatmentResource = struct {
    /// The delivery configuration settings for sending the treatment through a
    /// custom channel. This object is required if the MessageConfiguration object
    /// for the treatment specifies a CustomMessage object.
    custom_delivery_configuration: ?CustomDeliveryConfiguration,

    /// The unique identifier for the treatment.
    id: []const u8,

    /// The message configuration settings for the treatment.
    message_configuration: ?MessageConfiguration,

    /// The schedule settings for the treatment.
    schedule: ?Schedule,

    /// The allocated percentage of users (segment members) that the treatment is
    /// sent to.
    size_percent: i32,

    /// The current status of the treatment.
    state: ?CampaignState,

    /// The message template to use for the treatment.
    template_configuration: ?TemplateConfiguration,

    /// The custom description of the treatment.
    treatment_description: ?[]const u8,

    /// The custom name of the treatment.
    treatment_name: ?[]const u8,

    pub const json_field_names = .{
        .custom_delivery_configuration = "CustomDeliveryConfiguration",
        .id = "Id",
        .message_configuration = "MessageConfiguration",
        .schedule = "Schedule",
        .size_percent = "SizePercent",
        .state = "State",
        .template_configuration = "TemplateConfiguration",
        .treatment_description = "TreatmentDescription",
        .treatment_name = "TreatmentName",
    };
};
