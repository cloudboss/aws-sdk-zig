/// Dash Role Caption
pub const DashRoleCaption = enum {
    alternate,
    caption,
    commentary,
    description,
    dub,
    easyreader,
    emergency,
    forced_subtitle,
    karaoke,
    main,
    metadata,
    subtitle,
    supplementary,

    pub const json_field_names = .{
        .alternate = "ALTERNATE",
        .caption = "CAPTION",
        .commentary = "COMMENTARY",
        .description = "DESCRIPTION",
        .dub = "DUB",
        .easyreader = "EASYREADER",
        .emergency = "EMERGENCY",
        .forced_subtitle = "FORCED_SUBTITLE",
        .karaoke = "KARAOKE",
        .main = "MAIN",
        .metadata = "METADATA",
        .subtitle = "SUBTITLE",
        .supplementary = "SUPPLEMENTARY",
    };
};
