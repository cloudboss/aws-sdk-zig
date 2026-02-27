pub const ChangeTypeEnum = enum {
    added,
    modified,
    deleted,

    pub const json_field_names = .{
        .added = "ADDED",
        .modified = "MODIFIED",
        .deleted = "DELETED",
    };
};
