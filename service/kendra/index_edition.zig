pub const IndexEdition = enum {
    developer_edition,
    enterprise_edition,
    gen_ai_enterprise_edition,

    pub const json_field_names = .{
        .developer_edition = "DEVELOPER_EDITION",
        .enterprise_edition = "ENTERPRISE_EDITION",
        .gen_ai_enterprise_edition = "GEN_AI_ENTERPRISE_EDITION",
    };
};
