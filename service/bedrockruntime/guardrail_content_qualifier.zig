pub const GuardrailContentQualifier = enum {
    grounding_source,
    query,
    guard_content,

    pub const json_field_names = .{
        .grounding_source = "GROUNDING_SOURCE",
        .query = "QUERY",
        .guard_content = "GUARD_CONTENT",
    };
};
