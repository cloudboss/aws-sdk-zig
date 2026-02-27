const AlexaSkillStatus = @import("alexa_skill_status.zig").AlexaSkillStatus;

/// The Alexa Skill configuration of a SIP media application.
///
/// Due to changes made by the Amazon Alexa service, this data type is no longer
/// available for use. For more information, refer to
/// the [Alexa Smart
/// Properties](https://developer.amazon.com/en-US/alexa/alexasmartproperties)
/// page.
pub const SipMediaApplicationAlexaSkillConfiguration = struct {
    /// The ID of the Alexa Skill configuration.
    alexa_skill_ids: []const []const u8,

    /// The status of the Alexa Skill configuration.
    alexa_skill_status: AlexaSkillStatus,

    pub const json_field_names = .{
        .alexa_skill_ids = "AlexaSkillIds",
        .alexa_skill_status = "AlexaSkillStatus",
    };
};
