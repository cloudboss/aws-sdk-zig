pub const FeatureGroupSortBy = enum {
    name,
    feature_group_status,
    offline_store_status,
    creation_time,

    pub const json_field_names = .{
        .name = "NAME",
        .feature_group_status = "FEATURE_GROUP_STATUS",
        .offline_store_status = "OFFLINE_STORE_STATUS",
        .creation_time = "CREATION_TIME",
    };
};
