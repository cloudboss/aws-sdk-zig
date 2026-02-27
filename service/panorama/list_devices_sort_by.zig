pub const ListDevicesSortBy = enum {
    device_id,
    created_time,
    name,
    device_aggregated_status,

    pub const json_field_names = .{
        .device_id = "DEVICE_ID",
        .created_time = "CREATED_TIME",
        .name = "NAME",
        .device_aggregated_status = "DEVICE_AGGREGATED_STATUS",
    };
};
