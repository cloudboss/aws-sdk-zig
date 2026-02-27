pub const ResourceType = enum {
    configured_table,
    collaboration,
    membership,
    configured_table_association,

    pub const json_field_names = .{
        .configured_table = "CONFIGURED_TABLE",
        .collaboration = "COLLABORATION",
        .membership = "MEMBERSHIP",
        .configured_table_association = "CONFIGURED_TABLE_ASSOCIATION",
    };
};
