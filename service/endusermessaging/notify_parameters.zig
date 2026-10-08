/// The delivery parameters for the preapproved notify-template route over the
/// SMS or voice channels.
pub const NotifyParameters = struct {
    /// The identifier of a preapproved notify template for the SMS or voice
    /// channels.
    notify_template_id: ?[]const u8 = null,

    /// The Amazon Polly voice ID used when the notify template is delivered over
    /// the voice channel.
    voice_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .notify_template_id = "notifyTemplateId",
        .voice_id = "voiceId",
    };
};
