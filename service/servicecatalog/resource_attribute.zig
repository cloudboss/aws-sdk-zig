pub const ResourceAttribute = enum {
    properties,
    metadata,
    creationpolicy,
    updatepolicy,
    deletionpolicy,
    tags,

    pub const json_field_names = .{
        .properties = "PROPERTIES",
        .metadata = "METADATA",
        .creationpolicy = "CREATIONPOLICY",
        .updatepolicy = "UPDATEPOLICY",
        .deletionpolicy = "DELETIONPOLICY",
        .tags = "TAGS",
    };
};
