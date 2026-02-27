pub const ListWorkforcesSortByOptions = enum {
    name,
    create_date,

    pub const json_field_names = .{
        .name = "Name",
        .create_date = "CreateDate",
    };
};
