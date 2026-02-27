pub const ListEdgeDeploymentPlansSortBy = enum {
    name,
    device_fleet_name,
    creation_time,
    last_modified_time,

    pub const json_field_names = .{
        .name = "Name",
        .device_fleet_name = "DeviceFleetName",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};
