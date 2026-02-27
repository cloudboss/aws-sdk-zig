pub const ExportType = enum {
    alexa_skills_kit,
    lex,

    pub const json_field_names = .{
        .alexa_skills_kit = "ALEXA_SKILLS_KIT",
        .lex = "LEX",
    };
};
