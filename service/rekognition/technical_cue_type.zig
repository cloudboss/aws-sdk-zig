pub const TechnicalCueType = enum {
    color_bars,
    end_credits,
    black_frames,
    opening_credits,
    studio_logo,
    slate,
    content,

    pub const json_field_names = .{
        .color_bars = "COLOR_BARS",
        .end_credits = "END_CREDITS",
        .black_frames = "BLACK_FRAMES",
        .opening_credits = "OPENING_CREDITS",
        .studio_logo = "STUDIO_LOGO",
        .slate = "SLATE",
        .content = "CONTENT",
    };
};
