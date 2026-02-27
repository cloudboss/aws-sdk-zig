pub const OcsfDateField = enum {
    finding_info_created_time_dt,
    finding_info_first_seen_time_dt,
    finding_info_last_seen_time_dt,
    finding_info_modified_time_dt,
    resources_image_created_time_dt,
    resources_image_last_used_time_dt,
    resources_modified_time_dt,

    pub const json_field_names = .{
        .finding_info_created_time_dt = "FINDING_INFO_CREATED_TIME_DT",
        .finding_info_first_seen_time_dt = "FINDING_INFO_FIRST_SEEN_TIME_DT",
        .finding_info_last_seen_time_dt = "FINDING_INFO_LAST_SEEN_TIME_DT",
        .finding_info_modified_time_dt = "FINDING_INFO_MODIFIED_TIME_DT",
        .resources_image_created_time_dt = "RESOURCES_IMAGE_CREATED_TIME_DT",
        .resources_image_last_used_time_dt = "RESOURCES_IMAGE_LAST_USED_TIME_DT",
        .resources_modified_time_dt = "RESOURCES_MODIFIED_TIME_DT",
    };
};
