pub const SystemInstanceFilterName = enum {
    system_template_id,
    status,
    greengrass_group_name,

    pub const json_field_names = .{
        .system_template_id = "SYSTEM_TEMPLATE_ID",
        .status = "STATUS",
        .greengrass_group_name = "GREENGRASS_GROUP_NAME",
    };
};
