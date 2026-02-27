pub const ResourceShareAssociationType = enum {
    principal,
    resource,
    source,

    pub const json_field_names = .{
        .principal = "PRINCIPAL",
        .resource = "RESOURCE",
        .source = "SOURCE",
    };
};
