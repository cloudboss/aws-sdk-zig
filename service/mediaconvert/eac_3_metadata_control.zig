/// When set to FOLLOW_INPUT, encoder metadata will be sourced from the DD, DD+,
/// or DolbyE decoder that supplied this audio data. If audio was not supplied
/// from one of these streams, then the static metadata settings will be used.
pub const Eac3MetadataControl = enum {
    follow_input,
    use_configured,

    pub const json_field_names = .{
        .follow_input = "FOLLOW_INPUT",
        .use_configured = "USE_CONFIGURED",
    };
};
