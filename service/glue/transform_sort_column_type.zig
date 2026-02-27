pub const TransformSortColumnType = enum {
    name,
    transform_type,
    status,
    created,
    last_modified,

    pub const json_field_names = .{
        .name = "NAME",
        .transform_type = "TRANSFORM_TYPE",
        .status = "STATUS",
        .created = "CREATED",
        .last_modified = "LAST_MODIFIED",
    };
};
