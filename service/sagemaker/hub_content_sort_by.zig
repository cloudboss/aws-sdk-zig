pub const HubContentSortBy = enum {
    hub_content_name,
    creation_time,
    hub_content_status,

    pub const json_field_names = .{
        .hub_content_name = "HUB_CONTENT_NAME",
        .creation_time = "CREATION_TIME",
        .hub_content_status = "HUB_CONTENT_STATUS",
    };
};
