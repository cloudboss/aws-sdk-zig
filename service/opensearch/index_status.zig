pub const IndexStatus = enum {
    created,
    updated,
    deleted,

    pub const json_field_names = .{
        .created = "CREATED",
        .updated = "UPDATED",
        .deleted = "DELETED",
    };
};
