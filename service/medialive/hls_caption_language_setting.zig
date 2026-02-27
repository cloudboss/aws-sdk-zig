/// Hls Caption Language Setting
pub const HlsCaptionLanguageSetting = enum {
    insert,
    none,
    omit,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
        .omit = "OMIT",
    };
};
