pub const ResourcesDateField = enum {
    resource_detail_capture_time_dt,
    resource_creation_time_dt,

    pub const json_field_names = .{
        .resource_detail_capture_time_dt = "RESOURCE_DETAIL_CAPTURE_TIME_DT",
        .resource_creation_time_dt = "RESOURCE_CREATION_TIME_DT",
    };
};
