pub const ConfigurationItemStatus = enum {
    ok,
    resource_discovered,
    resource_not_recorded,
    resource_deleted,
    resource_deleted_not_recorded,

    pub const json_field_names = .{
        .ok = "OK",
        .resource_discovered = "ResourceDiscovered",
        .resource_not_recorded = "ResourceNotRecorded",
        .resource_deleted = "ResourceDeleted",
        .resource_deleted_not_recorded = "ResourceDeletedNotRecorded",
    };
};
