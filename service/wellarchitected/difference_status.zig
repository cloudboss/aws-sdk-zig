pub const DifferenceStatus = enum {
    updated,
    new,
    deleted,

    pub const json_field_names = .{
        .updated = "UPDATED",
        .new = "NEW",
        .deleted = "DELETED",
    };
};
