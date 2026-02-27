pub const VoiceMessageBodyTextType = enum {
    text,
    ssml,

    pub const json_field_names = .{
        .text = "TEXT",
        .ssml = "SSML",
    };
};
