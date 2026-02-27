pub const ReplacementTypeEnum = enum {
    keep_base,
    keep_source,
    keep_destination,
    use_new_content,

    pub const json_field_names = .{
        .keep_base = "KEEP_BASE",
        .keep_source = "KEEP_SOURCE",
        .keep_destination = "KEEP_DESTINATION",
        .use_new_content = "USE_NEW_CONTENT",
    };
};
