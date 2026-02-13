pub const OpsItemRelatedItemsFilterKey = enum {
    resource_type,
    association_id,
    resource_uri,

    pub const json_field_names = .{
        .resource_type = "RESOURCE_TYPE",
        .association_id = "ASSOCIATION_ID",
        .resource_uri = "RESOURCE_URI",
    };
};
