pub const SharePointVersion = enum {
    sharepoint_2013,
    sharepoint_2016,
    sharepoint_online,
    sharepoint_2019,

    pub const json_field_names = .{
        .sharepoint_2013 = "SHAREPOINT_2013",
        .sharepoint_2016 = "SHAREPOINT_2016",
        .sharepoint_online = "SHAREPOINT_ONLINE",
        .sharepoint_2019 = "SHAREPOINT_2019",
    };
};
