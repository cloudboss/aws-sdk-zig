/// Audio Description Audio Type Control
pub const AudioDescriptionAudioTypeControl = enum {
    follow_input,
    use_configured,

    pub const json_field_names = .{
        .follow_input = "FOLLOW_INPUT",
        .use_configured = "USE_CONFIGURED",
    };
};
