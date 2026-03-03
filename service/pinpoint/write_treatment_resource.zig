const CustomDeliveryConfiguration = @import("custom_delivery_configuration.zig").CustomDeliveryConfiguration;
const MessageConfiguration = @import("message_configuration.zig").MessageConfiguration;
const Schedule = @import("schedule.zig").Schedule;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;

/// Specifies the settings for a campaign treatment. A *treatment* is a
/// variation of a campaign that's used for A/B testing of a campaign.
pub const WriteTreatmentResource = struct {
    /// The delivery configuration settings for sending the treatment through a
    /// custom channel. This object is required if the MessageConfiguration object
    /// for the treatment specifies a CustomMessage object.
    custom_delivery_configuration: ?CustomDeliveryConfiguration = null,

    /// The message configuration settings for the treatment.
    message_configuration: ?MessageConfiguration = null,

    /// The schedule settings for the treatment.
    schedule: ?Schedule = null,

    /// The allocated percentage of users (segment members) to send the treatment
    /// to.
    size_percent: i32,

    /// The message template to use for the treatment.
    template_configuration: ?TemplateConfiguration = null,

    /// A custom description of the treatment.
    treatment_description: ?[]const u8 = null,

    /// A custom name for the treatment.
    treatment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_delivery_configuration = "CustomDeliveryConfiguration",
        .message_configuration = "MessageConfiguration",
        .schedule = "Schedule",
        .size_percent = "SizePercent",
        .template_configuration = "TemplateConfiguration",
        .treatment_description = "TreatmentDescription",
        .treatment_name = "TreatmentName",
    };
};
