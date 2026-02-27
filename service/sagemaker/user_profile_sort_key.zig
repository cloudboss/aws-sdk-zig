pub const UserProfileSortKey = enum {
    creation_time,
    last_modified_time,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};
