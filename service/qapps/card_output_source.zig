pub const CardOutputSource = enum {
    approved_sources,
    llm,

    pub const json_field_names = .{
        .approved_sources = "APPROVED_SOURCES",
        .llm = "LLM",
    };
};
