pub const DocumentFilterKey = enum {
    name,
    owner,
    platform_types,
    document_type,

    pub const json_field_names = .{
        .name = "Name",
        .owner = "Owner",
        .platform_types = "PlatformTypes",
        .document_type = "DocumentType",
    };
};
