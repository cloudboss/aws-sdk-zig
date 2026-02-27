pub const HubSortBy = enum {
    hub_name,
    creation_time,
    hub_status,
    account_id_owner,

    pub const json_field_names = .{
        .hub_name = "HUB_NAME",
        .creation_time = "CREATION_TIME",
        .hub_status = "HUB_STATUS",
        .account_id_owner = "ACCOUNT_ID_OWNER",
    };
};
