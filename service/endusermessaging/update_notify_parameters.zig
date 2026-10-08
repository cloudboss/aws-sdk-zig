/// The updated delivery parameters for the preapproved notify-template route.
/// Absent members preserve the current value, and the empty sentinel on a
/// member clears it.
pub const UpdateNotifyParameters = struct {
    /// The updated identifier of a preapproved notify template for the SMS or voice
    /// channels. An empty string clears the previously stored value.
    notify_template_id: ?[]const u8 = null,

    /// The updated Amazon Polly voice ID. An empty string clears the previously
    /// stored value.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .notify_template_id = "notifyTemplateId",
        .voice_id = "voiceId",
    };
};
